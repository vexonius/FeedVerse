//
//  Persistance.swift
//  FeedVerse
//
//  Created by Tino Emer on 12.04.2022..
//

import Foundation
import RxSwift
import GRDB
import RxGRDB

typealias DBModel = PersistableRecord & FetchableRecord

protocol DatabaseClientProvider {
    func observeModels<T: DBModel>(type _: T.Type) -> Observable<[T]>
    func fetchAll<T: DBModel>(type _: T.Type) -> Observable<[T]>
    func save<T: DBModel>(model: T) -> Completable
    func saveAll<T: DBModel>(models: [T]) -> Completable
    func delete<T: DBModel>(model: T) -> Completable
}

final class DatabaseClient {

    private static let dbName = "db.sqlite"

    static var migrator: DatabaseMigrator {

        var migrator = DatabaseMigrator()

        migrator.eraseDatabaseOnSchemaChange = true

        migrator.registerMigration("createPublication") { db in
            try db.create(table: "publication") { t in
                t.column("id", .text)
                    .primaryKey(onConflict: .replace, autoincrement: false)
                    .notNull(onConflict: .replace)
                t.column("title", .text).notNull()
                t.column("description", .text).notNull()
                t.column("link", .text).notNull()
                t.column("imageUrl", .text)
                t.column("rssLink", .text).notNull()
            }
        }

        migrator.registerMigration("createArticle") { db in
            try db.create(table: "article") { t in
                t.column("id", .text)
                    .primaryKey(onConflict: .replace, autoincrement: false)
                    .notNull(onConflict: .replace)
                t.column("publicationId", .text).notNull().references("publication", onDelete: .cascade)
                t.column("title", .text).notNull()
                t.column("description", .text).notNull()
                t.column("link", .text).notNull()
                t.column("date", .date)
                t.column("coverUrl", .text)
            }
        }

        return migrator
    }

    private var dbQueue: DatabaseQueue

    init() throws {
        let databaseURL = try FileManager.default
            .url(for: .applicationDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent(DatabaseClient.dbName)

        dbQueue = try DatabaseQueue(path: databaseURL.path)
        try DatabaseClient.migrator.migrate(dbQueue)
    }

}

extension DatabaseClient: DatabaseClientProvider {

    func fetchAll<T: DBModel>(type _: T.Type) -> Observable<[T]> {
        dbQueue.rx.read { db in
            try T.fetchAll(db)
        }
        .catch({ error in
            debugPrint(error)
            return .error(DatabaseError.writeError)
        })
            .asObservable()
    }

    func observeModels<T: DBModel>(type _: T.Type) -> Observable<[T]> {
        let modelObservation = ValueObservation.tracking { db in
            try T.fetchAll(db)
        }

        return modelObservation.rx.observe(in: dbQueue, scheduling: .async(onQueue: .global()))
    }

    func save<T: DBModel>(model: T) -> Completable {
        dbQueue.rx.write { db in
            try model.insert(db)
        }
        .catch({ error in
            debugPrint(error)
            return .error(DatabaseError.writeError)
        })
            .asCompletable()
    }

    func saveAll<T: DBModel>(models: [T]) -> Completable {
        dbQueue.rx.write { db in
            for model in models {
                try model.insert(db)
            }
        }
        .catch({ error in
            debugPrint(error)
            return .error(DatabaseError.writeError)
        })
            .asCompletable()
    }

    func delete<T: DBModel>(model: T) -> Completable {
        dbQueue.rx.write { db in
            try model.delete(db)
        }
        .catch({ error in
            debugPrint(error)
            return .error(DatabaseError.writeError)
        })
            .asCompletable()
    }

}

enum DatabaseError: Error {
    case readError
    case writeError
}
