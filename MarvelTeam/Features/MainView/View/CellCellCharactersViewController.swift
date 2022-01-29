//
//  CellCellCharactersViewController.swift
//  MarvelTeam
//
//  Created by Eduardo Jordan on 29/1/22.
//

import Foundation
import UIKit

class CellCellCharactersViewController: UITableViewCell {
 
    @IBOutlet weak var imgChracters: UIImageView!
    @IBOutlet weak var nameCharacters: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()

        self.nameCharacters.textColor = UIColor.white
        self.nameCharacters.font = UIFont(name: "BebasNeue-Regular", size: 22)
    }

}
