//
//  MovieDetailsViewController.swift
//  MovieApp
//
//  Created by manya on 04/03/24.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var movieDetail: String = ""
    var movieTitle: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionLabel.text = movieDetail
        navigationItem.title = movieTitle
    }
    



}
