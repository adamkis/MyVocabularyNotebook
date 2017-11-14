//
//  TranslationTableViewCell.swift
//  MyVocabularyNotebook
//
//  Created by Adam on 2017. 08. 30..
//  Copyright © 2017. Adam. All rights reserved.
//

import UIKit

class TranslationTableViewCell: UITableViewCell {

    // MARK: Properties
    @IBOutlet weak var translationLabel1: UILabel!
    @IBOutlet weak var translationLabel2: UILabel!
    @IBOutlet weak var translation1Background: UIView!
    @IBOutlet weak var translation2Background: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
