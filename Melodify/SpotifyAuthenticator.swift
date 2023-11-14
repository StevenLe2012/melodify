//
//  SpotifyAuthenticator.swift
//  Melodify
//
//  Created by Steven Le on 11/14/23.
//

import Foundation
import Alamofire

class SpotifyAuthenticator {
  static let shared = SpotifyAuthenticator()
  
  private let clientId = "bc68db21f63e4932872f3a87e6ba2875"
  private let clientSecret = "76a67384312a42b9b20fb532e217cd56"
  private var accessToken: String?
  
  private init() {}
  
  func getAccessToken(completion: @escaping (String?) -> Void) {
    if let token = accessToken {
      completion(token)
      return
    }
    
    let credentials = "\(clientId):\(clientSecret)"
    guard let data = credentials.data(using: .utf8) else {
      completion(nil)
      return
    }
    
    let headers: HTTPHeaders = ["Authorization": "Basic \(data.base64EncodedString())"]
    
    // TODO: MIGHT NEED TO CAHNGE URL
    AF.request("https://accounts.spotify.com/api/token", method: .post, parameters: ["grant_type": "client_credentials"], headers: headers).responseJSON { response in
      switch response.result {
      case .success(let value):
        if let json = value as? [String: Any], let token = json["access_token"] as? String {
          self.accessToken = token
          completion(token)
        } else {
          completion(nil)
        }
      case .failure:
        completion(nil)
      }
    }
  }
}
