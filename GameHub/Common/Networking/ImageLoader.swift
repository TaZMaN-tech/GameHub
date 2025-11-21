//
//  ImageLoader.swift
//  GameHub
//
//  Created by Тадевос Курдоглян on 18.11.2025.
//

import UIKit

final class ImageLoader {
    
    static let shared = ImageLoader()
    
    private let cache = NSCache<NSURL, UIImage>()
    private let session: URLSession
    
    private init(session: URLSession = .shared) {
        self.session = session
    }
    
    func loadImage(from url: URL, completion: @escaping (UIImage?) -> Void) {
        let key = url as NSURL
        
        if let cachedImage = cache.object(forKey: key) {
            completion(cachedImage)
            return
        }
        
        
        let task = session.dataTask(with: url) { [weak self ] data, _, error in
            guard let self,
                  let data,
                  error == nil,
                  let Image = UIImage(data: data) else {
                DispatchQueue.main.async { completion(nil) }
                return
            }
            
            self.cache.setObject(Image, forKey: key)
            DispatchQueue.main.async {
                completion(Image)
            }
        }
        task.resume()
    }
}
