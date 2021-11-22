//
//  DetailViewController.swift
//  pulselive_test
//
//  Created by Georgy Polonskiy on 19/11/2021.
//

import UIKit

class DetailViewController: UIViewController {
    
//  This view controller receives data prior to segue from main view controller and displays article detail
    
    var viewModel: DetailViewModel?
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var id: UILabel!
    
    @IBOutlet weak var subtitle: UILabel!
    
    @IBOutlet weak var date: UILabel!
    
    @IBOutlet weak var body: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel!.viewDidLoad(idLabel: id, title: titleLabel, subtitle: subtitle, date: date, body: body)
        
    }

}
