//
//  Networking Manager.swift
//  Assignment-4
//
//  Created by user221341 on 7/30/23.
//

import Foundation
protocol NetworkingDelegate {
    func networkingDidFinishWithLitsOfCountries(countries : [String])
    func networkingDidFail()
}


class NetworkingManager {
    
    static var shared = NetworkingManager()
    var delegate : NetworkingDelegate?
    
    func getCountriesFromAPI(searchText : String) {
        
        //let strinurl = "https://restcountries.com/v3.1/name/canada?fullText=true"
        let baseurl = "https://restcountries.com/v3.1/name/"
        let strinurl = "\(baseurl)\(searchText)?fullText=true"

        guard let urlObj = URL(string: strinurl) else { return }
        // datatask runs in background thread
        
        let task = URLSession.shared.dataTask(with: urlObj) { data, response, error in
            
            if error != nil { // there is an error
                print (error!)
                DispatchQueue.main.async {
                    self.delegate?.networkingDidFail()
                }
                // let my delegate know about this error
            }
            else if let httpResponse = response as? HTTPURLResponse,
                                  (200...299).contains(httpResponse.statusCode),
                                  let goodData = data {
                            DispatchQueue.main.async {
                                do {
                                    let jsonDecoder = JSONDecoder()
                                    let countries = try jsonDecoder.decode([Country].self, from: goodData)
                                    
                                    var countryNames = [String]()
                                    for country in countries {
                                        if let name = country.name?.common {
                                            countryNames.append(name)
                                        }
                                    }
                                    
                                    self.delegate?.networkingDidFinishWithLitsOfCountries(countries: countryNames)
                                } catch let error {
                                    print("Error decoding JSON: \(error)")
                                                        }
                                                    }
                                                } else {
                                                    DispatchQueue.main.async {
                                                        self.delegate?.networkingDidFail()
                                                    }
                
            }
        }
        
        task.resume()// run in background thread by default
    }
    
   // func networkingDidFinishWithCountryDetails(country: Country) {
        //delegate?.networkingDidFinishWithLitsOfCountries(countries: [String])
        //}
    
    func fetchCountryDetailsByName(name: String, completion: @escaping (Country?) -> Void) {
            let baseUrl = "https://restcountries.com/v3.1/name/"
            let urlString = "\(baseUrl)\(name)?fullText=true"
            
            guard let url = URL(string: urlString) else {
                completion(nil)
                return
            }
            
            let task = URLSession.shared.dataTask(with: url) { data, response, error in
                guard let data = data, error == nil else {
                    completion(nil)
                    return
                }
                
                do {
                    let jsonDecoder = JSONDecoder()
                    let countries = try jsonDecoder.decode([Country].self, from: data)
                    if let country = countries.first {
                        completion(country)
                    } else {
                        completion(nil)
                    }
                } catch {
                    completion(nil)
                }
            }
                   
                   task.resume()
               }
}
