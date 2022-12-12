//
//  MainViewController.swift
//  gram
//
//  Created by Khurshed Umarov on 10.12.2022.
//

import UIKit
import FloatingPanel
import YandexMapsMobile

class MainViewController: UIViewController {
    var fpc: FloatingPanelController!
    
    private var mainUIView: MainUIView {
        self.view as! MainUIView
    }
    
    override func loadView() {
        view = MainUIView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fpc = FloatingPanelController(delegate: self)
        let vc = FloatingPanelViewController()
        vc.fpc = fpc
        fpc.set(contentViewController: vc)
        fpc.addPanel(toParent: self)
        let listener = mainUIView.setListenerOfMapView()
        listener.setObjectListenerWith(self)
    }
}

extension MainViewController: YMKUserLocationObjectListener {
    func onObjectAdded(with view: YMKUserLocationView) {
        view.arrow.setIconWith(UIImage(named:"user_arrow")!)
        
        let pinPlacemark = view.pin.useCompositeIcon()
        
        pinPlacemark.setIconWithName(
            "pin",
            image: UIImage(named:"search_result")!,
            style:YMKIconStyle(
                anchor: CGPoint(x: 0.5, y: 0.5) as NSValue,
                rotationType:YMKRotationType.rotate.rawValue as NSNumber,
                zIndex: 1,
                flat: true,
                visible: true,
                scale: 1,
                tappableArea: nil))

        view.accuracyCircle.fillColor = UIColor.blue
    }
    
    func onObjectRemoved(with view: YMKUserLocationView) {}
    
    func onObjectUpdated(with view: YMKUserLocationView, event: YMKObjectEvent) {}
}


extension MainViewController: FloatingPanelControllerDelegate {
    
}
