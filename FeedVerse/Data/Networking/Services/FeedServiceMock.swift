//
//  FeedServiceMock.swift
//  FeedVerse
//
//  Created by Tino Emer on 03.04.2022..
//

import Foundation
import RxSwift
import XMLCoder

final class FeedServiceMock {

    func fetchRSSFeed(url: String) -> Single<Feed> {
        let data = Data(mockedData.utf8)

        return Single<Feed>.create { [weak self] single in
            let parser = XMLDecoder()

            guard let feedDTO = try? parser.decode(FeedDTO.self, from: data) else {
                single(.failure(NetworkClientError.decodingFailed))
                return Disposables.create()
            }

            guard let feed = self?.flattenFeedDTO(from: feedDTO) else {
                 single(.failure(NetworkClientError.decodingFailed))
                return Disposables.create()
            }

            single(.success(feed))
            return Disposables.create()
        }
    }

    private func flattenFeedDTO(from feedDTO: FeedDTO) -> Feed {
        Feed(
            publication: Publication(from: feedDTO.publication),
            articles: feedDTO.publication.articles.map { Article(from: $0) }
        )
    }

    let mockedData = """
<?xml version="1.0" encoding="utf-8" ?> <rss version="2.0" xml:base="https://news.un.org/en/" xmlns:atom="http://www.w3.org/2005/Atom" xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd" xmlns:yandex="http://news.yandex.ru" xmlns:media="http://search.yahoo.com/mrss/"> <channel> <title>UN News - Europe</title>
 <description><![CDATA[Global perspective, human stories]]></description>
 <link>https://news.un.org/en/</link>
 <atom:link rel="self" href="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
 <language>en</language>
 <image> <url>https://news.un.org/en/sites/all/themes/bootstrap_un_news/images/un-emblem-for-rss.png</url>
 <title>UN News</title>
 <link>https://news.un.org/en/</link>
 <description>Global perspective, human stories</description>
 <width>144</width>
 <height>144</height>
</image>
 <copyright>Copyright © 2022 United Nations</copyright>
 <generator>United Nations</generator>
 <item> <title>First Person: ‘I fear I will never see my husband again’</title>
 <link>https://news.un.org/feed/view/en/story/2022/04/1115242</link>
 <description><![CDATA[Nataliia Vladimirova fled her home in Kharkiv, Ukraine, on the first day of the Russian invasion, on 24 February, with her four-year-old daughter Oleksandra and mother-in-law. They are amongst the thousands of Ukrainian refugees with temporary protection status in Portugal. She shares her heart-wrenching story of family separation and loss, with UN News.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/16-03-2022_WFP_Ukraine-0.jpg/image770x420cropped.jpg" length="55204" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/04/1115242</guid>
 <pubDate>Fri, 01 Apr 2022 00:01:55 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine: Second UN convoy reaches Sumy, Mariupol access thwarted</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1115252</link>
 <description><![CDATA[UN humanitarian agencies and partners on the ground in Ukraine, were able to reach the town of Sumy, in the country’s northeast on Thursday, but access to the besieged and stricken city of Mariupol, where thousands of civilians are believed to have died amidst the brutal Russian bombardment, has yet to be given.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/31-03-2022-UNOCHA_Ukraine-1.jpg/image770x420cropped.jpg" length="69809" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1115252</guid>
 <pubDate>Thu, 31 Mar 2022 16:46:28 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine: UNESCO’s response to children’s education needs</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1115122</link>
 <description><![CDATA[Since the start of Russia’s invasion of Ukraine, more than 4 million people have fled the country - two million of them, are children. As the UN agency mandated to coordinate and lead on global education, UNESCO is carefully mapping exactly how host countries are supporting and providing education, to help keep young Ukrainian refugees on track - their lives totally upended in a matter of weeks.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/30-03-2022-UNICEF-UN0605083-Ukraine.jpg/image770x420cropped.jpg" length="63639" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1115122</guid>
 <pubDate>Wed, 30 Mar 2022 14:19:27 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title> Ukraine war: Russia used cluster weapons at least 24 times, says UN’s Bachelet</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1115092</link>
 <description><![CDATA[Credible reports indicate that Russian armed forces have used cluster munitions in populated areas of Ukraine, at least two dozen times since they invaded on 24 February, UN rights chief Michelle Bachelet said on Wednesday.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/30-03-2021_UNICEF_Ukraine.jpg/image770x420cropped.jpg" length="58269" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1115092</guid>
 <pubDate>Wed, 30 Mar 2022 11:34:47 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>‘Difficult months ahead’ in Ukraine, as deaths rise, along with global shortages</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1115042</link>
 <description><![CDATA[At least 1,100 civilians have been killed in a month of fighting in Ukraine, a senior UN humanitarian official told the Security Council on Tuesday, stressing that the conflict “shows no signs of abating.”]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/29-03-2022_UNICEF_Ukraine-01.jpg/image770x420cropped.jpg" length="37755" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1115042</guid>
 <pubDate>Tue, 29 Mar 2022 17:49:50 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>World football goes for goal, in aid of Ukraine</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114982</link>
 <description><![CDATA[With the number of refugees fleeing Ukraine rapidly approaching four million, the UN refugee agency (UNHCR) and the World Food Programme (WFP) on Wednesday launched a new emergency appeal, with an assist from some top football players who know firsthand what it’s like to flee for your life from a warzone.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/29-03-2022-UNHCR_Ukraine.jpg/image770x420cropped.jpg" length="48119" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114982</guid>
 <pubDate>Tue, 29 Mar 2022 11:55:26 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine invasion: Guterres appeals for ‘immediate humanitarian ceasefire’</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114872</link>
 <description><![CDATA[The UN Secretary-General appealed for an immediate humanitarian ceasefire in Ukraine on Monday, so that “serious political negotiations” can advance towards a peace agreement, based on the principles of the United Nations Charter.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/27-02-2022_UNICEF_Ukraine-21.jpg/image770x420cropped.jpg" length="104105" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114872</guid>
 <pubDate>Mon, 28 Mar 2022 12:18:45 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>UN alarm over mounting Ukraine casualties, amid desperate scenes in Mariupol</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114692</link>
 <description><![CDATA[Ongoing violence in Ukraine has left millions of people “in constant fear” of indiscriminate shelling, the UN warned on Friday, as efforts continued to reach the country’s most vulnerable populations, one month on from the Russian invasion.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Collections/UNHCR/Embargoed+2/18-03-2022_UNICEF_Ukraine-03.jpg/image770x420cropped.jpg" length="73290" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114692</guid>
 <pubDate>Fri, 25 Mar 2022 11:15:52 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine: General Assembly passes resolution demanding aid access, by large majority</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114632</link>
 <description><![CDATA[The UN General Assembly overwhelmingly demanded civilian protection and humanitarian access in Ukraine on Thursday, while also criticizing Russia for creating a “dire” humanitarian situation resulting from its invasion exactly one month ago.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/22-03-2022_WHO_Ukraine_2.jpg/image770x420cropped.jpg" length="70068" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114632</guid>
 <pubDate>Thu, 24 Mar 2022 15:42:16 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>One month of war leaves more than half of Ukraine’s children displaced</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114592</link>
 <description><![CDATA[A month since Russia invaded Ukraine, 4.3 million children – more than half of the country’s estimated 7.5 million child population – have been displaced, the UN Children’s Fund (UNICEF) said on Thursday.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Collections/UNHCR/Embargoed+2/18-03-2022_UNICEF_Ukraine-06.jpg/image770x420cropped.jpg" length="59287" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114592</guid>
 <pubDate>Thu, 24 Mar 2022 11:22:40 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine: Competing drafts on humanitarian assistance debated at General Assembly </title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114552</link>
 <description><![CDATA[The UN General Assembly met on Wednesday for its second emergency session on the Ukraine crisis since Russia invaded the country on 24 February, with two similar but different resolutions placed before delegates, addressing the unfolding humanitarian crisis. ]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/23-03-2022_UN-Photo_-Kyslytsya.jpg/image770x420cropped.jpg" length="50133" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114552</guid>
 <pubDate>Wed, 23 Mar 2022 15:01:42 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>First Person: Keeping aid flowing during Ukraine’s health crisis</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114442</link>
 <description><![CDATA[Jarno Habicht has worked with WHO for the last 19 years and served as WHO Representative in Ukraine since 2018. He explains how WHO prepared for armed conflict in the country, and how it has responded to health-related issues since the Russian invasion.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/22-03-2022_WHO_Jarno-Habicht.jpg/image770x420cropped.jpg" length="77201" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114442</guid>
 <pubDate>Tue, 22 Mar 2022 22:02:31 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Time to negotiate end to ‘unwinnable’ war in Ukraine, Guterres declares</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114392</link>
 <description><![CDATA[It’s time for a diplomatic solution to be found to end Russia’s invasion of Ukraine, amidst signs of hope that progress can be made to end an “unwinnable” and “indefensible” war, said the UN chief on Tuesday.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/22-03-2022_WHO_Ukraine-01.jpg/image770x420cropped.jpg" length="48897" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114392</guid>
 <pubDate>Tue, 22 Mar 2022 10:37:09 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>First Person: Witnessing the pain of Ukraine refugees wrenched apart</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114372</link>
 <description><![CDATA[The UN has helped tens of thousands of Ukrainian refugees to cross into Poland and other neighbouring countries. Chris Melzer, spokesperson for the UN refugee agency (UNHCR) in Germany, told UN News that he has witnessed many traumatic scenes, of families ripped apart by the crisis.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/01-03-2022_UNHCR_Ukraine.jpg/image770x420cropped.jpg" length="71063" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114372</guid>
 <pubDate>Mon, 21 Mar 2022 19:02:55 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>No sign of Ukraine bioweapons labs says disarmament chief, after further Russian claims </title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114272</link>
 <description><![CDATA[The UN is not aware of any biological weapons programme being conducted in Ukraine, the Organization’s disarmament chief told the Security Council once more on Friday, responding to fresh allegations by the Russian Federation, that it had evidence to the contrary.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/02-03-2022_IAEA_Ukraine-2.jpg/image770x420cropped.jpg" length="31390" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114272</guid>
 <pubDate>Fri, 18 Mar 2022 15:22:12 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine invasion: Needs keep growing with cities facing ‘fatal shortages’; breakthrough as UN convoy reaches Sumy</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114232</link>
 <description><![CDATA[After a missile attack near the airport in Lviv in western Ukraine early on Friday, UN humanitarians warned that the situation across the country remains dire, as Russia’s military invasion continues.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Collections/UNHCR/Embargoed+2/16-03-2022_IOM_Ukraine-02.jpg/image770x420cropped.jpg" length="46917" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114232</guid>
 <pubDate>Fri, 18 Mar 2022 11:45:59 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine: Civilian death toll demands full investigation and accountability, Security Council told</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114182</link>
 <description><![CDATA[The magnitude of civilian casualties and destruction of civilian infrastructure in Ukraine cannot be denied, the UN political chief told the Security Council on Thursday, demanding a thorough investigation and accountability.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/16-03-2022_UNICEF_Ukraine-5.jpg/image770x420cropped.jpg" length="49987" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114182</guid>
 <pubDate>Thu, 17 Mar 2022 19:27:42 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>UK border reform bill treats vulnerable newcomers like criminals: Bachelet </title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114092</link>
 <description><![CDATA[The UN’s top rights official  urged the United Kingdom on Friday to reconsider proposed changes to its border policy, warning that suggested reforms would criminalize vulnerable people for entering the country irregularly. ]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/17-03-2022_UNICEF_France.jpg/image770x420cropped.jpg" length="52299" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114092</guid>
 <pubDate>Thu, 17 Mar 2022 09:46:18 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>International Court orders Russia to ‘immediately suspend’ military operations in Ukraine</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114052</link>
 <description><![CDATA[Russia must immediately suspend military operations in Ukraine, the UN International Court of Justice (ICJ) ruled on Wednesday, in The Hague.

 ]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/16-03-2022_ICJ.jpg/image770x420cropped.jpg" length="58807" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114052</guid>
 <pubDate>Wed, 16 Mar 2022 13:24:01 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine war: $100 billion in infrastructure damage, and counting</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1114022</link>
 <description><![CDATA[War in Ukraine risks seeing 90 per cent of the country “freefall into poverty” and extreme vulnerability, nearly three weeks since Russia invaded its neighbour, a new UN report said on Wednesday.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/14-03-2022_WFP_Ukraine-01.jpg/image770x420cropped.jpg" length="75373" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1114022</guid>
 <pubDate>Wed, 16 Mar 2022 08:11:47 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine war creating a child refugee almost every second: UNICEF</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113942</link>
 <description><![CDATA[Almost one child per second in Ukraine is becoming a refugee of the war, UN humanitarians said on Tuesday, as the total number of people who have now fled the country since the Russian invasion began, passed three million.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/14-03-2022_WFP_Ukraine-02.jpg/image770x420cropped.jpg" length="51567" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113942</guid>
 <pubDate>Tue, 15 Mar 2022 11:26:33 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine war ‘most severe’ test ever for European security body</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113912</link>
 <description><![CDATA[The war in Ukraine is the most severe test the Organization for Security and Cooperation in Europe (OSCE) has faced since its creation in 1975, the top UN political affairs official told the Security Council on Monday, as the 15-member organ held its annual briefing on the OSCE’s work against the backdrop of intensifying bombardments of key Ukrainian cities.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/14-03-2022_ICRC_Ukraine.jpg/image770x420cropped.jpg" length="50674" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113912</guid>
 <pubDate>Mon, 14 Mar 2022 15:12:29 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine health facilities ‘stretched to breaking point’, warns WHO</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113902</link>
 <description><![CDATA[The World Health Organisation (WHO) warned on Monday that it is working “day and night” to keep medical supply chains open and preserve the health system in Ukraine, where, it says, medical facilities are stretched to breaking point.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/14-03-2022_UNICEF-Ukraine.jpg/image770x420cropped.jpg" length="52409" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113902</guid>
 <pubDate>Mon, 14 Mar 2022 13:59:17 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Ukraine: ‘We need peace now’ declares Guterres, warning of global hunger meltdown</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113882</link>
 <description><![CDATA[Ukraine is being “decimated before the eyes of the world” with Russia’s military offensive against civilians “reaching terrifying proportions”, said the UN chief on Monday, warning that a resulting meltdown of the global economy is provoking a hunger crisis that is hitting the poorest, hardest.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/10-03-2022-UNICEF-UN0601018-Ukraine.jpg/image770x420cropped.jpg" length="53626" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113882</guid>
 <pubDate>Mon, 14 Mar 2022 13:01:16 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>To attack babies is ‘an act of unconscionable cruelty’: UN top officials urge end to attacks on health care in Ukraine</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113842</link>
 <description><![CDATA[Since Russia invaded Ukraine, 31 attacks on health care have been documented by the World Health Organization. These incidents have killed and injured civilians, as well as destroyed facilities and ambulances, disrupting access to essential health services.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/05-03-2022_UNICEF_Ukraine-02.jpg/image770x420cropped.jpg" length="26807" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113842</guid>
 <pubDate>Sun, 13 Mar 2022 13:14:44 -0400</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Russian attacks on civilian targets in Ukraine could be a war crime: UN rights office</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113782</link>
 <description><![CDATA[The UN rights office, OHCHR, reiterated deep concern on Friday at the increasing number of civilian casualties in Ukraine following the Russian invasion which began on 24 February, before issuing a reminder to Moscow that any targeting of non-combatants could be a war crime.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/10-03-2022-UNICEF-UN0601036-Ukraine.jpg/image770x420cropped.jpg" length="42957" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113782</guid>
 <pubDate>Fri, 11 Mar 2022 11:34:08 -0500</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>UN rights experts raise alarm over Russia’s ‘choking’ media clampdown at home</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113762</link>
 <description><![CDATA[The recent adoption by Russia of a punitive “fake war news” law is an alarming move by the Government to gag and blindfold an entire population, independent UN human rights experts said on Friday.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/27-02-2022_UNICEF_Ukraine-22.jpg/image770x420cropped.jpg" length="80561" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113762</guid>
 <pubDate>Fri, 11 Mar 2022 09:23:41 -0500</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>UN and partners boost presence and aid supplies inside Ukraine</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113722</link>
 <description><![CDATA[Humanitarians are deploying extra staff across Ukraine to aid the growing number of civilians sheltering from Russian bombardment, or fleeing the violence, the UN Spokesperson said on Thursday.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/10-03-2022-UNICEF_Ukraine-4.jpg/image770x420cropped.jpg" length="99179" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113722</guid>
 <pubDate>Thu, 10 Mar 2022 15:27:10 -0500</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>Invasion of Ukraine: Neighbours struggle with refugee influx; UN expresses &#039;horror&#039; at Mariupol hospital attack</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113652</link>
 <description><![CDATA[The exodus of millions of Ukrainians from their country following the Russian invasion could overwhelm neighbouring countries, UN humanitarians warned on Wednesday, as the head of the UN Children’s Fund, expressed her horror over the reported destruction of a maternity hospital in the stricken coastal city of Mariupol, which has been under heavy bombardment for days.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Production+Library/05-03-2022_UNICEF_Ukraine.jpg/image770x420cropped.jpg" length="25676" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113652</guid>
 <pubDate>Wed, 09 Mar 2022 16:11:26 -0500</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
 <item> <title>UNESCO bolsters protection for Ukrainian heritage under fire</title>
 <link>https://news.un.org/feed/view/en/story/2022/03/1113602</link>
 <description><![CDATA[The UN Educational, Scientific and Cultural Organization, UNESCO, has said that it is taking measures as best it can, to try and protect some of Ukraine’s priceless heritage from destruction in the face of the Russian invasion, noting that the international community also has a duty to help protect and preserve the country’s historic buildings, and other treasures.]]></description>
 <enclosure url="https://global.unitednations.entermediadb.net/assets/mediadb/services/module/asset/downloads/preset/Libraries/Graphics+Library/08-03-2022-LVIV-UKRAINE-andriyko-podilnyk-TaWaGbjp60Q-unsplash.jpg/image770x420cropped.jpg" length="105988" type="image/jpeg" />
 <guid isPermaLink="true">https://news.un.org/feed/view/en/story/2022/03/1113602</guid>
 <pubDate>Wed, 09 Mar 2022 11:43:18 -0500</pubDate>
 <source url="https://news.un.org/feed/subscribe/en/news/region/europe/feed/rss.xml" />
</item>
</channel>
</rss>
"""

}
