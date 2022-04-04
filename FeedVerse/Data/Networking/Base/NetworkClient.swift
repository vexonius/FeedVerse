//
//  HttpClient.swift
//  FeedVerse
//
//  Created by Tino Emer on 04.04.2022..
//

import Foundation
import RxSwift
import Alamofire
import RxAlamofire
import XMLCoder

protocol NetworkClientProvider {
    func get<T: Decodable>(path: String, params: [String: String], headers: [String: String], encoding: URLEncoding, responseType: T.Type) -> Single<T>
    func head<T: Decodable>(path: String, params: [String: String], headers: [String: String], encoding: URLEncoding, responseType: T.Type) -> Single<T>
}

protocol ResponseDecoder {
    func decode<T: Decodable>(_ data: Data) throws -> T
}

final class NetworkClient {

    private func decode<T: Decodable>(data: Data, decoder: ResponseDecoder) throws -> T {
        return try decoder.decode(data)
    }

    private func parseResponseError(code: Int) -> NetworkClientError {
        switch code {
            case 400..<500:
                return .clientError
            case 500..<600:
                return .serverError
            case -1009:
                return .noConnection
            default:
                return .generic
        }
    }

}

extension NetworkClient: NetworkClientProvider {

    func get<T: Decodable>(path: String, params: [String: String] = [:] , headers: [String: String] = [:], encoding: URLEncoding = .default, responseType: T.Type) -> Single<T> {
        RxAlamofire.request(.get, path, parameters: params, encoding: encoding, headers: HTTPHeaders(headers))
            .validate(statusCode: 200...302)
            .data()
            .catch({ [weak self] error in
                debugPrint(error)
                guard let self = self, let errorCode = error.asAFError?.responseCode else {
                    return .error(NetworkClientError.generic)

                }
                return .error(self.parseResponseError(code: errorCode))
            })
            .flatMap { [weak self] data -> Single<T> in
                guard let decodedResponse: T = try? self?.decode(data: data, decoder: CustomXMLDecoder()) else {
                    return Single.error(NetworkClientError.decodingFailed)
                }

                return Single.just(decodedResponse)
            }
            .asSingle()
    }

    func head<T: Decodable>(path: String, params: [String: String] = [:], headers: [String: String] = [:], encoding: URLEncoding = .default, responseType: T.Type) -> Single<T> {
        RxAlamofire.request(.head, path, parameters: params, encoding: encoding, headers: HTTPHeaders(headers))
            .validate(statusCode: 200...302)
            .data()
            .catch({ [weak self] error in
                debugPrint(error)
                guard let self = self, let errorCode = error.asAFError?.responseCode else {
                    return .error(NetworkClientError.generic)

                }
                return .error(self.parseResponseError(code: errorCode))
            })
            .flatMap { [weak self] data -> Single<T> in
                guard let decodedResponse: T = try? self?.decode(data: data, decoder: CustomXMLDecoder()) else {
                    return Single.error(NetworkClientError.decodingFailed)
                }

                return Single.just(decodedResponse)
            }
            .asSingle()
    }

}

final class CustomXMLDecoder: ResponseDecoder {
    private let decoder = XMLDecoder()

    func decode<T: Decodable>(_ data: Data) throws -> T {
        return try decoder.decode(T.self, from: data)
    }
}

enum NetworkClientError: Error {
    case clientError
    case noConnection
    case decodingFailed
    case serverError
    case generic
}
