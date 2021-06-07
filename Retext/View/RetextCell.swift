//
//  RetextCell.swift
//  Retext
//
//  Created by Abraham Estrada on 6/2/21.
//

import UIKit

protocol RetextCellDelegate: AnyObject {
    func didTapCopy(retext: String)
}

class RetextCell: UITableViewCell {
    
    // MARK: - Properties
    
    var delegate: RetextCellDelegate?
    
    private let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 12
        return view
    }()
    
    let retextTextView: UITextView = {
        let tv = UITextView()
        tv.backgroundColor = BACKGROUNDCOLOR
        tv.isEditable = false
        tv.tintColor = TINTCOLOR
        tv.layer.cornerRadius = 12
        tv.textAlignment = .center
        tv.font = UIFont.boldSystemFont(ofSize: 16)
        tv.setHeight(90)
        return tv
    }()
    
    private lazy var copyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Copy", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setDimensions(height: 35, width: 75)
        button.backgroundColor = TINTCOLOR
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(handleCopyTapped), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        contentView.isUserInteractionEnabled = false
        backgroundColor = BACKGROUNDCOLOR
        
        addSubview(bubbleView)
        bubbleView.anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, paddingTop: 6, paddingLeft: 12, paddingBottom: 6, paddingRight: 12)
        
        addSubview(copyButton)
        copyButton.centerY(inView: bubbleView)
        copyButton.anchor(right: bubbleView.rightAnchor, paddingRight: 12)
        
        addSubview(retextTextView)
        retextTextView.centerY(inView: bubbleView)
        retextTextView.anchor(left: bubbleView.leftAnchor, right: copyButton.leftAnchor, paddingLeft: 12, paddingRight: 12)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    @objc func handleCopyTapped() {
        delegate?.didTapCopy(retext: retextTextView.text)
    }
}
