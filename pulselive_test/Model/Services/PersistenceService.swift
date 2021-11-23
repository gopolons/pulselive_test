//
//  PersistenceService.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 22/11/2021.
//

import Foundation
import CoreData

//  Persistence service is based on core data and fetches data in case internet connection does not work

protocol PersistenceServiceProtocol: NetworkAPIProtocol {
    func add(_ extArt: ArticleExtended)
}

final class PersistenceService: PersistenceServiceProtocol {
    
    let parser: PersistenceParsingServiceProtocol
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Articles")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    func add(_ extArt: ArticleExtended) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let data = try! persistentContainer.viewContext.fetch(request)
        let arts = try! data as? [Article]
        let x = arts?.filter( { $0.id == Int32(extArt.id) } )
        if !(x!.isEmpty) {
            return
        } else {
            var art = Article(context: persistentContainer.viewContext)
            art.id = Int32(extArt.id)
            art.title = extArt.title
            art.subtitle = extArt.subtitle
            art.date = extArt.date
            art.body = extArt.body
            try! persistentContainer.viewContext.save()
        }
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview?, NetworkError?) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let data = try! persistentContainer.viewContext.fetch(request)
        
        if data.isEmpty {
            completion(nil, NetworkError.noConnection)
        } else {
            parser.convertToPreview(data) { art, err in
                guard err == nil else {
                    completion(nil, NetworkError.wrongReference)
                    return
                }
                completion(art, nil)
            }
        }
    }
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let data = try! persistentContainer.viewContext.fetch(request)
        
        if data.isEmpty {
            completion(nil, NetworkError.noConnection)
        } else {
            parser.convertToExtended(data, id: id) { art, err in
                guard err == nil else {
                    completion(nil, NetworkError.wrongReference)
                    return
                }
                completion(art, nil)
            }
        }
    }
    
    init(parser: PersistenceParsingServiceProtocol = PersistenceParsingService()) {
        self.parser = parser
    }
    
}
