//
//  TopListViewController.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 20/05/2022.
//

import UIKit

class TopListViewController: UIViewController {
   
    
    
    //MARK: - Atributes
    var results:[Movie] = []
    var genres:[Genre] = []
    var cargado = false
    var page = 1

    @IBOutlet weak var topMoviesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        let nib = UINib(nibName: "TopMoviesTableViewCell", bundle: .main)
        topMoviesTable.register(nib, forCellReuseIdentifier: "TopMoviesTableViewCell")
        topMoviesTable.dataSource = self
        topMoviesTable.delegate = self
        
        loadMovies(page:page)
        loadGenre()
    }

    private func loadMovies(page: Int) {
      cargado = true
        APIClient.getMovies(page: page, completionHandler: { movies in
            self.results.append(contentsOf: movies)
            self.topMoviesTable.reloadData()
            self.cargado = false
        })
        
    }
    
    private func loadGenre(){
        APIClient.getGenre(completionHandler: { genress in
            self.genres.append(contentsOf: genress)
            self.topMoviesTable.reloadData()
        })
    }

}

//MARK: - UITableViewDataSource
extension TopListViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = topMoviesTable.dequeueReusableCell(withIdentifier: "TopMoviesTableViewCell")as! TopMoviesTableViewCell
        let movie = results[indexPath.row]
        let generos = obtenerGeneros(generos: movie.genre_ids ?? [])
        cell.configure(for: movie, gnre: generos)
        return cell
       }
    }

//MARK: - UITableViewDelegate
extension TopListViewController:UITableViewDelegate{
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
        tableView.deselectRow(at:indexPath, animated: true)
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
