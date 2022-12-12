//
//  SearchAddressService.swift
//  gram
//
//  Created by Khurshed Umarov on 12.12.2022.
//

import Foundation

class SearchAddressServiceImpl: SearchAddressService {
    
    let urlSession: UrlSessionProtocol
    
    init(urlSession: UrlSessionProtocol) {
        self.urlSession = urlSession
    }
    
    func searchAddress(request: SearchAddressRequest) async throws -> SearchAddressResponse {
        let params: [String: String] = [
            "search": request.searchText
        ]
        let searchResponse: SearchAddressResponse = try await urlSession.searchAddress(with: APIRequest(path: APIConstants.searchAddessURL, params: params, host: APIConstants.hostURL, httpMethod: .post))
        print("response: \(searchResponse)")
        return searchResponse
    }
}
