//
//  MusicPlayerViewController.swift
//  Melodify
//
//  Created by Steven Le on 11/18/23.
//

import UIKit
import Nuke

class MusicPlayerViewController: UIViewController {
    
    var currentSong: Track? = nil;
    
    @IBOutlet weak var songName: UILabel!
    @IBOutlet weak var songAuthor: UILabel!
    @IBOutlet weak var songCover: UIImageView!
    
    @IBOutlet weak var rewindButton: UIButton!
    @IBOutlet weak var playStopButtom: UIButton!
    @IBOutlet weak var forwardButton: UIButton!
    
    @IBAction func rewindAction(_ sender: Any) {
        
    }
    
    @IBAction func playStopAction(_ sender: Any) {
        
    }
    
    @IBAction func forwardAction(_ sender: Any) {
        
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
