//
//  DetailViewController.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 19/11/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
//  This view controller receives data prior to segue from main view controller and displays article detail
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    var articleId: Int?
    
    var articleTitle: String?
    
    var articleSubtitle: String?
    
    var articleDate: String?
    
    var articleBody: String?
    
    let artData = ArticleRepository()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = articleTitle
        id.text = "\(articleId!)"
        subtitle.text = articleSubtitle
        date.text = articleDate
        body.text = articleBody
        
        // Do any additional setup after loading the view.
    }

}
