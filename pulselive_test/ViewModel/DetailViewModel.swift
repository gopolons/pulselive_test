//
//  DetailViewModel.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 22/11/2021.
//

import UIKit

//  modelData used by DetailViewController

final class DetailViewModel {
    let id: Int
    
    let artData: ArticleRepositoryProtocol
    
    var article: ArticleExtended?
    
    func viewDidLoad(idLabel: UILabel, title: UILabel, subtitle: UILabel, date: UILabel, body: UILabel) {
        artData.fetchData(id: id) { article in
            idLabel.text = "\(self.id)"
            title.text = article.title
            subtitle.text = article.subtitle
            date.text = article.date
            body.text = article.body
        }
    }

    init(id: Int, artData: ArticleRepositoryProtocol = ArticleRepository()) {
        self.artData = artData
        self.id = id
    }
}
