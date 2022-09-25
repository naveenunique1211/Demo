//
//  DiscoverCell.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Nuke
import UIKit

class DiscoverCell: UICollectionViewCell {

    /// Image view
    @IBOutlet private var imageView: UIImageView! {
        didSet {
            imageView.accessibilityIdentifier = SearchCellAccessibilityIdentifier.Image.imageView
        }
    }
    
    /// Date label
    @IBOutlet private var dateLabel: UILabel! {
        didSet {
            dateLabel.accessibilityIdentifier = SearchCellAccessibilityIdentifier.Label.dateLabel
            dateLabel.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        }
    }
    
    /// Title label
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.accessibilityIdentifier = SearchCellAccessibilityIdentifier.Label.titleLabel
            titleLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        }
    }
    
    /// Activity indicator
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    /// Placeholder image
    static let placeholderImage = UIImage(named: "Missing Image Placeholder")
    
    /// View model
    var viewModel: ApodViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            titleLabel.text = viewModel.title
            dateLabel.text = viewModel.preferredDate ?? viewModel.date
            updateImageView(with: viewModel.thumbnailURL)
            updateAccessibilityAttributes(with: viewModel)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        // Update shadow
        setShadow(opacity: 0.2, radius: 20)
        
        // Update corner radius
        contentView.roundCorners(radius: 20)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        Nuke.cancelRequest(for: imageView)
    }
    
    @IBAction func actionOnDate(_ sender: UIButton) {
    }
    
}

extension DiscoverCell {
    private func updateImageView(with url: URL?) {
        guard let url = url else {
            imageView.image = DiscoverCell.placeholderImage
            return
        }
        activityIndicator.startAnimating()
        let imageLoadingOptions = ImageLoadingOptions(
            transition: .fadeIn(duration: 0.25),
            failureImage: DiscoverCell.placeholderImage
        )
        Nuke.loadImage(with: url, options: imageLoadingOptions, into: imageView, completion: { [weak self] _ in
            self?.activityIndicator.stopAnimating()
        })
    }
}

// MARK: - Accesibility

extension DiscoverCell {
    private func updateAccessibilityAttributes(with viewModel: ApodViewModel) {
        isAccessibilityElement = true
        accessibilityLabel = "\(viewModel.preferredDate ?? viewModel.date). \(viewModel.title)"
        accessibilityHint = "Double tap to show more details."
    }
}
