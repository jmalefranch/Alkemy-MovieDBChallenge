//
//  GenreListViewController.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 20/05/2022.
//

import UIKit

class GenreListViewController: UIViewController {

    //MARK: - Atributes
    let viewModel = MoviesViewModel()
    var gen: String = ""
    var idGen: Int = 0
    var results:[Movie] = []
    var genres:[Genre] = []
    var cargado = false
    var page = 1
    
    @IBOutlet weak var genreTableView: UITableView!
    @IBOutlet weak var genreLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        genreLabel.text = "\(gen) Movies"
        let nib = UINib(nibName: "MovieTableViewCell", bundle: .main)
        genreTableView.register(nib,  forCellReuseIdentifier:"MovieTableViewCell")
        
        genreTableView.dataSource = self
        genreTableView.delegate = self
        
        loadMovies(page: page)
        loadGenre()
    }
    
    func emptyList(){
        let alert = UIAlertController(title: viewModel.alertName, message: viewModel.emptyMoviesList, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:viewModel.alertName, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func loadGenre(){
        APIClient.getGenre (completionHandler:{ genress in
            self.genres.append(contentsOf: genress)
            self.genreTableView.reloadData()
        })
    }
    
    private func loadMovies(page: Int){
            cargado = true
            APIClient.getMovies(page:page, completionHandler:{ movies in
                self.results.append(contentsOf: movies)
                self.results = self.results.filter{($0.genre_ids?.contains(self.idGen) ?? false)}
                 if (self.results.count == 0) {
                 self.emptyList()
                 }
                self.genreTableView.reloadData()
                self.cargado = false
            })
    }
}

//MARK: - UITableViewDataSource
    extension GenreListViewController: UITableViewDataSource {
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return results.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MovieTableViewCell")as! MovieTableViewCell
            let movie = results[indexPath.row]
            let generos = obtenerGeneros(generos: movie.genre_ids ?? [])
            cell.configure(for: movie, gnre: generos)
            return cell
           }
}

//MARK: - UITableViewDelegate
extension GenreListViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath:IndexPath){
        if indexPath.row == results.count - 5{
            guard !cargado else {
                return
            }
            page+=1
            loadMovies(page: page)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        genreTableView.deselectRow(at:indexPath, animated: true)
        let selectedeMovie = results[indexPath.row]
        let vc = MovieViewController(nibName: "MovieViewController", bundle: nil)
        vc.movie = selectedeMovie
        self.present(vc, animated: true,completion: nil)
    }
    
    func obtenerGeneros(generos:[Int]) -> [String]{
        var test:[String]=[]
        for tipoGeneros in genres {
            for generMovies in generos{
                if (tipoGeneros.id! == generMovies){
                    let nom = tipoGeneros.name!
                    test.append(nom)
                }
            }
        }
        return test
    }
}



