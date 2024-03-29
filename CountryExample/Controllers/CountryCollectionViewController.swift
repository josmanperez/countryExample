//
//  ViewController.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 12/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

class CountryCollectionViewController: UICollectionViewController {
    
    let apiRequest: ApiRestClient<Array<Country>> = {
        do {
            let url = try FileReadManager.shared.getApiValue(with: .restapiurl)
            let apikey = try FileReadManager.shared.getApiValue(with: .restapikey)
            let api = ApiRestClient<Array<Country>>(urlServer: url)
            api.urlKey = apikey
            return api
        } catch {
            return ApiRestClient<Array<Country>>(urlServer: "")
        }
    }()
    var results: [Country]?
    var filterCountries = [Country]()
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0,
                                                 left: 10.0,
                                                 bottom: 20.0,
                                                 right: 10.0)
    fileprivate let numberOfItems:CGFloat = 3
    static let showDetailSegueIdentifier = "showDetail"
    let searchController = UISearchController(searchResultsController: nil)

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        fetchPropertyList()
        configureSearchController()
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if !Connectivity.shared.isAvailable() {
            showToast(title: "error".localizedString(), message: "no_internet".localizedString())
        }
    }
    
    // MARK: - Downloads
    
    /// Function to download the country list in the background
    @objc func fetchPropertyList() {
        startActivityIndicator()
        DispatchQueue.global(qos: .userInteractive).async {
            self.apiRequest.request { (success, items) in
                DispatchQueue.main.async {
                    if success {
                        self.results = items
                        self.collectionView.reloadData()
                    } else {
                        self.showToast(title: "error".localizedString(), message: "error_fetching".localizedString())
                    }
                    Loading.stop()
                }
            }
        }
    }
    
    
    // MARK: - Views
    
    func configureSearchController() {
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = Constants.bottomColor
            appearance.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
            navigationItem.standardAppearance = appearance
            navigationItem.scrollEdgeAppearance = appearance
        }
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "search_cities".localizedString()
        UINavigationBar.appearance().tintColor = .white
        searchController.searchBar.setPlaceholder(textColor: .white)
        navigationItem.title = "countries".localizedString()
        searchController.searchBar.setClearButton(color: .white)
        searchController.searchBar.tintColor = .white
        navigationItem.searchController = searchController
        definesPresentationContext = true
    }
    
    func startActivityIndicator() {
        let frame = CGRect(origin: collectionView.frame.origin, size: collectionView.frame.size)
        if let spinnerView = Loading.starts(frame: frame) {
            view.addSubview(spinnerView)
        }
    }
    
    /// register the collectionView Cell
    func registerCell() {
        let nibCell = UINib(nibName: CountryCell.nibName, bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: CountryCell.reuseIdentifier)
    }
    
    
    /// Show toast for errors
    func showToast(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "dismiss".localizedString(), style: .default))
        present(alert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == CountryCollectionViewController.showDetailSegueIdentifier {
            if let dVC = segue.destination as? CountryDetailViewController, let _country = sender as? Country {
                dVC.country = _country
            }
        }
    }
    
    // MARK: - Search

    func searchBarIsEmpty() -> Bool {
      return searchController.searchBar.text?.isEmpty ?? true
    }
      
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filterCountries = results?.filter({( city : Country) -> Bool in
        return city.name.lowercased().contains(searchText.lowercased())
        }) ?? []

      collectionView.reloadData()
    }
    
    func isFiltering() -> Bool {
      return searchController.isActive && !searchBarIsEmpty()
    }

}

extension CountryCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isFiltering() { return filterCountries.count } else {
            guard let _result = results else { return 0 }
            return _result.count
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseIdentifier, for: indexPath) as? CountryCell, let _country = results?[indexPath.row] {
            let country: Country
            if isFiltering() {
                country = filterCountries[indexPath.row]
            } else {
                country = _country
            }
            cell.configureCell(with: country)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let country = isFiltering() ? filterCountries[indexPath.row] : results?[indexPath.row]
        performSegue(withIdentifier: CountryCollectionViewController.showDetailSegueIdentifier, sender: country)
    }
    
}

extension CountryCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {


        let witdh = (collectionView.frame.width - (sectionInsets.left + sectionInsets.right) * 2) / numberOfItems
        return CGSize(width: witdh, height: CountryCell.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension CountryCollectionViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else { return }
        filterContentForSearchText(text)
    }
    
}

