//
//  BooksTableViewCell.swift
//  iOSTakeHomeChallenge
//
//  Created by Muneer KK on 05/10/21.
//

import UIKit

class BooksTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var pagesLabel: UILabel!
    
    func setupWith(book: Book) {
        titleLabel.text = book.name
        dateLabel.text = book.released.toYearMonth()
        pagesLabel.text = String(book.numberOfPages).appending(" pages")
    }
}
