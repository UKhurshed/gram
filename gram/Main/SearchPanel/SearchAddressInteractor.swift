//
//  SearchAddressInteractor.swift
//  gram
//
//  Created by Khurshed Umarov on 12.12.2022.
//

import Foundation

protocol SearchAddressBusinessLogic: AnyObject {
    func searchAddress(request: SearchAddressRequest) async throws -> SearchAddressResponse
}

protocol SearchAddressService {
    func searchAddress(request: SearchAddressRequest) async throws -> SearchAddressResponse
}

class SearchAddressInteractor: SearchAddressBusinessLogic {
    
    let service: SearchAddressService
    
    init(service: SearchAddressService) {
        self.service = service
    }
    
    func searchAddress(request: SearchAddressRequest) async throws -> SearchAddressResponse {
        let searchResponse = try await service.searchAddress(request: request)
        
        return searchResponse
    }
    
    
}
