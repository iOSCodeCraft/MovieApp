//
//  ViewController.swift
//  MovieApp
//
//  Created by manya on 02/03/24.
//

import UIKit

class ViewController: UIViewController {
    
    // IBOutlets
    @IBOutlet weak var carouselView: UIView!
    @IBOutlet weak var mainTableView: UITableView!
    @IBOutlet weak var carouselHeightConstraint: NSLayoutConstraint!
    
    // properties
    var movieList: [Movie] = []
    let viewModel = MovieViewModel()
    var maxHeight : CGFloat = 0.0
    var minHeight : CGFloat = 0.0
    var previousScrollingOffsetValue : CGFloat = 0.0
    
    private var searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.placeholder = Constants.searchPlaceholder.rawValue
        sb.showsCancelButton = true
        return sb
    }()
    
    var imageCarouselViewController: ImageCarouselViewController = ImageCarouselViewController()
    
    // View Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.sectionHeaderTopPadding = 0
        setupCarouselView()
        viewModel.delegate = self
        viewModel.loadOfflineData()
        viewModel.loadApi()
        navigationItem.title = Constants.navigationTitle.rawValue
    }
    
    override func viewDidAppear(_ animated: Bool) {
        carouselHeightConstraint.constant = 200
        maxHeight = carouselHeightConstraint.constant
        minHeight = 0.0
    }
    
    // adding child view controller to the table header view for image carousel
    func setupCarouselView() {
        imageCarouselViewController = self.storyboard?.instantiateViewController(withIdentifier: "ImageCarouselViewController") as! ImageCarouselViewController
        imageCarouselViewController.delegate = self
        addChild(imageCarouselViewController)
        imageCarouselViewController.view.frame = carouselView.bounds// CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 200)
        carouselView.addSubview(imageCarouselViewController.view)
        imageCarouselViewController.didMove(toParent: self)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.dismissKeypad()
        let difference = scrollView.contentOffset.y - previousScrollingOffsetValue
        if self.carouselHeightConstraint.constant > maxHeight {
            self.carouselHeightConstraint.constant = maxHeight
        } else {
            self.carouselHeightConstraint.constant = self.carouselHeightConstraint.constant - difference
        }
        previousScrollingOffsetValue = scrollView.contentOffset.y
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        self.dismissKeypad()
        let  midValue =  self.maxHeight / 2  // half range value of maxheight
        UIView.animate(withDuration: 0.2) {
            if midValue > self.carouselHeightConstraint.constant {
                self.carouselHeightConstraint.constant = self.minHeight
            } else {
                self.carouselHeightConstraint.constant = self.maxHeight
            }
            self.view.layoutIfNeeded()
        }
    }
    
    func dismissKeypad() {
        searchBar.searchTextField.resignFirstResponder()
    }
}

//MARK:  view model delegate
extension ViewController: MovieViewModelDelegate {
    func loadTableView(with viewModel: MovieViewModel, movieList: [Movie]) {
        self.movieList = movieList
        DispatchQueue.main.async {
            self.mainTableView.reloadData()
        }
    }
    
    func showErrorMessage(with viewModel: MovieViewModel, error: RequestError) {
        self.showModal(title: error.customMessage, message: error.localizedDescription)
    }
}

//MARK:  ImageCarouselCellDelegate
extension ViewController: ImageCarouselViewControllerDelegate {
    func imageCarouselViewDidScroll(from viewController: ImageCarouselViewController, currentIndex: Int) {
        viewModel.loadTableView(selectedTag: currentIndex)
    }
}

//MARK:  Table view delegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.movieTitle = movieList[indexPath.row].originalTitle
        vc.movieDetail = movieList[indexPath.row].overview
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: Table view data source
extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listCell = tableView.dequeueReusableCell(withIdentifier: "ListTableViewCell", for: indexPath) as! ListTableViewCell
        listCell.loadData(item: movieList[indexPath.row])
        return listCell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        searchBar.delegate = self
        return searchBar
    }
}

//MARK:  serach delegate
extension ViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterMovieList(keyword: searchText)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismissKeypad()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.dismissKeypad()
    }
    
}
