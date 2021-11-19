//
//  ArticleRepository.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 18/11/2021.
//

import Foundation

protocol ArticleRepositoryProtocol {
    func fetchData(id: Int, completion: @escaping (ArticleExtended) -> Void)
    
    func fetchPreviewData(completion: @escaping (ArticlePreview) -> Void)

}

final class ArticleRepository: ArticleRepositoryProtocol {

    private var apiService: NetworkAPIProtocol
    
    func fetchData(id: Int, completion: @escaping (ArticleExtended) -> Void) {
        apiService.fetchFullArticle(id: id) { article in
            completion(article)
        }
    }
    
    func fetchPreviewData(completion: @escaping (ArticlePreview) -> Void) {
        apiService.fetchPreviewData { article in
            completion(article)
        }
    }
    
    init(apiService: NetworkAPIProtocol = NetworkAPI()) {
        self.apiService = apiService
    }

}
