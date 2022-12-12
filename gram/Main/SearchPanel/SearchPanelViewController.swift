//
//  SearchPanelViewController.swift
//  gram
//
//  Created by Khurshed Umarov on 12.12.2022.
//

import UIKit

class SearchPanelViewController: UIViewController {
    
    private var searchPanelUIView: SearchPanelUIView {
        self.view as! SearchPanelUIView
    }
    
    var presenter: SearchAddressViewInput!
    
    override func loadView() {
        view = SearchPanelUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        searchPanelUIView.delegate = self
        setup()
    }
    
    private func setup() {
        let viewController = self
        let facade = URLSessionFacade()
        let service = SearchAddressServiceImpl(urlSession: facade)
        let interactor = SearchAddressInteractor(service: service)
        let presenter = SearchAddressPresenter()
        viewController.presenter = presenter
        presenter.viewController = viewController
        presenter.interactor = interactor
    }
}

extension SearchPanelViewController: SearchPanelUIViewDelegate {
    func textChanging(text: String) {
        presenter.searchAddress(request: SearchAddressRequest(searchText: text))
    }
}

extension SearchPanelViewController: SearchAddressDisplayLogic {
    func success(viewModel: SearchAddressViewModel) {
        print("viewModel: \(viewModel)")
        DispatchQueue.main.async {
//            let result = SearchResultViewModel(id: 1, name: "item.name", city: "item.city", village: "item.village", district: "item.district", region: "item.region", synonyms: "item.synonyms", street: "item.street", synonymStreet: "item.synonymStreet", model: "item.model", lng: "item.lng", lat: "item.lat")
            self.searchPanelUIView.successCase(result: viewModel.searchResult)
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async {
            self.searchPanelUIView.startAnimatingIndicator()
        }
    }
    
    func finishLoading() {
        DispatchQueue.main.async {
            self.searchPanelUIView.stopAnimatingIndicator()
        }
    }
    
    func showError(errorDescription: String) {
        DispatchQueue.main.async {
            self.searchPanelUIView.showError()
            let alert  = UIAlertController(title: R.string.localizable.errorLabel(), message: errorDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: R.string.localizable.alertDismiss(), style: .cancel, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    
}
