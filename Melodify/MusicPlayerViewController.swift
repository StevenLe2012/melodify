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
        print("PressedButton")
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
            print("currentSong: " + (currentSong.name ?? "EMPTY"))
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
            let image = UIImage(systemName: imageName)?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal)
            playStopButtom.setImage(image, for: .normal)
            print("DidSet")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configure()
    }
    
    func configure() {
//        if let photo = post.photos.first {
//            let url = photo.originalSize.url
//            Nuke.loadImage(with: url, into: posterImageView)
//        }
        songName.text = currentSong?.name;
        songAuthor.text = currentSong?.artists?.first?.name;
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
