//
//  UIImageView+Ext.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 21.06.2023.
//

import UIKit

extension UIImageView {
    func downloaded(from imageURL: URL, contentMode mode: ContentMode = .scaleAspectFit) {

        let cache = URLCache.shared
        let request = URLRequest(url: imageURL)
        contentMode = mode

        if let data = cache.cachedResponse(for: request)?.data, let image = UIImage(data: data) {
            print("Resim cache den okundu")
            self.image = image
        } else {
            print("resim download edildi")
            URLSession.shared.dataTask(with: imageURL) { data, response, error in
                guard
                    let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                    let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                    let data = data, error == nil,
                    let image = UIImage(data: data)

                else { return }
                let cachedData = CachedURLResponse(response: httpURLResponse, data: data)
                cache.storeCachedResponse(cachedData, for: request)
                DispatchQueue.main.async() { [weak self] in
                    self?.image = image
                }
            }.resume()
        }
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}






