//
//  Song.swift
//  Melodify
//
//  Created by Steven Le on 11/13/23.
//

import Foundation

struct Showcase: Decodable {
  let response: Response
}

struct Response: Decodable {
  let songs: [Song]
}

struct Song: Decodable {
  let title: String
  let author: String
  let photos: [Photo]
}

struct Photo: Decodable {
  let originalSize: PhotoInfo
  
  enum CodingKeys: String, CodingKey {
    
    // Maps API key name to a more "swifty" version (i.e. lowerCamelCasing and no `_`)
    case originalSize = "original_size"
  }
}

struct PhotoInfo: Decodable {
  let url: URL
}
