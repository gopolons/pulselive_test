//
//  DataParsingService.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 22/11/2021.
//

import Foundation
import SwiftyJSON

//  Data parsing service parses the JSON data into provided article models
protocol DataParsingProtocol {
    func parsePreviewData(data: Data, completion: @escaping (ArticlePreview) -> Void)
    
    func parseExtendedData(data: Data, completion: @escaping (ArticleExtended) -> Void)
}

final class DataParsing: DataParsingProtocol {
    func parsePreviewData(data: Data, completion: @escaping (ArticlePreview) -> Void) {
        
        let json = JSON(data)

        for x in json {
            
            for n in x.1 {
                let id: Int = n.1["id"].intValue
                let title: String = n.1["title"].stringValue
                let subtitle: String = n.1["subtitle"].stringValue
                let date: String = n.1["date"].stringValue

                let preview = ArticlePreview(id: id, title: title, subtitle: subtitle, date: date)
                completion(preview)
            }
        }
    }
    
    func parseExtendedData(data: Data, completion: @escaping (ArticleExtended) -> Void) {
        
        let json = JSON(data)

        for x in json {
            
            
            let id: Int = x.1["id"].intValue
            let title: String = x.1["title"].stringValue
            let subtitle: String = x.1["subtitle"].stringValue
            let body: String = x.1["body"].stringValue
            let date: String = x.1["date"].stringValue

            let article = ArticleExtended(id: id, title: title, subtitle: subtitle, date: date, body: body)
            completion(article)
            
        }
    }
}
