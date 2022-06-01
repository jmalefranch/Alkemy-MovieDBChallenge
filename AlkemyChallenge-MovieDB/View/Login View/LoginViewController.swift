//
//  LoginViewController.swift
//  AlkemyChallenge-MovieDB
//
//  Created by Jose on 20/05/2022.
//

import UIKit

class LoginViewController: UIViewController {

    //MARK: - Atributes
    private let viewModel = MoviesViewModel()
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var startButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getListOfGenres()
        // Do any additional setup after loading the view.
    }
   
    @IBAction func startButtonAction(_ sender: Any) {
        if let mail = emailTextField.text,!mail.isEmpty{
            if validEmail(mail){
                startApp(ar: viewModel.getListOfGenres())}
            else{
                mailInvalido()}}
        else{
            mailVacio()}
    }
    
    
    
    //MARK: - Buttons Functions
    
    func validEmail(_ mail: String) -> Bool {
        let emailPred = NSPredicate(format:"SELF MATCHES %@", viewModel.emailRegEx)
        return emailPred.evaluate(with: mail)
    }
    
    func startApp(ar:[Int:String]){
        let vc = MainViewController(nibName: "MainViewController", bundle: nil)
        vc.genres = ar
        self.present(vc, animated: true, completion: nil)
    }
    
    func mailInvalido(){
        let alert = UIAlertController(title: viewModel.alertName, message: viewModel.messageWrongMail, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title:viewModel.alertActionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func mailVacio(){
        let alert = UIAlertController(title: viewModel.alertName, message: viewModel.messageEmptyLabel, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: viewModel.alertActionTitle, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
