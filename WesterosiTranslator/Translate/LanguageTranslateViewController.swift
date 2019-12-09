//
//  LanguageTranslateViewController.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import UIKit

class LanguageTranslateViewController: UIViewController {
    lazy private var viewModel: LanguageTranslateViewModel = {
        return LanguageTranslateViewModel()
    }()
    var language: LanguageType
    
    init(language: LanguageType) {
        self.language = language
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "\(language.readableString) Translator"
        
        viewModel.updateUI = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.translatedTextOutputLabel.text = self.viewModel.translationText
            }
        }
    }
    
    //MARK: Outlets
    @IBOutlet weak var translateTextTitleLabel: UILabel! {
        didSet {
            translateTextTitleLabel.text = "Text to translate"
        }
    }
    @IBOutlet weak var inputTextView: UITextField!
    @IBOutlet weak var translatedTextTitleLabel: UILabel! {
        didSet {
            translatedTextTitleLabel.text = "\(language.readableString):"
        }
    }
    @IBOutlet weak var translatedTextOutputLabel: UILabel!
    @IBOutlet weak var loadingSpinner: UIActivityIndicatorView! {
        didSet {
            loadingSpinner.hidesWhenStopped = true
        }
    }
    
    //MARK: Actions
    @IBAction func translateButtonPressed(_ sender: Any) {
        guard let text = inputTextView.text else {
            /* show some kind of user error and then */return
        }
        loadingSpinner.isHidden = false
        loadingSpinner.startAnimating()
        
        viewModel.performTranslation(with: text, language: language) { success, error in
            if !success {
                let alertVc = UIAlertController(title: "Error", message: "Unable to perform translation. Error: \(error ?? "")", preferredStyle: .alert)
                alertVc.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alertVc, animated: true, completion: nil)
            }
            self.loadingSpinner.stopAnimating()
        }
    }
    
}
