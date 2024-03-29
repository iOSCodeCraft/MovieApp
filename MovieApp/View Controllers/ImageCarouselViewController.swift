//
//  ImageCarouselViewController.swift
//  MovieApp
//
//  Created by manya on 03/03/24.
//

import UIKit

protocol ImageCarouselViewControllerDelegate: AnyObject {
    func imageCarouselViewDidScroll(from viewController: ImageCarouselViewController, currentIndex: Int)
}

class ImageCarouselViewController: UIViewController {

    // IBOutlets
    @IBOutlet weak var imagesCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    //properties
    weak var delegate: ImageCarouselViewControllerDelegate?
    var imageArray: [String] = ["TopRated", "Popular", "Upcoming"] // you can change the data
    private var titleArray: [String] = ["Top Rated Movies", "Popular Movies", "Upcoming Movies"] // you can change the data
    
    //MARK: View controller life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupCollectionView()
    }
    
    //set collection view
    func setupCollectionView() {
        imagesCollectionView.delegate = self
        imagesCollectionView.dataSource = self
    }
    
    //ScrollView delegate method
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let pageWidth = scrollView.frame.width
        let currentIndex = Int((scrollView.contentOffset.x + pageWidth / 2) / pageWidth)
        self.pageControl.currentPage = currentIndex
        delegate?.imageCarouselViewDidScroll(from: self, currentIndex: currentIndex)
    }
}
// collection view layout
extension ImageCarouselViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
}

// CollectionViewDataSource
extension ImageCarouselViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let imageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCarouselCollectionViewCell", for: indexPath) as! ImageCarouselCollectionViewCell
        imageCell.loadData(imageName: imageArray[indexPath.item], titleName: titleArray[indexPath.item])
        pageControl.numberOfPages = imageArray.count
        return imageCell
    }
    
    
}
    

