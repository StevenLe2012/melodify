//
//  ViewController.swift
//  Melodify
//
//  Created by Steven Le on 11/13/23.
//

import UIKit
import Nuke

class ViewController: UIViewController, UITableViewDataSource {
  
  var songs: [Song] = []

  @IBOutlet weak var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view.
//    view.backgroundColor = .systemPink
    tableView.dataSource = self
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
    let song = songs[indexPath.row]
    
    cell.songTitle.text = song.title
    cell.songAuthor.text = song.author
    
    // Configure the cell (i.e., update UI elements like labels, image views, etc.)
    
    // Unwrap the optional poster path
    if let songCoverPath = song.photos.first {
       
        // Create a url by appending the poster path to the base url. https://developers.themoviedb.org/3/getting-started/images
      let imageUrl = songCoverPath.originalSize.url
      // Use the Nuke library's load image function to (async) fetch and load the image from the image URL.
        Nuke.loadImage(with: imageUrl, into: cell.songCover)
    }
  }
}

