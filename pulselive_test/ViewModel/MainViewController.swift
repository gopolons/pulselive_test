//
//  MainViewController.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 19/11/2021.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var articleTable: UITableView!
    
    let artData = ArticleRepository()
    
    var articlesPreview: [ArticlePreview] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        
        articleTable.dataSource = self
        articleTable.delegate = self
        
        artData.fetchPreviewData { art in
            self.articlesPreview.insert(art, at: 0)
            self.articleTable.reloadData()

        }
        
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articlesPreview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let art = articlesPreview[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
        
        cell.setData(article: art)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        
        artData.fetchData(id: articlesPreview[indexPath.item].id) { article in
            
            vc.articleId = article.id
            vc.articleTitle = article.title
            vc.articleSubtitle = article.subtitle
            vc.articleDate = article.date
            vc.articleBody = article.body
            self.present(vc, animated:true, completion:nil)

        }
        
        
    }
    
}
