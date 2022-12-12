//
//  SearchPanelModel.swift
//  gram
//
//  Created by Khurshed Umarov on 12.12.2022.
//

import Foundation

typealias SearchAddressRequest = SearchPanel.SearchAddress.Request
typealias SearchAddressResponse = SearchPanel.SearchAddress.Response
typealias SearchAddressViewModel = SearchPanel.SearchAddress.ViewModel

enum SearchPanel {
    enum SearchAddress {
        struct Request {
            let searchText: String
        }
        
        struct Response: Codable {
            let success: Bool
            let code: Int
            let message: String
            let result: [SearchResult]
            let error: [SearchError]
        }
        
        struct ViewModel {
            let searchResult: [SearchResultViewModel]
        }
    }
}

struct SearchResult: Codable {
    let id: Int
    let name, city, village, district: String
    let region: String
    let synonyms, street, synonymStreet: String?
    let model, lng, lat: String

    enum CodingKeys: String, CodingKey {
        case id, name, city, village, district, region, synonyms, street
        case synonymStreet = "synonym_street"
        case model, lng, lat
    }
}


struct SearchResultViewModel {
    let id: Int
    let name, city, village, district: String
    let region: String
    let synonyms, street, synonymStreet: String?
    let model, lng, lat: String
}

struct SearchError: Codable {
    let searchError: [String]

    enum CodingKeys: String, CodingKey {
        case searchError = "search_error"
    }
}
