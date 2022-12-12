//
//  FloatingPanelViewController.swift
//  gram
//
//  Created by Khurshed Umarov on 11.12.2022.
//

import UIKit
import FloatingPanel

class FloatingPanelViewController: UIViewController {
    
    private var floationPanelUIView: FloatingPanelUIView {
        self.view as! FloatingPanelUIView
    }
    
    var fpc: FloatingPanelController!
    
    override func loadView() {
        view = FloatingPanelUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        floationPanelUIView.delegate = self
    }
}

extension FloatingPanelViewController: FloationPanelUIViewDelegate {
    func searchTapped() {
        fpc.set(contentViewController: SearchPanelViewController())
        fpc.addPanel(toParent: self)
    }
}
