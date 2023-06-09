//
//  ViewController.swift
//  ChatGPT
//
//  Created by Bill Chang on 2023/5/24.
//

import Cocoa

enum QuestionType: String {
    case ConvertJSONStruct = "Convert JSON Struct"
    case CodeSmells = "Code Smells"
    case ExplainCodes = "Explain Codes"
    case TestCases = "Test Cases"
    case GenerateComments = "Generate Comments"
    case Others = "Others"
}

class ViewController: NSViewController {

    @IBOutlet weak var loadingView: NSProgressIndicator!
    @IBOutlet weak var answerTextField: NSScrollView!
    @IBOutlet weak var codeTextField: NSScrollView!

    @IBOutlet weak var languageOption: NSPopUpButton!
    @IBOutlet weak var questionOption: NSPopUpButton!
    @IBOutlet weak var APIKeyTextField: NSTextField!
    let APIKey = "APIKEY"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let api = UserDefaults.standard.string(forKey: APIKey)
        if let api {
            APIKeyTextField.stringValue = api
        }
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func onFreeButtonPressed(_ sender: Any) {
        if let openAIURL = URL(string: "https://platform.openai.com/account/api-keys") {
            NSWorkspace.shared.open(openAIURL)
        }
    }
    
    @IBAction func onAskButtonPressed(_ sender: Any) {
        let myCodeView: NSTextView = codeTextField.documentView! as! NSTextView
        if APIKeyTextField.stringValue.isEmpty {
            let alert = showWarningAlert("Error", text: "Please Enter APIKey")
            alert.runModal()
            return
        } else if myCodeView.string.isEmpty {
            let alert = showWarningAlert("Error", text: "Please Enter Source Code")
            alert.runModal()
            return
        }
        
        let apiKey = APIKeyTextField.stringValue
        let languageStr = languageOption.title
        let sourceCodeStr = myCodeView.string
        let questionType = questionOption.title
        var question: BaseChatGPTRepository?
        UserDefaults.standard.set(apiKey, forKey: APIKey)
        switch QuestionType(rawValue: questionType) {
        case .ConvertJSONStruct:
            question = ChatGPTJSONConverterRepository()
            break
            
        case .CodeSmells:
            question = ChatGPTCodeSmellsRepository()
            break
            
        case .ExplainCodes:
            question = ChatGPTExplainCodeRepository()
            break
            
        case .TestCases:
            question = ChatGPTUnitTestRepository()
            break
            
        case .GenerateComments:
            question = ChatGPTCommentRepository()
            break
            
        case .Others:
//            let alert = showWarningAlert("Error", text: "Developing....")
//            alert.runModal()
            question = ChatGPTOthersRepository()
            break
            
        case .none:
            print("[Error] Don't support \(questionType)")
            break
        }
        
        if let question = question {
            Task {
                do {
                    let myAnswerView: NSTextView = answerTextField.documentView! as! NSTextView
                    DispatchQueue.main.async {
                        self.loadingView.startAnimation(nil)
                        myAnswerView.string = ""
                    }
                    
                    let suggestion = try await question.askChatGPTFor(apiKey, source: sourceCodeStr, language: languageStr)
                    
                    print("Result \(suggestion.result)")
                    
                    DispatchQueue.main.async {
                        myAnswerView.string = suggestion.result
                        self.loadingView.stopAnimation(nil)
                    }
                } catch let error {
                    let alert = showWarningAlert("Error", text: "🚨 Something goes wrong... \(error)")
                    alert.runModal()
                    
                    DispatchQueue.main.async {
                        self.loadingView.stopAnimation(nil)
                    }
                }
            }
            
        }
        
    }
    
    func showWarningAlert(_ question: String, text: String) -> NSAlert {

        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.addButton(withTitle: "OK")

        alert.alertStyle = .warning
        return alert

    }
    
}

