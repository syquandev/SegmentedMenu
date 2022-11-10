//
//  ColorViewController.swift
//  SegmentedMenu_Example
//
//  Created by Quan on 10/11/2022.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    public static func create() -> ColorViewController{
        let vc = UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ColorViewController") as! ColorViewController
        return vc
    }

}
