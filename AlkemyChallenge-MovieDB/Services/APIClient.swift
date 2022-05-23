//
//  APIClient.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 18/05/2022.
//

import Foundation
import Alamofire

let apiKey = "f7e3be7dbf845f10f2fc8d20407a5919"
let baseURLTopMovies = "https://api.themoviedb.org/3/movie/"

final class APIClient {
    
    static func getPopulars(page: Int, completionHandler: @escaping ([Movie]) -> Void) {
        let request =
            AF.request("\(baseURLTopMovies)popular?api_key=\(apiKey)&language=en-US&page=\(page)")
        request.responseData {response in
            switch response.result {
        case .success(let data):
                do {
                    let page = try! JSONDecoder().decode(MoviePage.self, from: data)
                    completionHandler(page.results)
                } catch let error {
                    print("Unable to load data: \(error)")
                }
                
        case .failure(let error):
            print("Error: \(error)")
        }
}

}
}
