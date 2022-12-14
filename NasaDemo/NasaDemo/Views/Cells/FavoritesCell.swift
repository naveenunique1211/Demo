//
//  FavoritesCell.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Nuke
import UIKit

class FavoritesCell: UITableViewCell {

    /// Thumbnail image view
    @IBOutlet private var thumbnailImageView: UIImageView! {
        didSet {
            thumbnailImageView.accessibilityIdentifier = FavoritesCellAccessibilityIdentifier.Image.thumbnailImageView
        }
    }
    
    /// Date label
    @IBOutlet private var dateLabel: UILabel! {
        didSet {
            dateLabel.accessibilityIdentifier = FavoritesCellAccessibilityIdentifier.Label.dateLabel
            dateLabel.font = DynamicFont.shared.font(forTextStyle: .footnote)
            dateLabel.adjustsFontForContentSizeCategory = true
        }
    }
    
    /// Title label
    @IBOutlet private var titleLabel: UILabel! {
        didSet {
            titleLabel.accessibilityIdentifier = FavoritesCellAccessibilityIdentifier.Label.titleLabel
            titleLabel.font = DynamicFont.shared.font(forTextStyle: .title3)
            titleLabel.adjustsFontForContentSizeCategory = true
        }
    }
    
    /// Explanation label
    @IBOutlet private var explanationLabel: UILabel! {
        didSet {
            explanationLabel.accessibilityIdentifier = FavoritesCellAccessibilityIdentifier.Label.explanationLabel
            explanationLabel.font = DynamicFont.shared.font(forTextStyle: .caption1)
            explanationLabel.adjustsFontForContentSizeCategory = true
            explanationLabel.isAccessibilityElement = false
        }
    }
    
    /// Placeholder image
    static let placeholderImage = UIImage(named: "Missing Image Placeholder")
    
    /// Cell height
    static let estimatedHeight: CGFloat = 140
    
    /// View model
    var viewModel: ApodViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            dateLabel.text = viewModel.date
            titleLabel.text = viewModel.title
            explanationLabel.text = viewModel.explanation
            updateImageView(with: viewModel.thumbnailURL)
            updateAccessibilityAttributes(with: viewModel)
        }
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        thumbnailImageView.roundCorners(radius: 5)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        thumbnailImageView.image = nil
        Nuke.cancelRequest(for: thumbnailImageView)
    }
}

extension FavoritesCell {
    private func updateImageView(with url: URL?) {
        guard let url = url else {
            thumbnailImageView.image = FavoritesCell.placeholderImage
            return
        }
        let imageLoadingOptions = ImageLoadingOptions(
            transition: .fadeIn(duration: 0.25),
            failureImage: FavoritesCell.placeholderImage
        )
        Nuke.loadImage(with: url, options: imageLoadingOptions, into: thumbnailImageView)
    }
}

// MARK: - Accesibility

extension FavoritesCell {
    private func updateAccessibilityAttributes(with viewModel: ApodViewModel) {
        isAccessibilityElement = true
        accessibilityLabel = "\(viewModel.preferredDate ?? viewModel.date). \(viewModel.title)"
        accessibilityHint = "Double tap to show more details."
    }
}
