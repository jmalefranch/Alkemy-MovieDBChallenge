//
//  MainViewController.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 20/05/2022.
//

import UIKit

class MainViewController: UIViewController {
    
    
    //MARK: - Atributes
    private let viewModel = MoviesViewModel()
    var genres: [Int:String] = [:]
    var idSelected = 0
    var valueSelected = ""
    
    @IBOutlet weak var topMoviesButton: UIButton!
    @IBOutlet weak var genderMoviesButton: UIButton!
    @IBOutlet weak var gendreMoviesPicker: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
        gendreMoviesPicker.dataSource = self
        gendreMoviesPicker.delegate = self
    }

    @IBAction func topMoviesAction(_ sender: Any) {
        let vc = TopListViewController(nibName: "TopListViewController", bundle: nil)
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func gendreMoviesAction(_ sender: Any) {
        let vc = GenreListViewController(nibName: "GenreListViewController", bundle: nil)
        vc.gen = valueSelected
        vc.idGen = idSelected
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var gendreMoviesPickerAction: UIPickerView!

}
//MARK: - Picker view of movie genders

extension MainViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return genres.count
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let g:[String] = viewModel.getGenresForPicker(gen: genres)
        let id:[Int] = viewModel.getIdGenresForPicker(gen: genres)
        valueSelected = g[row] as String
        idSelected = id[row] as Int
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        var g:[String] = []
        g = viewModel.getGenresForPicker(gen: genres)
        return g[row]
    }
    
}
