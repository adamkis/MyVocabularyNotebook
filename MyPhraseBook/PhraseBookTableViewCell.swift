//
//  MyDictionaryTableViewCell.swift
//  MyPhraseBook
//
//  Created by Adam on 2017. 09. 17..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class PhraseBookTableViewCell: UITableViewCell {
    
    @IBOutlet weak var myDictionaryName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
