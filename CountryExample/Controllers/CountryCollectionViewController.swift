//
//  ViewController.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 12/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit

class CountryCollectionViewController: UICollectionViewController {

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
        
    }
    
    
    /// register the collectionView Cell
    func registerCell() {
        let nibCell = UINib(nibName: CountryCell.nibName, bundle: nil)
        self.collectionView.register(nibCell, forCellWithReuseIdentifier: CountryCell.reuseIdentifier)
    }


}

extension CountryCollectionViewController {
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CountryCell.reuseIdentifier, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    
    
}

extension CountryCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        
        //let witdh = (collectionView.frame.width - (sectionInsets.left + sectionInsets.right)) / numberOfItems
        
        //return CGSize(width: witdh, height: collectionView.frame.height)
        
        return CGSize(width: 70, height: 160)
    }
}

