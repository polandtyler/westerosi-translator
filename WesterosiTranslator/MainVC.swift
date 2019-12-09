//
//  ViewController.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func dothrakiButtonWasTapped(_ sender: Any) {
        let vc = LanguageTranslateViewController(language: .dothraki)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func valyrianButtonWasTapped(_ sender: Any) {
        let vc = LanguageTranslateViewController(language: .highValyrian)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

