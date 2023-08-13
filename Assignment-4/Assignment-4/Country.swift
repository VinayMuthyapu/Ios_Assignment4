//
//  Country.swift
//  Assignment-4
//
//  Created by user221341 on 7/30/23.
//

import Foundation

class Country: Decodable {
    var name: CountryName?
    var capital: [String] = []
    var flags: FlagInfo = FlagInfo()
    var population: Int = 0
    var currencies: [String: Currency] = [:]
}

//class CountryName: Decodable {
    //var common: [String: String] = [:] // Change the property to a Dictionary
//}
class CountryName : Decodable {
    var common : String = ""
}


class FlagInfo: Decodable {
    var png: String = ""
    var svg: String = ""
    var alt: String = ""
}

class Currency: Decodable {
    var name: String = ""
    var symbol: String = ""
    
}

