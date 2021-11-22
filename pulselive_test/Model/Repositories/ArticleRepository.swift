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

final class ArticleRepository: ArticleRepositoryProtocol {

    private var apiService: NetworkAPIProtocol
    
    func fetchData(id: Int, completion: @escaping (ArticleExtended?, NetworkError?) -> Void) {
        
        apiService.fetchFullArticle(id: id) { article, err in
            guard err == nil else {
                switch err {
                case .noConnection:
                    completion(nil, NetworkError.noConnection)
                    return
                default:
                    completion(nil, NetworkError.wrongReference)
                    return
                }
            }
            completion(article!, nil)
        }
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview?, NetworkError?) -> Void) {
        apiService.fetchPreviewData { article, err in
            guard err == nil else {
                switch err {
                case .noConnection:
                    completion(nil, NetworkError.noConnection)
                    return
                default:
                    completion(nil, NetworkError.wrongReference)
                    return
                }
            }
            completion(article!, nil)
        }
    }
    
    init(apiService: NetworkAPIProtocol = NetworkAPI()) {
        self.apiService = apiService
    }

}
