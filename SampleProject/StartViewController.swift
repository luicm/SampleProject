//
//  StartViewController.swift
//  SampleProject
//
//  Created by Luisa Cruz Molina on 29/06/2016.
//  Copyright © 2016 Luisa Cruz Molina. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationController?.navigationBar.tintColor = UIColor.whiteColor()
    }

    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.navigationItem.backBarButtonItem?.tintColor = UIColor.whiteColor()
    }
    
    
}

