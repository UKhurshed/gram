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
            with: YMKCameraPosition.init(target: YMKPoint(latitude: 40.272309, longitude: 69.623485), zoom: 15, azimuth: 0, tilt: 0), animationType: YMKAnimation(type: YMKAnimationType.smooth, duration: 2), cameraCallback: nil)
        
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.move(with:
            YMKCameraPosition(target: YMKPoint(latitude: 0, longitude: 0), zoom: 14, azimuth: 0, tilt: 0))
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
    
    public func mapViewUserLocationListenerObject() -> YMKUserLocationLayer {
        let scale = UIScreen.main.scale
        let mapKit = YMKMapKit.sharedInstance()
        let userLocationLayer = mapKit.createUserLocationLayer(with: mapView.mapWindow)

        userLocationLayer.setVisibleWithOn(true)
        userLocationLayer.isHeadingEnabled = true
        userLocationLayer.setAnchorWithAnchorNormal(
            CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.5 * mapView.frame.size.height * scale),
            anchorCourse: CGPoint(x: 0.5 * mapView.frame.size.width * scale, y: 0.83 * mapView.frame.size.height * scale))
        return userLocationLayer
    }
    
}
