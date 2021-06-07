//
//  HomeViewController.swift
//  Retext
//
//  Created by Abraham Estrada on 6/1/21.
//

import UIKit

class HomeViewController: UIViewController {
    
    // MARK: - Properties
    
    private lazy var scrollView: UIScrollView = {
        let sv = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        sv.contentSize = CGSize(width: view.frame.width, height: 600)
        return sv
    }()
    
    private let inputBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let textLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Text"
        label.textColor = TINTCOLOR
        label.textAlignment = .center
        return label
    }()
    
    private let textTextField: UITextField = {
        let tf = CustomTextField(placeholder: "Enter a text here...")
        tf.setHeight(50)
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let repetitionsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Repeats"
        label.textColor = TINTCOLOR
        label.textAlignment = .center
        return label
    }()
    
    private let repeatsTextField: UITextField = {
        let tf = CustomTextField(placeholder: "ex: 12")
        tf.setHeight(50)
        tf.keyboardType = .numberPad
        tf.font = UIFont.boldSystemFont(ofSize: 16)
        tf.autocapitalizationType = .none
        return tf
    }()
    
    private let resultBubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    private let resultLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "Result"
        label.textColor = TINTCOLOR
        label.textAlignment = .center
        return label
    }()
    
    private let resultTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = BACKGROUNDCOLOR
        tv.isEditable = false
        tv.tintColor = TINTCOLOR
        tv.layer.cornerRadius = 12
        tv.text = "Your result will appear here..."
        tv.textAlignment = .center
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.setHeight(175)
        return tv
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Copy", for: .normal)
        button.setTitleColor(TINTCOLOR, for: .normal)
        button.setDimensions(height: 35, width: 75)
        button.backgroundColor = BACKGROUNDCOLOR
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(handleCopyTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Save", for: .normal)
        button.setTitleColor(TINTCOLOR, for: .normal)
        button.setDimensions(height: 35, width: 75)
        button.backgroundColor = BACKGROUNDCOLOR
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(handleSaveTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var retextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Retext", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = TINTCOLOR
        button.layer.cornerRadius = 12
        button.setHeight(50)
        button.addTarget(self, action: #selector(handleRetextTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
        configureUI()
    }
    
    // MARK: - Actions
    
    @objc func handleRetextTapped() {
        let repeats = Int(repeatsTextField.text!)
        guard let repeats = repeats else {
            showMessage(withTitle: "Error", message: "Please enter a number for repeats.")
            return
        }
        let repeatedString = Repeater.repeatString(textTextField.text!, repeats: repeats)
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 1.0)
        resultTextView.text = repeatedString
    }
    
    @objc func handleCopyTapped() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = resultTextView.text
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred(intensity: 1.0)
        showAlert(title: "Copied to Clipboard", message: "")
    }
    
    @objc func handleSaveTapped() {
        var retexts = UserDefaults.standard.array(forKey: RETEXTSKEY) as? [String] ?? [String]()
        retexts.append(resultTextView.text)
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred(intensity: 1.0)
        UserDefaults.standard.set(retexts, forKey: RETEXTSKEY)
        showAlert(title: "Retext Saved", message: "")
    }
    
    // MARK: - Helpers
    
    func configureUI() {
        view.backgroundColor = BACKGROUNDCOLOR
        navigationItem.title = "Retext: Text Repeater"
        
        view.addSubview(scrollView)
        
        scrollView.addSubview(inputBubbleView)
        inputBubbleView.setDimensions(height: 200, width: view.frame.width - 50)
        inputBubbleView.centerX(inView: scrollView, topAnchor: scrollView.topAnchor, paddingTop: 12)
        
        let textStack = UIStackView(arrangedSubviews: [textLabel, textTextField])
        textStack.axis = .vertical
        textStack.spacing = 8
        
        scrollView.addSubview(textStack)
        textStack.anchor(top: inputBubbleView.topAnchor, left: inputBubbleView.leftAnchor, right: inputBubbleView.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16)
        
        let repeatsStack = UIStackView(arrangedSubviews: [repetitionsLabel, repeatsTextField])
        repeatsStack.axis = .vertical
        repeatsStack.spacing = 8
        
        scrollView.addSubview(repeatsStack)
        repeatsStack.anchor(top: textStack.bottomAnchor, left: inputBubbleView.leftAnchor, right: inputBubbleView.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16)
        
        scrollView.addSubview(resultBubbleView)
        resultBubbleView.setDimensions(height: 275, width: view.frame.width - 50)
        resultBubbleView.centerX(inView: scrollView, topAnchor: inputBubbleView.bottomAnchor, paddingTop: 12)
        
        let resultStack = UIStackView(arrangedSubviews: [resultLabel, resultTextView])
        resultStack.axis = .vertical
        resultStack.spacing = 8
        
        scrollView.addSubview(resultStack)
        resultStack.anchor(top: resultBubbleView.topAnchor, left: resultBubbleView.leftAnchor, right: resultBubbleView.rightAnchor, paddingTop: 12, paddingLeft: 16, paddingRight: 16)
        
        let copyAndSaveButtonsStack = UIStackView(arrangedSubviews: [copyButton, saveButton])
        copyAndSaveButtonsStack.alignment = .center
        copyAndSaveButtonsStack.spacing = 50
        
        scrollView.addSubview(copyAndSaveButtonsStack)
        copyAndSaveButtonsStack.centerX(inView: resultBubbleView, topAnchor: resultStack.bottomAnchor, paddingTop: 12)
        
        scrollView.addSubview(retextButton)
        retextButton.centerX(inView: scrollView, topAnchor: resultBubbleView.bottomAnchor, paddingTop: 24)
        retextButton.setWidth(200)
    }
}
