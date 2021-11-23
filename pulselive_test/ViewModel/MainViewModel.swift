//
//  MainViewModel.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 22/11/2021.
//

import UIKit
import SPAlert

//  modelData used by MainViewController

final class MainViewModel {
    
    private let artData: ArticleRepositoryProtocol
    
    var articlesPreview: [ArticlePreview] = []
    
    func viewDidLoad(table: UITableView, vc: UIViewController, indicator: UIActivityIndicatorView, errorText: UILabel) {
                
        errorText.isHidden = true
        
        indicator.startAnimating()
        
        table.dataSource = vc as? UITableViewDataSource
        table.delegate = vc as? UITableViewDelegate
        
        
        artData.fetchPreviewData { art, err in
            guard err == nil else {
                indicator.hidesWhenStopped = true
                indicator.stopAnimating()
                errorText.isHidden = false
                return
            }
            self.articlesPreview.insert(art!, at: 0)
            table.reloadData()
            indicator.hidesWhenStopped = true
            indicator.stopAnimating()
            
        }
    }
    
    func fetchData(table: UITableView, errorText: UILabel) {
        articlesPreview.removeAll()

        
        artData.fetchPreviewData { art, err in
            guard err == nil else {
                if self.articlesPreview.isEmpty {
                    table.reloadData()
                    errorText.isHidden = false
                }
                return
            }
            errorText.isHidden = true
            self.articlesPreview.insert(art!, at: 0)
            table.reloadData()

            
        }
    }
    
    func navigate(indexPath: IndexPath, currentVC: UIViewController) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyBoard.instantiateViewController(withIdentifier: "DetailView") as! DetailViewController
        
        let index = articlesPreview[indexPath.item].id
                    
        vc.viewModel = DetailViewModel(id: index)

        currentVC.present(vc, animated: true, completion: nil)

    }
    
    func generateCell(indexPath: IndexPath, tableView: UITableView) -> (UITableViewCell) {
        let art = self.articlesPreview[indexPath.row]

        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell

        cell.setData(article: art)

        return cell
    }
    
    init(artData: ArticleRepositoryProtocol = ArticleRepository()) {
        self.artData = artData
    }
}
