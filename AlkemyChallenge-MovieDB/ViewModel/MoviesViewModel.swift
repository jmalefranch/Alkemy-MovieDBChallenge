//
//  MoviesViewModel.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 20/05/2022.
//

import Foundation
class MoviesViewModel {
    
    private var apiService = APIClient()
    private var popularMovies = [Movie]()
    private var listGenre = [Genre]()
    var genres:[Genre] = []
    var cleanGenreId: [Int: String] = [:]
    
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    let alertName = "Caution"
    let messageWrongMail = "❗️Your e-mail format is wrong."
    let messageEmptyLabel = "🙏🏻Please, enter your e-mail address."
    let alertActionTitle = "Accept"
 
    
    func getStringGenre( gnre: [String] ) -> String {
        var textGenre = ""
        for g in gnre{
            textGenre += "| \(g) |"
        }
        return textGenre
    }
    
    func getCleanGenreAndId(){
        APIClient.getGenre(completionHandler: {genress in
            self.genres.append(contentsOf: genress)
        })
        for g in genres{
            cleanGenreId[g.id ?? 0] = g.name
        }
    }
    
    func getListOfNameGenre() -> [String] {
        getCleanGenreAndId()
        var names: [String] = []
        cleanGenreId.forEach { (key, value) in names.append(value) }
        return names
    }
    
    func getListOfGenres() -> [Int:String] {
        getCleanGenreAndId()
        return cleanGenreId
    }
    
    func getGenresForPicker(gen:[Int:String]) -> [String] {
        var g:[String] = []
        gen.forEach {(key, value) in g.append(value)}
        return g
    }
    
    func getIdGenresForPicker(gen:[Int:String]) -> [Int] {
        var id:[Int] = []
        gen.forEach{(key, value) in id.append(key)}
        return id
    }
    
}
