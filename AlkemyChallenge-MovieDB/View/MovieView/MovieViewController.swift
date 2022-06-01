//
//  MovieViewController.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 20/05/2022.
//

import UIKit
import Kingfisher

class MovieViewController: UIViewController {

    //MARK: - Atributes
    var movie: Movie?
    private let viewModel = MoviesViewModel()
    let strURL: String = "https://image.tmdb.org/t/p/w500"
    
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRate: UILabel!
    @IBOutlet weak var movieOverview: UITextView!
    @IBOutlet weak var movieDate: UILabel!
    @IBOutlet weak var movieLanguage: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        movieImage.image = nil
        movieImage.kf.cancelDownloadTask()
        guard let mov = movie else {return}
        self.moviesDetailView(movie: mov)
    }
    
    private func moviesDetailView(movie: Movie) {
        let path:String = movie.poster_path ?? ""
        if let imgURL = URL(string: strURL+path) {
            movieImage.kf.setImage(with: imgURL)
        }
        movieTitle.text = movie.original_title
        movieLanguage.text = "Original Language: \(movie.original_language ?? "")"
        movieRate.text = "Rate: \(movie.vote_average ?? 0)/10 ⭐️"
        movieOverview.text = movie.overview
        movieDate.text = "Release date: \(movie.release_date ?? " ")"
    }


   
}
