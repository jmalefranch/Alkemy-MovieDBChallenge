//
//  MovieTableViewCell.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 20/05/2022.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieNameLabel: UILabel!
    @IBOutlet weak var movieRateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
//MARK: - Configure cell
    func configure (for movie: Movie, gnre: [String]) {
        movieNameLabel.text = movie.original_title
        movieRateLabel.text = "Rate: \(movie.vote_average ?? 0)/10 ⭐️"
    }
    
    
}
