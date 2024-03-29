//
//  DetailViewModel.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 22/11/2021.
//

import UIKit
import SPAlert

//  modelData used by DetailViewController

final class DetailViewModel {
    let id: Int
    
    let artData: ArticleRepositoryProtocol
    
    func viewDidLoad(indicator: UIActivityIndicatorView, idLabel: UILabel, title: UILabel, subtitle: UILabel, date: UILabel, body: UILabel, alert: SPAlertView, vc: UIViewController) {
        indicator.startAnimating()
        artData.fetchData(id: id) { article, err in
            guard err == nil else {
                vc.dismiss(animated: true) {
                    alert.present()

                }
                return
            }
            idLabel.text = "\(self.id)"
            idLabel.isHidden = false
            title.text = article!.title
            title.isHidden = false
            subtitle.text = article!.subtitle
            subtitle.isHidden = false
            date.text = article!.date
            date.isHidden = false
            body.text = article!.body
            body.isHidden = false
            indicator.hidesWhenStopped = true
            indicator.stopAnimating()
        }
    }

    init(id: Int, artData: ArticleRepositoryProtocol = ArticleRepository()) {
        self.artData = artData
        self.id = id
    }
}
