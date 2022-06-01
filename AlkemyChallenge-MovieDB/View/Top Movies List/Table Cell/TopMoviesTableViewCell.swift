//
//  TopMoviesTableViewCell.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 20/05/2022.
//

import UIKit

class TopMoviesTableViewCell: UITableViewCell {

    private let viewModel = MoviesViewModel()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func configure (for movie:Movie, gnre:[String]){
        nameLabel.text = movie.original_title
        let g = viewModel.getStringGenre(gnre: gnre)
        languageLabel.text = g
    }
    
}
