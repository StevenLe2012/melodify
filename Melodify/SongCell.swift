//
//  SongCell.swift
//  Melodify
//
//  Created by Steven Le on 11/13/23.
//

import UIKit
import Nuke

class SongCell: UITableViewCell {
  // The track associated with the cell
  var track: Track!

  @IBOutlet weak var songCover: UIImageView!
  @IBOutlet weak var songTitle: UILabel!
  @IBOutlet weak var songAuthor: UILabel!
  
  @IBOutlet weak var likeButton: UIButton!
  
  @IBAction func didTapLikeButton(_ sender: UIButton) {
    // Set the button's isSelected state to the opposite of it's current value.
    sender.isSelected = !sender.isSelected
    
    // 1. If the button is in the *selected* state (i.e. "favorited") -> Add track to favorites
    // 2. Otherwise, the button is in the *un-selected* state (i.e."un-favorited") -> Remove track from favorites
    if sender.isSelected {
      // 1.
      track.addToFavorites()
    } else {
      // 2.
      track.removeFromFavorites()
    }

  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)

    // Configure the view for the selected state
    }
  
  
  // Initial configuration of the task cell
  // 1. Set the main task property
  // 2. Update the UI for the given task
  func configure(with track: Track) {
    // 1.
    self.track = track
    // 2.
    update(with: track);
  }
  
  // Update the UI for the given track
  private func update(with track: Track) {
    if let name = track.name {
      songTitle.text = name;
    }
    
    if let author = track.artists?.first?.name {
      songAuthor.text = author;
    }
    
    //   Unwrap the optional poster path
    if let songCoverPath = track.album?.images?.first?.url {

      if let imageUrl = URL(string: songCoverPath) {
        // Use the Nuke library's load image function to (async) fetch and load the image from the image URL.
        Nuke.loadImage(with: imageUrl, into: songCover)
      }
    }
    
    likeButton.layer.cornerRadius = likeButton.frame.width / 2
    
    // 1.
    let favorites = Track.getTracks(forKey: Track.favoritesKey)
    // 2.
    if favorites.contains(track) {
      // 3.
      likeButton.isSelected = true
    } else {
      // 4.
      likeButton.isSelected = false
    }
  }
}
