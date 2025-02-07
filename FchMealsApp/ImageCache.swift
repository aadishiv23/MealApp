//
//  ImageCache.swift
//  FchMealsApp
//
//  Created by Aadi Shiv Malhotra on 2/7/25.
//

import Foundation
import SwiftUI

/// Manages image downloading and caching.
class ImageCache {
    static let shared = ImageCache()
    private let cacheDirectory = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first!

    func loadImage(from url: URL) async -> UIImage? {
        let fileURL = cacheDirectory.appendingPathComponent(url.lastPathComponent)

        // Check if image exists in cache
        if FileManager.default.fileExists(atPath: fileURL.path),
           let imageData = try? Data(contentsOf: fileURL),
           let image = UIImage(data: imageData) {
            return image
        }

        // Download and cache image
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            try data.write(to: fileURL)
            return UIImage(data: data)
        } catch {
            return nil
        }
    }
}
