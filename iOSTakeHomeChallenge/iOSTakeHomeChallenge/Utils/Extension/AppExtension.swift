//
//  AppExtension.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//

import UIKit

extension UITableView {
    func applyStyles() {
        self.contentInset = UIEdgeInsets(top: 220, left: 0, bottom: 0, right: 0)
        backgroundView = UIImageView(image: UIImage(named: "imgBooks"))
        allowsSelection = false
    }
    
    func addBackground(imageName: String) {
       backgroundView =  UIImageView(image: UIImage(named: imageName))
    }
}

extension String {
    func toYearMonth() -> String {
        var monthYear = ""
        let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        if let date = dateFormatter.date(from: self) {
            dateFormatter.dateFormat = "MMM yyyy"
            monthYear = dateFormatter.string(from: date)
            return monthYear
        }
        return monthYear
    }
}
