//
//  ViewController.swift
//  Melodify
//
//  Created by Steven Le on 11/13/23.
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
  
  var songs: [Track] = []
  
  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
    //    view.backgroundColor = .systemPink
    tableView.dataSource = self
    
    // Tableview Refresh
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
    
    fetchSongs();
  }

  
  override func viewWillAppear(_ animated: Bool) {
    // Customary to call the overridden method on `super` any time you override a method.
    super.viewWillAppear(animated)
    
    // get the index path for the selected row
    if let selectedIndexPath = tableView.indexPathForSelectedRow {
      tableView.deselectRow(at: selectedIndexPath, animated: animated)
    }
    
    tableView.reloadData()
  }
  
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the index path for the selected row.
    // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
    guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
    
    // Get the selected songs post from the posts array using the selected index path's row
    let selectedSong = songs[selectedIndexPath.row]
    
    // PREPARE MUSIC PLAYER VIEW CONTROLLER
    if let musicPlayerViewController = segue.destination as? MusicPlayerViewController {
      musicPlayerViewController.currentSong = selectedSong
    }
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    songs.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    print("🍏 cellForRowAt called for row: \(indexPath.row)")
    
    // Get a reusable cell
    // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table. This helps optimize table view performance as the app only needs to create enough cells to fill the screen and reuse cells that scroll off the screen instead of creating new ones.
    // The identifier references the identifier you set for the cell previously in the storyboard.
    // The `dequeueReusableCell` method returns a regular `UITableViewCell`, so we must cast it as our custom cell (i.e., `as! MovieCell`) to access the custom properties you added to the cell.
    let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
    
    // Get the movie associated table view row
    let track = songs[indexPath.row]
    cell.track = track;
    
    cell.configure(with: track);
    
    return cell
  }
  
  @objc func refreshData(_ sender: UIRefreshControl) {
    // Fetch new data here (e.g., make a network request or reload data from another source)
    
    // After fetching new data, reload the table view
    fetchSongs();
    tableView.reloadData()
    
    // Stop the refresh animation
    sender.endRefreshing()
  }
  
  func fetchSongs() {
    // Authentication
    SpotifyAuthenticator.shared.getAccessToken { [weak self] token in
      guard let token = token else {
        print("❌ Failed to get access token")
        return
      }
      
      let headers = ["Authorization": "Bearer \(token)"]
      let url = URL(string: "https://api.spotify.com/v1/recommendations?seed_genres=anime,j-pop,k-pop")! // CAN CHANGE TO ANY ENDPOINT
      
      var request = URLRequest(url: url)
      request.httpMethod = "GET"
      request.allHTTPHeaderFields = headers
      
      // Usual Requests
      let session = URLSession.shared.dataTask(with: request) { data, response, error in
        if let error = error {
          print("❌ Error: \(error.localizedDescription)")
          return
        }
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode, (200...299).contains(statusCode) else {
          print("❌ Response error: \(String(describing: response))")
          return
        }
        
        guard let data = data else {
          print("❌ Data is NIL")
          return
        }
        
        do {
          let recommendation = try JSONDecoder().decode(RecommendationsResponse.self, from: data)
          
          DispatchQueue.main.async { [weak self] in
            self?.songs = recommendation.tracks!
            self?.tableView.reloadData()
            
            print("✅ We got \(self?.songs.count ?? 0) songs!")
            for track in recommendation.tracks! {
              print("🎤 Title: \(track.name)")
              print("🍏 Author: \(track.artists?.first?.name ?? "Unknown")")
            }
          }
          
        } catch {
          print("❌ Error decoding JSON: \(error.localizedDescription)")
        }
      }
      session.resume()
    }
  }
}
