//
//  ImageCarouselCollectionViewCell.swift
//  MovieApp
//
//  Created by manya on 03/03/24.
//

import UIKit

class ImageCarouselCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    func loadData(imageName: String, titleName: String) {
        imageView.image = UIImage(named: "\(imageName)")
        titleLabel.text = titleName
    }
    
}
