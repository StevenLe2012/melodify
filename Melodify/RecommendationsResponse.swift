//
//  RecommendationsResponse.swift
//  Melodify
//
//  Created by Steven Le on 11/14/23.
//

import Foundation

// Root object for the API response
struct RecommendationsResponse: Decodable {
  let seeds: [RecommendationSeed]
  let tracks: [Track]
}

// Represents a recommendation seed object
struct RecommendationSeed: Decodable {
  let afterFilteringSize: Int
  let afterRelinkingSize: Int
  let href: String?
  let id: String
  let initialPoolSize: Int
  let type: String
}

// Represents a track object
struct Track: Decodable {
  let album: Album
  let artists: [Artist]
  let availableMarkets: [String]
  let discNumber: Int
  let durationMs: Int
  let explicit: Bool
  let externalUrls: ExternalUrls
  let href: String
  let id: String
  let isPlayable: Bool?
  let linkedFrom: LinkedFrom?
  let name: String
  let popularity: Int
  let previewUrl: String?
  let trackNumber: Int
  let type: String
  let uri: String
  let isLocal: Bool
  
  enum CodingKeys: String, CodingKey {
    case album, artists, availableMarkets = "available_markets",
         discNumber = "disc_number",
         durationMs = "duration_ms",
         explicit, externalUrls = "external_urls",
         href, id, isPlayable = "is_playable",
         linkedFrom = "linked_from",
         name, popularity, previewUrl = "preview_url",
         trackNumber = "track_number",
         type, uri, isLocal = "is_local"
  }
}


struct Album: Decodable {
  let albumType: String
  let totalTracks: Int
  let availableMarkets: [String]
  let externalUrls: ExternalUrls
  let href: String
  let id: String
  let images: [ImageObject]
  let name: String
  let releaseDate: String
  let releaseDatePrecision: String
  let restrictions: Restrictions?
  let type: String
  let uri: String
  let artists: [SimplifiedArtist]
  
  enum CodingKeys: String, CodingKey {
    case albumType = "album_type"
    case totalTracks = "total_tracks"
    case availableMarkets = "available_markets"
    case externalUrls = "external_urls"
    case href, id, images, name
    case releaseDate = "release_date"
    case releaseDatePrecision = "release_date_precision"
    case restrictions, type, uri, artists
  }
}

struct Restrictions: Decodable {
  let reason: String
}

struct SimplifiedArtist: Decodable {
  let externalUrls: ExternalUrls
  let href: String
  let id: String
  let name: String
  let type: String
  let uri: String
  
  enum CodingKeys: String, CodingKey {
    case externalUrls = "external_urls"
    case href, id, name, type, uri
  }
}


struct Artist: Decodable {
  let externalUrls: ExternalUrls
  let followers: Followers?
  let genres: [String]
  let href: String
  let id: String
  let images: [ImageObject]
  let name: String
  let popularity: Int
  let type: String
  let uri: String
  
  enum CodingKeys: String, CodingKey {
    case externalUrls = "external_urls"
    case followers, genres, href, id, images, name, popularity, type, uri
  }
}

struct Followers: Decodable {
  let total: Int
}

struct ImageObject: Decodable {
  let url: String
  let height: Int?
  let width: Int?
}

struct ExternalUrls: Decodable {
  let spotify: String
}

struct LinkedFrom: Decodable {
  let externalUrls: ExternalUrls
  let href: String
  let id: String
  let type: String
  let uri: String
  
  enum CodingKeys: String, CodingKey {
    case externalUrls = "external_urls"
    case href, id, type, uri
  }
}
