//
//  AccessibilityIdentifiers.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation


// MARK: - Detail View Accessibility Identifiers

enum DetailViewAccessibilityIdentifier {
    enum Image {
        static let imageView = "DetailImageViewIdentifier"
    }
    enum WebView {
        static let webView = "DetailWebViewIdentifier"
    }
    enum Label {
        static let dateLabel = "DetailDateLabelIdentifier"
        static let titleLabel = "DetailTitleLabelIdentifier"
        static let explanationLabel = "DetailExplanationLabelIdentifier"
        static let copyrightLabel = "DetailCopyrightLabelIdentifier"
    }
    enum Button {
        static let favoritesButton = "FavoriteButtonIdentifier"
        static let shareButton = "DetailShareButtonIdentifier"
        static let saveToPhotosButton = "SaveToPhotosButtonIdentifier"
    }
}

// MARK: - Search View Accessibility Identifiers

enum SearchCellAccessibilityIdentifier {
    enum Image {
        static let imageView = "DiscoverImageViewIdentifier"
    }
    enum Label {
        static let dateLabel = "DiscoverDateLabelIdentifier"
        static let titleLabel = "DiscoverTitleLabelIdentifier"
    }
}

// MARK: - Favorites View Accessibility Identifiers

enum FavoritesCellAccessibilityIdentifier {
    enum Image {
        static let thumbnailImageView = "FavoritesThumbnailImageViewIdentifier"
    }
    enum Label {
        static let dateLabel = "FavoritesDateLabelIdentifier"
        static let titleLabel = "FavoritesTitleLabelIdentifier"
        static let explanationLabel = "FavoritesExplanationLabelIdentifier"
    }
}

// MARK: - Message View Accessibility Identifiers

enum MessageViewAccessibilityIdentifier {
    enum Image {
        static let imageView = "MessageImageViewIdentifier"
    }
    enum Label {
        static let label = "MessageLabelIdentifier"
    }
    enum Button {
        static let refreshButton = "MessageRefreshButtonIdentifier"
    }
}

// MARK: - More View Accessibility Identifiers

enum MoreViewAccessibilityIdentifier {
    enum Cell {
        static let cell = "MoreTableViewCellIdentifier"
    }
}
