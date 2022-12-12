//
//  MainUIView.swift
//  gram
//
//  Created by Khurshed Umarov on 10.12.2022.
//

import UIKit
import YandexMapsMobile

class MainUIView: UIView {
    
    private var mapView = YMKMapView()
    private let locationView = UIView()
    private let moreBackground = UIImageView()
    private let moreIcon = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        initMapView()
        mapView.mapWindow.map.mapType = .map
        mapView.mapWindow.map.isRotateGesturesEnabled = false
        mapView.mapWindow.map.move(with:
                    YMKCameraPosition(target: YMKPoint(latitude: 40.272309, longitude: 69.623485), zoom: 14, azimuth: 0, tilt: 0))
        initLocationView()
        initMoreBackground()
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

    
    private func initLocationView() {
        locationView.translatesAutoresizingMaskIntoConstraints = false
        locationView.backgroundColor = .black
        locationView.layer.cornerRadius = 25
        
        addSubview(locationView)
        locationView.snp.makeConstraints { makeLocation in
            makeLocation.top.equalTo(mapView.snp.top).offset(62)
            makeLocation.centerX.equalToSuperview()
            makeLocation.height.equalTo(45)
            makeLocation.width.equalTo(130)
        }
    }
    
    private func initMoreBackground() {
        moreBackground.translatesAutoresizingMaskIntoConstraints = false
        moreBackground.image = UIImage(named: "moreBackground")
        
       
        addSubview(moreBackground)
        
        moreBackground.snp.makeConstraints { makeMoreBack in
            makeMoreBack.top.equalToSuperview().offset(62)
            makeMoreBack.right.equalToSuperview().offset(-20)
            makeMoreBack.height.equalTo(50)
            makeMoreBack.width.equalTo(50)
        }
        
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "more")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        moreBackground.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(16)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setListenerOfMapView() -> YMKUserLocationLayer {
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
