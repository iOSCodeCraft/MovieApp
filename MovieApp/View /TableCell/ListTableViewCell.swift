//
//  ListTableViewCell.swift
//  MovieApp
//
//  Created by manya on 03/03/24.
//

import UIKit
import SDWebImage

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var listImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData(item:  Movie) {
        titleLabel.text = item.originalTitle
        // Use SDWebImage to load and cache images
        let imageUrl = URL(string: "\(ImageURL.imageUrl.rawValue)\(item.posterPath)")
        listImageView.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placement"))
    }
    func loadImage(from path: String) {
            
        }
}
