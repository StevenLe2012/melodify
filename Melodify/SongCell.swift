//
//  SongCell.swift
//  Melodify
//
//  Created by Steven Le on 11/13/23.
//

import UIKit

class SongCell: UITableViewCell {
  
  // The closure called, passing in the associated track, when the "like" button is tapped.
  var onFavoriteButtonTapped: ((Track) -> Void)?
  
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
    // Set the button's corner radius to be 1/2  it's width. This will make a square button round
//    likeButton.layer.cornerRadius = likeButton.frame.width / 2
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
//  // Initial configuration of the task cell
//  // 1. Set the main task property
//  // 2. Set the onCompleteButtonTapped closure
//  // 3. Update the UI for the given task
//  func configure(with track: Track, onFavoriteButtonTapped: ((Track) -> Void)?) {
//    // 1.
//    self.track = track
//    // 2.
//    self.onFavoriteButtonTapped = onFavoriteButtonTapped
//    // 3.
//    update(with: track);
//  }
  
  // Update the UI for the given track
  private func update(with track: Track) {
    songTitle.text = track.name
    songAuthor.text = track.artists?.first?.name;
    
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
  
  
  
//  // This overrides the table view cell's default selected and highlighted behavior to do nothing, otherwise, the row would darken when tapped
//  // This is just a design / UI polish for this particular use case. Since we also have the "Completed" button in the row, it looks kinda weird if the whole cell darkens during selection.
//  override func setSelected(_ selected: Bool, animated: Bool) { }
//  override func setHighlighted(_ highlighted: Bool, animated: Bool) { }
}
