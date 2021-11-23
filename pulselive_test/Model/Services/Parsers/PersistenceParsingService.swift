//
//  PersistenceParsingService.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 23/11/2021.
//

import Foundation
import CoreData

protocol PersistenceParsingServiceProtocol {
    func convertToPreview(_ data: [NSFetchRequestResult], completion: @escaping (ArticlePreview?, NetworkError?) -> Void)
    
    func convertToExtended(_ data: [NSFetchRequestResult], id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void)
}

final class PersistenceParsingService: PersistenceParsingServiceProtocol {
    func convertToPreview(_ data: [NSFetchRequestResult], completion: @escaping (ArticlePreview?, NetworkError?) -> Void) {
        let arts = try! data as? [Article]
        
        for art in arts! {
            completion(ArticlePreview(id: Int(art.id), title: art.title!, subtitle: art.subtitle!, date: art.date!), nil)
        }
    }
    
    func convertToExtended(_ data: [NSFetchRequestResult], id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void) {
        let arts = try! data as? [Article]
        
        var a: [Article] = []
        
        a = arts!.filter( { $0.id == id } )
        
        if a.isEmpty {
            completion(nil, NetworkError.wrongReference)
        } else {
            for art in a {
                completion(ArticleExtended(id: Int(art.id), title: art.title!, subtitle: art.subtitle!, date: art.date!, body: art.body!), nil)
            }
        }
        

    }
    
    
}
