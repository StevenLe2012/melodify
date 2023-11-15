//
//  RecommendationsResponse.swift
//  Melodify
//
//  Created by Steven Le on 11/14/23.
//

import Foundation
// Root object for the API response
struct RecommendationsResponse: Decodable {
  // let seeds: [RecommendationSeed]?
  let tracks: [Track]?
}
// Represents a recommendation seed object
// Represents a track object
struct Track: Decodable {
  let album: Album?
  let artists: [Artist]?
  let name: String?
  let previewUrl: String?
}
struct Album: Decodable {
  let albumType: String?
  // let images: [ImageObject]?
//  let name: String?
//  let artists: [SimplifiedArtist]
  enum CodingKeys: String, CodingKey {
    case albumType = "album_type"
  }
}
struct Restrictions: Decodable {
  let reason: String?
}
struct SimplifiedArtist: Decodable {
  let externalUrls: ExternalUrls?
  let href: String?
  let id: String?
  let name: String?
  let type: String?
  let uri: String?
  enum CodingKeys: String, CodingKey {
    case externalUrls = "external_urls"
    case href, id, name, type, uri
  }
}
struct Artist: Decodable {
  let name: String?
}
struct Followers: Decodable {
  let total: Int?
}
struct ImageObject: Decodable {
  let url: String
  let height: Int?
  let width: Int?
}
struct ExternalUrls: Decodable {
  let spotify: String?
}
struct LinkedFrom: Decodable {
  let externalUrls: ExternalUrls
  let href: String?
  let id: String?
  let type: String?
  let uri: String?
  enum CodingKeys: String, CodingKey {
    case externalUrls = "external_urls"
    case href, id, type, uri
  }
}
