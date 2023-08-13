//
//  FavCountriesTableViewController.swift
//  Assignment-4
//
//  Created by user221341 on 8/6/23.
//

import UIKit

class FavCountriesTableViewController: UITableViewController {
    
    var favCountries = (UIApplication.shared.delegate as! AppDelegate).favCountries
   // var weatherObject = WeatherModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

            }

    override func viewWillAppear(_ animated: Bool) {
        favCountries = (UIApplication.shared.delegate as! AppDelegate).favCountries
        tableView.reloadData()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favCountries.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = favCountries[indexPath.row]

        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool{
        return true
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
       
            favCountries.remove(at: indexPath.row)
            tableView.reloadData()
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCountryName = favCountries[indexPath.row]
        performSegue(withIdentifier: "CountryDetailsViewController", sender: selectedCountryName)
    }



    
  
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CountryDetailsViewController",
            let destinationVC = segue.destination as? CountryDetailsViewController,
            let selectedCountryName = sender as? String {
            
            // Use NetworkingManager to fetch the details of the selected country
            NetworkingManager.shared.fetchCountryDetailsByName(name: selectedCountryName) { country in
                destinationVC.selectedCountry = country
            }
        }
    }




        

}
