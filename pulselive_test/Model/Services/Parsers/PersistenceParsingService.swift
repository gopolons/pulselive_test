//
//  PersistenceParsingService.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 23/11/2021.
//

import Foundation
import CoreData

protocol PersistenceParsingServiceProtocol {
    func convertToPreview(_ data: [NSFetchRequestResult], completion: @escaping (ArticlePreview) -> Void)
    
    func convertToExtended(_ data: [NSFetchRequestResult], id: Int, completion: @escaping (ArticleExtended) -> Void)
}

final class PersistenceParsingService: PersistenceParsingServiceProtocol {
    func convertToPreview(_ data: [NSFetchRequestResult], completion: @escaping (ArticlePreview) -> Void) {
        let arts = try! data as? [Article]
        
        for art in arts! {
            completion(ArticlePreview(id: Int(art.id), title: art.title!, subtitle: art.subtitle!, date: art.date!))
        }
    }
    
    func convertToExtended(_ data: [NSFetchRequestResult], id: Int, completion: @escaping (ArticleExtended) -> Void) {
        let arts = try! data as? [Article]
        
        let a = arts?.filter( { $0.id == id } )
        
        for art in a! {
            completion(ArticleExtended(id: Int(art.id), title: art.title!, subtitle: art.subtitle!, date: art.date!, body: art.body!))
        }
    }
    
    
}
