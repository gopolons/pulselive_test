//
//  MainViewModel.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 22/11/2021.
//

import UIKit

//  modelData used by MainViewController

final class MainViewModel {
    
    private let artData: ArticleRepositoryProtocol
    
    var articlesPreview: [ArticlePreview] = []
    
    func viewDidLoad(table: UITableView, vc: UIViewController) {
        
        table.dataSource = vc as? UITableViewDataSource
        table.delegate = vc as? UITableViewDelegate
        
        
        artData.fetchPreviewData { art in
            self.articlesPreview.insert(art, at: 0)
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
