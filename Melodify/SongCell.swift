//
//  SongCell.swift
//  Melodify
//
//  Created by Steven Le on 11/13/23.
//

import UIKit

class SongCell: UITableViewCell {

  @IBOutlet weak var songCover: UIImageView!
  @IBOutlet weak var songTitle: UILabel!
  @IBOutlet weak var songAuthor: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
