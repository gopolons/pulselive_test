//
//  MainViewController.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 19/11/2021.
//

import UIKit

//  This view controller acts as a delegate for table view, it fetches the data and pushes the data to detail view controller via artData
class MainViewController: UIViewController {

    @IBOutlet weak var articleTable: UITableView!
    
    let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.viewDidLoad(table: articleTable, vc: self)
        
    }

}

//  This extensions assignes table data source and data delegate to main view controller (because it is the only element associated with this vc)
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articlesPreview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let art = viewModel.articlesPreview[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell") as! ArticleTableViewCell
        
        cell.setData(article: art)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        viewModel.navigate(indexPath: indexPath, currentVC: self)
        
    }
    
}
