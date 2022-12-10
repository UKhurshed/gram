//
//  MainViewController.swift
//  gram
//
//  Created by Khurshed Umarov on 10.12.2022.
//

import UIKit

class MainViewController: UIViewController {
    
    private var mainUIView: MainUIView {
        self.view as! MainUIView
    }
    
    override func loadView() {
        view = MainUIView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

}
