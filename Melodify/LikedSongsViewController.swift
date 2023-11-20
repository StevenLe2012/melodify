//
//  LikedSongsViewController.swift
//  Melodify
//
//  Created by Steven Le on 11/18/23.
//

import UIKit

class LikedSongsViewController: UIViewController, UITableViewDataSource {

    var likedSongs: [Track] = [];
    
    @IBOutlet weak var tableView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the index path for the selected row.
        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        // Get the selected songs post from the posts array using the selected index path's row
        let selectedSong = likedSongs[selectedIndexPath.row]
        
        // Get access to the detail view controller via the segue's destination. (guard to unwrap the optional)
        //        if let forYouViewController = segue.destination as? ViewController {
        //
        //        }
        
        //        forYouViewController.likedSongs = likedSongs;
        
        // PREPARE MUSIC PLAYER VIEW CONTROLLER
        if let musicPlayerViewController = segue.destination as? MusicPlayerViewController {
            musicPlayerViewController.currentSong = selectedSong
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        likedSongs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("🍏 cellForRowAt called for row: \(indexPath.row)")
        
        // Get a reusable cell
        // Returns a reusable table-view cell object for the specified reuse identifier and adds it to the table. This helps optimize table view performance as the app only needs to create enough cells to fill the screen and reuse cells that scroll off the screen instead of creating new ones.
        // The identifier references the identifier you set for the cell previously in the storyboard.
        // The `dequeueReusableCell` method returns a regular `UITableViewCell`, so we must cast it as our custom cell (i.e., `as! MovieCell`) to access the custom properties you added to the cell.
        let cell = tableView.dequeueReusableCell(withIdentifier: "SongCell", for: indexPath) as! SongCell
        
        // Get the movie associated table view row
        let track = likedSongs[indexPath.row]
        
        cell.configure(with: track);
        
        // Configure the cell (i.e., update UI elements like labels, image views, etc.)
        
        // Unwrap the optional poster path
        //    if let songCoverPath = track?.album {
        //
        //      // Create a url by appending the poster path to the base url.
        ////      let imageUrl = songCoverPath.originalSize.url
        //      if let imageUrl = URL(string: songCoverPath) {
        //        // Use the Nuke library's load image function to (async) fetch and load the image from the image URL.
        //        Nuke.loadImage(with: imageUrl, into: cell.songCover)
        //      }
        //    }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
