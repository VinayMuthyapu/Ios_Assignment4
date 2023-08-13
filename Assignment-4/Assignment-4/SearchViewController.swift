//
//  ViewController.swift
//  Assignment-4
//
//  Created by user221341 on 7/30/23.
//

import UIKit

class SearchViewController: UIViewController, UISearchBarDelegate , NetworkingDelegate, UITableViewDelegate,UITableViewDataSource {
    
    var allCountries = [String]()
    
    @IBOutlet weak var countriesTable: UITableView!
    

    
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        NetworkingManager.shared.delegate = self
         
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
            if let searchText = searchBar.text, !searchText.isEmpty {
                // Call the API with the entered search text
                NetworkingManager.shared.getCountriesFromAPI(searchText: searchText)
                    //searchBar.resignFirstResponder() // Hide the keyboard after tapping the search button
            }
        }


    
    func networkingDidFinishWithLitsOfCountries(countries: [String]) {
        
        allCountries = countries
        countriesTable.reloadData()
    }
    
    func networkingDidFail() {
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return allCountries.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = allCountries[indexPath.row]
            return cell
        }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       var alert = UIAlertController(title: "Fav Country??", message: "Would you like to save this country?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default,handler: { action in
           
            (UIApplication.shared.delegate as! AppDelegate).favCountries.append(self.allCountries[indexPath.row])
            self.navigationController?.popViewController(animated: true)
        }))
        
      alert.addAction(UIAlertAction(title: "No", style: .destructive))
        
        present(alert, animated: true)
        
        
    }
    
    //func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      //  return allCountries.count
    //}
    
    //func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       // var cell = countriesTable.dequeueReusableCell(withIdentifier: "cell")
       // cell?.textLabel?.text = allCountries[indexPath.row]
        
      //  return cell
        
    //}
}


