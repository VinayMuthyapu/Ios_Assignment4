//
//  CountryDetailsViewController.swift
//  Assignment-4
//
//  Created by user221341 on 7/30/23.
//

import UIKit

class CountryDetailsViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var capitalLabel: UILabel!
    @IBOutlet weak var populationLabel: UILabel!
    @IBOutlet weak var currenciesLabel: UILabel!
    @IBOutlet weak var flagImageView: UIImageView!
    
    
    var selectedCountry: Country? {
        
        didSet {
            if let selectedCountry = selectedCountry {
                updateUI(with: selectedCountry)
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let selectedCountry = selectedCountry {
            updateUI(with: selectedCountry)
        }
        else {
            print("No country data available")
        }
        
    }
    
    // Helper method to update the UI with country details
    func updateUI(with country: Country) {
        //print(country)
        //nameLabel.text = country.name.self!
        if let commonName = country.name{
            nameLabel?.text = commonName.common
        } else {
            nameLabel.text = "N/A"
        }
        capitalLabel?.text = country.capital.first ?? "N/A"
        populationLabel?.text = "\(country.population)"
        currenciesLabel?.text = country.currencies.values.first?.name ?? "N/A"
        
        let flagImageName = country.flags.png
                if let flagImage = UIImage(named: flagImageName) {
                    flagImageView.image = flagImage
                } else {
                    print("Image \(flagImageName) not found in asset catalog.")
                    
                }
    }
}
