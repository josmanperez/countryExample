//
//  CountryDetailViewController.swift
//  CountryExample
//
//  Created by Josman Pérez Expósito on 13/09/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit
import MapKit

class CountryDetailViewController: UIViewController {
    
    var country: Country?

    @IBOutlet weak var countryMap: MKMapView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var capitalLabel: UILabel! {
        didSet {
            capitalLabel.text = "Capital".localizedString()
        }
    }
    @IBOutlet weak var capital: UILabel!
    @IBOutlet weak var regionLabel: UILabel! {
        didSet {
            regionLabel.text = "Region".localizedString()
        }
    }
    @IBOutlet weak var region: UILabel!
    @IBOutlet weak var subregionLabel: UILabel! {
        didSet {
            subregionLabel.text = "Subregion".localizedString()
        }
    }
    @IBOutlet weak var subregion: UILabel!
    @IBOutlet weak var populationLabel: UILabel! {
        didSet {
            populationLabel.text = "Population".localizedString()
        }
    }
    @IBOutlet weak var population: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    /// Configure view of controller
    func configureView() {
        guard let _country = country else {
            dismiss(animated: true, completion: nil)
            return
        }
        configureMap(with: _country)
        name.text = _country.name
        capital.text = _country.capital
        region.text = _country.region
        subregion.text = _country.subregion
        
        let numberFormatter = NumberFormatter()
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .ordinal
        numberFormatter.locale = Locale.current
        
        let populationString = numberFormatter.string(from: NSNumber(value: _country.population))
        population.text = populationString ?? ""
        
    }
    
    // - MARK: Mapview
    
    /// Configure the map, load the property and show the pin.
    /// This has to be done on a background thread in order to not overload the mainthread
    /// And not freeze user interface
    fileprivate func configureMap(with country: Country) {
        // Create a loading view
        let spinner = UIActivityIndicatorView(frame: CGRect.zero)
        spinner.backgroundColor = UIColor.white.withAlphaComponent(0.8)
        spinner.style = .gray
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        countryMap.addSubview(spinner)
        NSLayoutConstraint(item: spinner, attribute: .leading, relatedBy: .equal, toItem: countryMap, attribute: .leading, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .trailing, relatedBy: .equal, toItem: countryMap, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .bottom, relatedBy: .equal, toItem: countryMap, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
        NSLayoutConstraint(item: spinner, attribute: .top, relatedBy: .equal, toItem: countryMap, attribute: .top, multiplier: 1, constant: 0).isActive = true
        
        // Call the background thread to search for the location
        DispatchQueue.global(qos: .background).async {
            guard let _latitude = country.latlng?[0], let _longitude = country.latlng?[1] else {
                let view = UIView(frame: self.countryMap.frame)
                view.translatesAutoresizingMaskIntoConstraints = false
                view.backgroundColor = UIColor.white
                view.alpha = 0.8
                let label = UILabel()
                label.text = "No_country_found".localizedString()
                label.font = UIFont(name: "Helvetica-Neue", size: 5)
                view.addSubview(label)
                label.translatesAutoresizingMaskIntoConstraints = false
                NSLayoutConstraint(item: label, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: label, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
                self.countryMap.addSubview(view)
                NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal, toItem: self.countryMap, attribute: .leading, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal, toItem: self.countryMap, attribute: .trailing, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal, toItem: self.countryMap, attribute: .bottom, multiplier: 1, constant: 0).isActive = true
                NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal, toItem: self.countryMap, attribute: .top, multiplier: 1, constant: 0).isActive = true
                return
            }
            let location = CLLocation(latitude: _latitude, longitude: _longitude)
            let artwork = MapHelper(title: country.name, capital: country.capital, coordinate: CLLocationCoordinate2D(latitude: _latitude, longitude: _longitude))
            DispatchQueue.main.async { [weak self] in
                self?.centerMapOnLocation(location: location)
                self?.countryMap.addAnnotation(artwork)
                spinner.stopAnimating()
            }
        }
        
    }
    
    fileprivate func centerMapOnLocation(location: CLLocation) {
        let regionRadius: CLLocationDistance = 50000
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                  latitudinalMeters: regionRadius, longitudinalMeters: regionRadius)
        self.countryMap.setRegion(coordinateRegion, animated: true)
    }
    
    // - MARK: Action to dismiss view
    
    @IBAction func close(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
