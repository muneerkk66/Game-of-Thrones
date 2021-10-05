//
//  CharacterTableViewCell.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//

import UIKit

class CharacterTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cultureLabel: UILabel!
    @IBOutlet weak var bornLabel: UILabel!
    @IBOutlet weak var diedLabel: UILabel!
    @IBOutlet weak var seasonLabel: UILabel!
    
    func setupWith(character: Character) {
        nameLabel.text = character.name == "" ? AppEnum.Text.unavailable.rawValue : character.name
        cultureLabel.text = character.culture == "" ? AppEnum.Text.unavailable.rawValue : character.culture
        bornLabel.text = character.born == "" ? AppEnum.Text.unavailable.rawValue : character.born
        diedLabel.text = character.died == "" ? AppEnum.Text.unavailable.rawValue : character.died
        
        var seasons: String = ""
        for season in character.tvSeries {
            
            switch season {
            case "Season 1":
                seasons.append("I ")
            case "Season 2":
                seasons.append("II, ")
            case "Season 3":
                seasons.append("III, ")
            case "Season 4":
                seasons.append("IV, ")
            case "Season 5":
                seasons.append("V, ")
            case "Season 6":
                seasons.append("VI, ")
            case "Season 7":
                seasons.append("VII, ")
            default:
                seasons.append("VIII")
            }
        }
        seasonLabel.text = seasons == "" ? AppEnum.Text.unavailable.rawValue : seasons
    }
}
