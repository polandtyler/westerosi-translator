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
        let vc = LanguageTranslateViewController()
        vc.language = .dothraki
        present(vc, animated: true, completion: nil)
    }
    
    
    @IBAction func valyrianButtonWasTapped(_ sender: Any) {
        let vc = LanguageTranslateViewController()
        vc.language = .highValyrian
        present(vc, animated: true, completion: nil)
    }
    
}

