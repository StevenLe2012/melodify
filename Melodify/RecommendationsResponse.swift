//
//  RecommendationsResponse.swift
//  Melodify
//
//  Created by Steven Le on 11/14/23.
//

import Foundation
// Root object for the API response
struct RecommendationsResponse: Codable {
  // let seeds: [RecommendationSeed]?
  let tracks: [Track]?
}
// Represents a recommendation seed object
// Represents a track object
struct Track: Codable, Equatable {
  static func == (lhs: Track, rhs: Track) -> Bool {
    var sameName = false
    if (lhs.name != nil && rhs.name != nil) {
      sameName = lhs.name == rhs.name;
    }
    
    var sameArtist = false
    if (lhs.artists?.first?.name != nil && rhs.artists?.first?.name != nil) {
      sameArtist = lhs.artists?.first?.name == rhs.artists?.first?.name
    }
    
    return sameName && sameArtist;
  }
  
  let album: Album?
  let artists: [Artist]?
  let name: String?
  let previewUrl: String?
}
struct Album: Codable {
  let albumType: String?
  let images: [ImageObject]?
  enum CodingKeys: String, CodingKey {
    case albumType = "album_type"
    case images = "images"
  }
}
struct ImageObject: Codable {
  let url: String?
  let height: Int?
  let width: Int?
}
struct Restrictions: Codable {
  let reason: String?
}
struct SimplifiedArtist: Codable {
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
struct Artist: Codable {
  let name: String?
}
struct Followers: Codable {
  let total: Int?
}
struct ExternalUrls: Codable {
  let spotify: String?
}
struct LinkedFrom: Codable {
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

// Methods for saving, retrieving and removing songs from Liked list
extension Track {
  // The "Favorites" key: a computed property that returns a String.
  //    - Use when saving/retrieving or removing from UserDefaults
  //    - `static` means this property is "Type Property" (i.e. associated with the Movie "type", not any particular movie instance)
  //    - We can access this property anywhere like this... `Movie.favoritesKey` (i.e. Type.property)
  static var favoritesKey: String {
    return "Favorites"
  }
  
  // Save an array of favorite movies to UserDefaults.
  //    - Similar to the favoritesKey, we add the `static` keyword to make this a "Type Method".
  //    - We can call it from anywhere by calling it on the `Track` type.
  //    - ex: `Track.save(favoriteMovies, forKey: favoritesKey)`
  // 1. Create an instance of UserDefaults
  // 2. Try to encode the array of `Movie` objects to `Data`
  // 3. Save the encoded movie `Data` to UserDefaults
  static func save(_ tracks: [Track], forKey key: String) {
    // 1.
    let defaults = UserDefaults.standard
    // 2.
    let encodedData = try! JSONEncoder().encode(tracks)
    // 3.
    defaults.set(encodedData, forKey: key)
  }
  
  // Get the array of favorite tracks from UserDefaults
  //    - Again, a static "Type method" we can call anywhere like this...`Track.getTracks(forKey: favoritesKey)`
  // 1. Create an instance of UserDefaults
  // 2. Get any favorite tracks `Data` saved to UserDefaults (if any exist)
  // 3. Try to decode the movie `Data` to `Track` objects
  // 4. If 2-3 are successful, return the array of movies
  // 5. Otherwise, return an empty array
  static func getTracks(forKey key: String) -> [Track] {
    let defaults = UserDefaults.standard
    if let data = defaults.data(forKey: key) {
      do {
        let decodedTracks = try JSONDecoder().decode([Track].self, from: data)
        return decodedTracks
      } catch {
        print("Error decoding tracks: \(error)")
        return []
      }
    } else {
      return []
    }
  }
  
  // Adds the movie to the favorites array in UserDefaults.
  // 1. Get all favorite tracks from UserDefaults
  //    - We make `favoriteTracks` a `var` so we'll be able to modify it when adding another movie
  // 2. Add the track to the favorite tracks array
  //   - Since this method is available on "instances" of a track, we can reference the movie this method is being called on using `self`.
  // 3. Save the updated favorite tracks array
  func addToFavorites() {
//    // 1.
//    print("BeginningofAddtoFavs")
//    var favoriteTracks = Track.getTracks(forKey: Track.favoritesKey)
//    // 2.
//    print("added " + (self.name ?? "NO NAME") + " to favs")
//    favoriteTracks.append(self)
//    // 3.
//    Track.save(favoriteTracks, forKey: Track.favoritesKey)
    DispatchQueue.main.async {
      var favoriteTracks = Track.getTracks(forKey: Track.favoritesKey)
      print("added \(self.name ?? "NO NAME") to favs")
      favoriteTracks.append(self)
      do {
        let encodedData = try JSONEncoder().encode(favoriteTracks)
        UserDefaults.standard.set(encodedData, forKey: Track.favoritesKey)
      } catch {
        print("Error encoding tracks: \(error)")
      }
    }
  }
  
  // Removes the movie from the favorites array in UserDefaults
  // 1. Get all favorite movies from UserDefaults
  // 2. remove all movies from the array that match the movie instance this method is being called on (i.e. `self`)
  //   - The `removeAll` method iterates through each movie in the array and passes the movie into a closure where it can be used to determine if it should be removed from the array.
  // 3. If a given movie passed into the closure is equal to `self` (i.e. the movie calling the method) we want to remove it. Returning a `Bool` of `true` removes the given movie.
  // 4. Save the updated favorite movies array.
  func removeFromFavorites() {
    // 1.
    var favoriteTracks = Track.getTracks(forKey: Track.favoritesKey)
    // 2.
    favoriteTracks.removeAll { track in
      // 3.
      return self == track
    }
    // 4.
    Track.save(favoriteTracks, forKey: Track.favoritesKey)
  }
}


