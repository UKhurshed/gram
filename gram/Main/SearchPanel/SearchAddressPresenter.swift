//
//  SearchAddressPresenter.swift
//  gram
//
//  Created by Khurshed Umarov on 12.12.2022.
//

import Foundation


protocol SearchAddressViewInput: AnyObject {
    func searchAddress(request: SearchAddressRequest)
}

protocol SearchAddressDisplayLogic: AnyObject {
    func success(viewModel: SearchAddressViewModel)
    func startLoading()
    func finishLoading()
    func showError(errorDescription: String)
}


class SearchAddressPresenter: SearchAddressViewInput {
    
    weak var viewController: SearchAddressDisplayLogic?
    var interactor: SearchAddressBusinessLogic!
    
    func searchAddress(request: SearchAddressRequest) {
        Task {
            do {
                viewController?.startLoading()
                let searchResponse = try await interactor.searchAddress(request: request)
                viewController?.finishLoading()
                let result = searchResponse.result
                var searchResult = [SearchResultViewModel]()
                for item in result {
                    let item = SearchResultViewModel(id: item.id, name: item.name, city: item.city, village: item.village, district: item.district, region: item.region, synonyms: item.synonyms, street: item.street, synonymStreet: item.synonymStreet, model: item.model, lng: item.lng, lat: item.lat)
                    searchResult.append(item)
                }
                viewController?.success(viewModel: SearchAddressViewModel(searchResult: searchResult))
            } catch {
                viewController?.showError(errorDescription: error.localizedDescription)
            }
        }
    }
    
}
