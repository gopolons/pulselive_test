//
//  ArticleRepository.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 18/11/2021.
//


import Foundation

//Article repository is an interface used for fetching the data through network service (or otherwise, for testing purposes)

protocol ArticleRepositoryProtocol {
    func fetchData(id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void)
    
    func fetchPreviewData(completion: @escaping (ArticlePreview?, NetworkError?) -> Void)

}

//Article repository tries to fetch data from network api protocol, and if it fails due to network error, it attempts to use coredata storage to access stored data (which is stored on fetching article extended)

final class ArticleRepository: ArticleRepositoryProtocol {

    private var apiService: NetworkAPIProtocol
    private var persistenceService: PersistenceServiceProtocol
    
    func fetchData(id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void) {
        
        apiService.fetchFullArticle(id: id) { article, err in
            guard err == nil else {
                switch err {
                case .noConnection:
                    self.persistenceService.fetchFullArticle(id: id) { persistenceArt, persistenceErr in
                        guard persistenceErr == nil else {
                            completion(nil, err)
                            return
                        }
                        completion(persistenceArt, nil)
                    }
                    return
                default:
                    completion(nil, NetworkError.wrongReference)
                    return
                }
            }
            self.persistenceService.add(article!)
            completion(article!, nil)
        }
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview?, NetworkError?) -> Void) {
        apiService.fetchPreviewData { article, err in
            guard err == nil else {
                switch err {
                case .noConnection:
                    self.persistenceService.fetchPreviewData { persistenceArt, persistenceErr in
                        guard persistenceErr == nil else {
                            completion(nil, err)
                            return
                        }
                        completion(persistenceArt, nil)
                    }
                    return
                default:
                    completion(nil, NetworkError.wrongReference)
                    return
                }
            }
            completion(article!, nil)
        }
    }
    
    init(apiService: NetworkAPIProtocol = NetworkAPI(), persistenceService: PersistenceServiceProtocol = PersistenceService()) {
        self.apiService = apiService
        self.persistenceService = persistenceService
    }

}
