//
//  ImageModel.swift
//  O2H
//
//  Created by Vikash on 24/10/23.
//

import Foundation

struct ImageInfo: Codable {
    var urls: ImageURLs
}
struct ImageURLs: Codable {
    var raw: String
    var full: String
    var regular: String
    var small: String
    var thumb: String
}
