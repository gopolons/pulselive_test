//
//  ArticleTableViewCell.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 19/11/2021.
//

import UIKit

class ArticleTableViewCell: UITableViewCell {
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var title: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    func setData(article: ArticlePreview) {
        id.text = String(article.id)
        title.text = article.title
        subtitle.text = article.subtitle
        date.text = article.date
    }
}
