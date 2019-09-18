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
        let api = ApiRestClient<Array<Country>>(urlServer: "https://restcountries-v1.p.rapidapi.com/all")
        api.urlKey = "9326145ca0msha8b5d860debad48p145374jsn05e76cff94cc"
        return api
    }()
    var results: [Country]?
    fileprivate let sectionInsets = UIEdgeInsets(top: 20.0,
                                                 left: 10.0,
                                                 bottom: 20.0,
                                                 right: 10.0)
    fileprivate let numberOfItems:CGFloat = 3
    static let showDetailSegueIdentifier = "showDetail"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCell()
        
        do {
            try print(FileReadManager.shared.getApiKey())
        } catch let e as FileReadManagerError {
            print(e.description)
        } catch {
            print("other error")
        }
        
        if !Connectivity.shared.isAvailable() {
            showToast(title: "error".localizedString(), message: "no_internet".localizedString())
        }
        
        fetchPropertyList()
    
    }
    
    // - MARK: Downloads
    
    /// Function to download the country list in the background
    @objc func fetchPropertyList() {
        DispatchQueue.global(qos: .userInteractive).async {
            self.apiRequest.request { (success, items) in
                DispatchQueue.main.async {
                    if success {
                        self.results = items
                        self.collectionView.reloadData()
                    } else {
                        
                        self.showToast(title: "error".localizedString(), message: "error_fetching".localizedString())
                    }
                    //self.isLoading(active: false)
                    //self.refresh.endRefreshing()
                }
            }
        }
    }
    
    
    // - MARK: Views
    
    
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


}

extension CountryCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let _result = results else { return 0 }
        return _result.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseIdentifier, for: indexPath) as? CountryCell, let _country = results?[indexPath.row] {
            cell.configureCell(with: _country)
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let country = results?[indexPath.row]
        performSegue(withIdentifier: CountryCollectionViewController.showDetailSegueIdentifier, sender: country)
    }
    
}

extension CountryCollectionViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {


        let witdh = (collectionView.frame.width - (sectionInsets.left + sectionInsets.right) * 2) / numberOfItems
        return CGSize(width: witdh, height: 160)
    }
}

