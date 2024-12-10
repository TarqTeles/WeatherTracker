//
//  WeatherIconCache.swift
//  WeatherTracker
//
//  Created by Tarquinio Teles on 09/12/24.
//

import SwiftUI

actor WeatherIconCache {
    private var cachedIcons = [String : Data]()
    private let missingIcon = Samples.missingIconImage

    func iconImage(for str: String) -> Image {
        guard let image = cachedIconImage(for: str) else { return missingIcon }
        return image
    }
    
    func cachedIconImage(for str: String) -> Image? {
        guard let data = cachedIcons[str]  else { return nil }
        return imageFrom(data: data)
    }
    
    func imageFrom(data: Data, cachingTo condition: Condition) -> Image {
        let image = imageFrom(data: data)
        if image != missingIcon {
            cachedIcons[condition.icon] = data
        }
        return image
    }
    
    nonisolated func imageFrom(data: Data) -> Image {
        if let uiImg = UIImage(data: data) {
            return Image(uiImage: uiImg)
        } else {
            return missingIcon
        }
    }
}

