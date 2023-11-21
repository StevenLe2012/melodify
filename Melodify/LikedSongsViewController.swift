//
//  LikedSongsViewController.swift
//  Melodify
//
//  Created by Steven Le on 11/18/23.
//

import UIKit
import Nuke

class LikedSongsViewController: UIViewController, UITableViewDataSource {

    var likedSongs: [Track] = [];
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.dataSource = self
        
        // Tableview Refresh
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Customary to call the overridden method on `super` any time you override a method.
        super.viewWillAppear(animated)
        
        // get the index path for the selected row
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
        
        // Get favorite songs and display in table view
        // 1. Get the array of favorite songs
        // 2. Set the favoriteSongs property so the table view data source methods will have access to latest favorite songs.
        // 3. Reload the table view
        // ------
        //1.
        let songs = Track.getTracks(forKey: Track.favoritesKey)
        // 2.
        self.likedSongs = songs
        // 3.
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the index path for the selected row.
        // `indexPathForSelectedRow` returns an optional `indexPath`, so we'll unwrap it with a guard.
        guard let selectedIndexPath = tableView.indexPathForSelectedRow else { return }
        
        // Get the selected songs post from the posts array using the selected index path's row
        let selectedSong = likedSongs[selectedIndexPath.row]
        
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
        cell.track = track;
        cell.configure(with: track);
        
        return cell
    }
    
    @objc func refreshData(_ sender: UIRefreshControl) {
        // Fetch new data here (e.g., make a network request or reload data from another source)
        
        // After fetching new data, reload the table view
        let songs = Track.getTracks(forKey: Track.favoritesKey)
        self.likedSongs = songs
        tableView.reloadData()
        
        // Stop the refresh animation
        sender.endRefreshing()
    }
}
