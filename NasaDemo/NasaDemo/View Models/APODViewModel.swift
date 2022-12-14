//
//  ApodViewModel.swift
//  NasaDemo
//
//  Created by Naveen on 24/09/22.
//

import Foundation

struct ApodViewModel {
    
    /// Astronomy picture of the day
    let apod: Apod
    
    /// Title
    var title: String {
         apod.title
    }
     
    /// Formatted date
    var date: String {
        DateFormatter(locale: .current, format: "EEEE, MMM d").string(from: apod.date)
    }
    
    /// Explanation
    var explanation: String {
        apod.explanation.isEmpty ? DetailViewStrings.missingExplanation.localized : apod.explanation
    }
     
    /// Media type
    var mediaType: Apod.MediaType {
         apod.mediaType
    }
     
    /// Prefered date
    var preferredDate: String? {
        if apod.date.isToday {
            return DetailViewStrings.today.localized
        } else if apod.date.isYesterday {
            return DetailViewStrings.yesterday.localized
        }
        return nil
    }
    
    /// Copyright attributed string
    var copyright: NSMutableAttributedString? {
         if let author = apod.copyright {
            let string = String(format: DetailViewStrings.copyright.localized, author)
            let attributedText = NSMutableAttributedString(string: string, attributes: [.font: DynamicFont.shared.font(forTextStyle: .body)])
            attributedText.addForegroundColorAttribute(toSubString: "Copyright:", foregroundColor: .label)
            return attributedText
        }
         return nil
    }
    
    /// Media URL
    var mediaURL: URL {
        apod.mediaURL
    }
    
    /// Thumbnail URL
    var thumbnailURL: URL? {
        switch apod.mediaType {
        case .image: return apod.mediaURL
        case .video: return apod.thumbnailURL ?? nil
        }
    }
    
    init(apod: Apod) {
        self.apod = apod
    }
}

extension ApodViewModel: Comparable {
    static func < (lhs: ApodViewModel, rhs: ApodViewModel) -> Bool {
        lhs.apod < rhs.apod
    }
}

extension ApodViewModel: Hashable {
    func hash(into hasher: inout Hasher) {
        apod.hash(into: &hasher)
    }
}
