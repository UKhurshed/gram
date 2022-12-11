//
//  MainUIView.swift
//  gram
//
//  Created by Khurshed Umarov on 10.12.2022.
//

import UIKit
import YandexMapsMobile

class MainUIView: UIView {
    
    private let mapView = YMKMapView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initMapView()
        mapView.mapWindow.map.move(
            with: YMKCameraPosition.init(target: YMKPoint(latitude: 40.272309, longitude: 69.623485), zoom: 15, azimuth: 0, tilt: 0), animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 5), cameraCallback: nil)
    }
    
    private func initMapView() {
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(mapView)
        mapView.snp.makeConstraints { makeMapView in
            makeMapView.top.equalToSuperview()
            makeMapView.left.equalToSuperview()
            makeMapView.right.equalToSuperview()
            makeMapView.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
