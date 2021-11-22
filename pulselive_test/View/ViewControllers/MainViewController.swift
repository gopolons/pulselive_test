//
//  MainViewController.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 19/11/2021.
//

import UIKit
import SPAlert

//  This view controller is attached to MainViewModel, fetches data after viewDidLoad and displays the fetched data in a tableview. If data could not be fetched, it presents a button, which can reload viewDidLoad function.
class MainViewController: UIViewController {

    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var articleTable: UITableView!
    
    @IBAction func reloadButton(_ sender: UIButton) {
        viewModel.viewDidLoad(table: articleTable, vc: self, indicator: actIndicator, button: buttonOutlet)
    }
    
    @IBOutlet weak var buttonOutlet: UIButton!
    
    
    private let viewModel = MainViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel.viewDidLoad(table: articleTable, vc: self, indicator: actIndicator, button: buttonOutlet)

    }

}

//  This extensions assigns table data source and data delegate to main view controller (convenient -> it is the only element associated with this vc)
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.articlesPreview.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        viewModel.generateCell(indexPath: indexPath, tableView: tableView)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)

        viewModel.navigate(indexPath: indexPath, currentVC: self)
        
    }
    
}
