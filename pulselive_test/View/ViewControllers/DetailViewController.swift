//
//  DetailViewController.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 19/11/2021.
//

import UIKit
import SPAlert

class DetailViewController: UIViewController {
    
//  This view controller receives modelData initiated in MainViewModel's navigate method, fetches and displays the article data
    
    var viewModel: DetailViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    @IBOutlet weak var actIndicator: UIActivityIndicatorView!
    
    let alertView = SPAlertView(title: "Error - data not found", preset: .error)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel!.viewDidLoad(indicator: actIndicator, idLabel: id, title: titleLabel, subtitle: subtitle, date: date, body: body, alert: alertView, vc: self)
        
    }

}
