//
//  ViewController.swift
//  ChatGPT
//
//  Created by Bill Chang on 2023/5/24.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var answerTextField: NSScrollView!
    @IBOutlet weak var codeTextField: NSScrollView!

    @IBOutlet weak var languageOption: NSPopUpButton!
    @IBOutlet weak var questionOption: NSPopUpButton!
    @IBOutlet weak var APIKeyTextField: NSTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onAskButtonPressed(_ sender: Any) {
        let myTextView: NSTextView = codeTextField.documentView! as! NSTextView
        
        print(myTextView.string)
    }
    
}

