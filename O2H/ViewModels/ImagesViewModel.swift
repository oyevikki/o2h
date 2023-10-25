//
//  ImagesViewModel.swift
//  O2H
//
//  Created by Vikash on 24/10/23.
//

import Foundation
import UIKit

class ImagesViewModel : ObservableObject {
    @Published var downloadedImages: [UIImage] = []
    @Published var images: [UIImage] = []
    @Published var isLoading: Bool = false
    
    func fetchImageUrls(page: Int, per_page: Int) {
        isLoading = true
        guard let url = URL(string: "https://api.unsplash.com/photos/") else {
            return
        }
        
        var components = URLComponents(url: url, resolvingAgainstBaseURL: false)
        components?.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "per_page", value: "\(per_page)")
        ]
        
        guard let paginatedURL = components?.url else {
            return
        }
        
        let accessToken = "HzWn8H-u7jvM82onj3-7uyMfjtdXbFBYnN_jzfzjrus"
        var request = URLRequest(url: paginatedURL)
        request.addValue("Client-ID \(accessToken)", forHTTPHeaderField: "Authorization")
        
        
        
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode([ImageInfo].self, from: data)
                    DispatchQueue.global().async { [self] in
                        for imageInfo in response {
                            if let imageUrl = URL(string: imageInfo.urls.small),
                               let imageData = try? Data(contentsOf: imageUrl),
                               let image = UIImage(data: imageData) {
                                saveImagesToUserDefaults(image1: image)
                                DispatchQueue.main.async { [self] in
                                    self.images.append(image)
                                    isLoading = false
                                }
                            }
                        }
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            } else if let error = error {
                print("Network error: \(error)")
            }
        }.resume()
    }

    func saveImagesToUserDefaults(image1: UIImage) {
        if let imageData = image1.pngData() {
            var savedImagesData = UserDefaults.standard.array(forKey: "savedImages") as? [Data] ?? []
            if !savedImagesData.contains(imageData) {
                savedImagesData.append(imageData)
                UserDefaults.standard.set(savedImagesData, forKey: "savedImages")
            }
        }
    }

    func readImagesFromUserDefaults() -> [UIImage] {
        var downloadedImages: [UIImage] = []

        if let savedImageDataArray = UserDefaults.standard.array(forKey: "savedImages") as? [Data] {
            for savedImageData in savedImageDataArray {
                if let savedImage = UIImage(data: savedImageData) {
                    downloadedImages.append(savedImage)
                }
            }
        }

        return downloadedImages
    }

}
