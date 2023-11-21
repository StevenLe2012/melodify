//
//  MusicPlayerViewController.swift
//  Melodify
//
//  Created by Steven Le on 11/18/23.
//

import UIKit
import Nuke

class MusicPlayerViewController: UIViewController {
    
    var currentSong : Track!
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songAuthor: UILabel!
    @IBOutlet weak var songCover: UIImageView!
    
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var playStopButtom: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBOutlet weak var likedButton: UIButton!
    
    @IBAction func rewindAction(_ sender: Any) {
        
    }
    
    @IBAction func playStopAction(_ sender: Any) {
        isPlaying.toggle()
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        
    }

    @IBAction func likedButtonAction(_ sender: UIButton) {
        // Set the button's isSelected state to the opposite of it's current value.
        sender.isSelected = !sender.isSelected
        
        // 1. If the button is in the *selected* state (i.e. "favorited") -> Add track to favorites
        // 2. Otherwise, the button is in the *un-selected* state (i.e."un-favorited") -> Remove track from favorites
        if sender.isSelected {
            // 1.
            currentSong.addToFavorites()
        } else {
            // 2.
            currentSong.removeFromFavorites()
        }
    }
    
    var isPlaying: Bool = true {
        didSet {
            let imageName = isPlaying ? "pause.circle.fill" : "play.circle.fill"
            print(imageName)
            let image = UIImage(systemName: imageName)
            playStopButtom.setImage(image, for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure() {
        songName.text = currentSong?.name;
        songAuthor.text = currentSong?.artists?.first?.name;
        
        //   Unwrap the optional poster path
        if let songCoverPath = currentSong.album?.images?.first?.url {
            
            if let imageUrl = URL(string: songCoverPath) {
                // Use the Nuke library's load image function to (async) fetch and load the image from the image URL.
                Nuke.loadImage(with: imageUrl, into: songCover)
            }
        }
        
        likedButton.layer.cornerRadius = likedButton.frame.width / 2
        // 1.
        let favorites = Track.getTracks(forKey: Track.favoritesKey)
        // 2.
        if favorites.contains(currentSong) {
            // 3.
            likedButton.isSelected = true
        } else {
            // 4.
            likedButton.isSelected = false
        }
    }
}
