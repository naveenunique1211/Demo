//
//  MessageView.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import UIKit

@IBDesignable
class MessageView: UIView {
    
    /// Content view
    @IBOutlet var contentView: UIView!
    
    /// Image view
    @IBOutlet var imageView: UIImageView! {
        didSet {
            imageView.accessibilityIdentifier = MessageViewAccessibilityIdentifier.Image.imageView
        }
    }
    
    /// Label view
    @IBOutlet var label: UILabel! {
        didSet {
            label.accessibilityIdentifier = MessageViewAccessibilityIdentifier.Label.label
            label.font = UIFont.systemFont(ofSize: 20)
        }
    }
    
    /// Refresh button
    @IBOutlet var refreshButton: UIButton! {
        didSet {
            refreshButton.accessibilityIdentifier = MessageViewAccessibilityIdentifier.Button.refreshButton
            refreshButton.isHidden = true
            refreshButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            refreshButton.accessibilityHint = "Double tap to try again."
        }
    }
    
    /// Refresh button completion handler
    var refreshButtonHandler: (() -> Void)?
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadViewFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViewFromNib()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        loadViewFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        refreshButton.roundCorners(radius: 20.0)
    }
    
    private func loadViewFromNib() {
        Bundle(for: MessageView.self).loadNibNamed(String(describing: MessageView.self), owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    @IBAction func didTapOnRefreshButton(_ sender: UIButton) {
        refreshButtonHandler?()
    }
}
