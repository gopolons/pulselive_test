//
//  PersistenceService.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 22/11/2021.
//

import Foundation
import CoreData

protocol PersistenceServiceProtocol: NetworkAPIProtocol {
    func add(_ extArt: ArticleExtended)
}

final class PersistenceService: PersistenceServiceProtocol {
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
            print(try! persistentContainer.viewContext.count(for: request))
            return
        } else {
            var art = Article(context: persistentContainer.viewContext)
            
            art.id = Int32(extArt.id)
            art.title = extArt.title
            art.subtitle = extArt.subtitle
            art.date = extArt.date
            art.body = extArt.body
            
            try! persistentContainer.viewContext.save()
            print(try! persistentContainer.viewContext.count(for: request))

        }
        
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview?, NetworkError?) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let data = try! persistentContainer.viewContext.fetch(request)
        
        if data.isEmpty {
            completion(nil, NetworkError.noConnection)
        } else {
            let arts = try! data as? [Article]
            
            for art in arts! {
                completion(ArticlePreview(id: Int(art.id), title: art.title!, subtitle: art.subtitle!, date: art.date!), nil)
            }
        }
        

    }
    
    func fetchFullArticle(id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void) {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Article")
        let data = try! persistentContainer.viewContext.fetch(request)
        
        if data.isEmpty {
            completion(nil, NetworkError.noConnection)
        } else {
            let arts = try! data as? [Article]
            
            let a = arts?.filter( { $0.id == id } )
            
            for art in a! {
                completion(ArticleExtended(id: Int(art.id), title: art.title!, subtitle: art.subtitle!, date: art.date!, body: art.body!), nil)
            }
        }
    }
    
    
}
