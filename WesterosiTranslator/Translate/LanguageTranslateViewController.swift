//
//  LanguageTranslateViewController.swift
//  WesterosiTranslator
//
//  Created by Tyler Poland on 12/8/19.
//  Copyright © 2019 Tyler Poland. All rights reserved.
//

import UIKit

class LanguageTranslateViewController: KeyboardAvoidingViewController {
    lazy private var viewModel: LanguageTranslateViewModel = {
        return LanguageTranslateViewModel()
    }()
    var language: LanguageType?
    var translatedText: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.updateUI = { [weak self] () in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.updateView()
            }
        }
    }

    func updateView() {
        guard let newText = self.translatedText else { return }
        self.translatedTextOutputLabel.text = newText
    }
    
    
    @IBOutlet weak var translateTextTitleLabel: UILabel! {
        didSet {
            translateTextTitleLabel.text = "Text to translate"
        }
    }
    @IBOutlet weak var inputTextView: UITextField!
    @IBOutlet weak var translatedTextTitleLabel: UILabel! {
        didSet {
            guard let language = language else { return }
            translatedTextTitleLabel.text = "\(language.readableString):"
            translatedTextTitleLabel.isHidden = translatedTextOutputLabel.text == ""
        }
    }
    @IBOutlet weak var translatedTextOutputLabel: UILabel! {
        didSet {
            translatedTextOutputLabel.isHidden = translatedTextOutputLabel.text == ""
        }
    }
    
    @IBAction func translateButtonPressed(_ sender: Any) {
        guard let text = inputTextView.text, let language = self.language else {
            /* show some kind of user error and then */return
        }
        viewModel.performTranslation(with: text, language: language)
    }
    
}
