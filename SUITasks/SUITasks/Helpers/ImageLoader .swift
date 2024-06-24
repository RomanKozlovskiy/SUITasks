//
//  ImageLoader .swift
//  SUITasks
//
//  Created by user on 18.06.2024.
//

import SwiftUI
import Combine

final class ImageLoader: ObservableObject {
    
    private var cancellable: AnyCancellable?
    private var imageCache = ImageCache.shared
    
    @Published var image: UIImage?
    @Published var isLoading: Bool = false
    
    func fetch(from stringUrl: String) {
        if let image = imageCache.object(for: stringUrl) {
            self.image = image
            return
        }
        
        guard let url = URL(string: stringUrl) else {
            return
        }
        
        isLoading = true
        
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 5
        configuration.timeoutIntervalForResource = 5
        
        cancellable = URLSession(configuration: configuration).dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in
                
                if let image = $0 {
                    self?.imageCache.setImage(image: image, for: stringUrl)
                }
                
                self?.image = $0
                self?.isLoading = false
            }
    }
    
    deinit {
        cancellable?.cancel()
    }
}

final class ImageCache {
    static let shared = ImageCache()
    private let cache = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func object(for key: String) -> UIImage? {
        cache.object(forKey: NSString(string: key))
    }
    
    func setImage(image: UIImage, for key: String) {
        cache.setObject(image, forKey: NSString(string: key))
    }
}
