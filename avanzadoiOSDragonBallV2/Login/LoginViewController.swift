//
//  LoginViewController.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 4/4/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
    var mainView: LoginView {self.view as! LoginView}
    
    var loginButton : UIButton?
    var emailTextfield : UITextField?
    var passwordTextfield : UITextField?
    var loggedMessage: UILabel?
    
    var viewModel: LoginViewModel?
    
    let keychainManager = KeychainManager()
    
    override func loadView() {
        let loginView = LoginView()
        
        loginButton = loginView.getLoginButtonView()
        emailTextfield = loginView.getEmailView()
        passwordTextfield = loginView.getPasswordView()
        loggedMessage = loginView.getLoggedMessage()
        
        loginButton?.addTarget(self, action: #selector(didLoginTapped), for: .touchUpInside)
        
        view = loginView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = LoginViewModel()
        
        loginButton?.addTarget(self, action: #selector(didLoginTapped), for: .touchUpInside)
        
        //to show active message login
        viewModel?.updateLoggedTextViewIsHidden = {[weak self] in
            DispatchQueue.main.async {
                self?.mainView.loggedTextView.isHidden = self?.viewModel?.isLoggedLabelHidden ?? true
            }
        }

    }
    
   
    
    

    @objc
    func didLoginTapped(sender: UIButton) {
        
        // 1.- Capturar los valores de texto introducidos en para el email y la password
       
        
        guard let user = emailTextfield?.text else {
            print("Email field is required")
            return
        }
        guard let password = passwordTextfield?.text else {
            print("Password field is required")
            return
        }
        
        // 2.- Call view model to perform the login call with the apiClient
        
        viewModel?.updateUI = {[weak self] token, error in
            DispatchQueue.main.async {
                if !error.isEmpty {
                    DispatchQueue.main.async {
                            debugPrint("Se produjo un error al hacer login")                    }
                    self?.keychainManager.deleteData()
                }
                
                if !token.isEmpty {
                    // Guardar el token en el Keychain
                    self?.keychainManager.saveData(token)

                    self?.loggedMessage?.text = token
                    self?.dismiss(animated: true, completion: nil)
                    let homeTabBarController = HomeTabBarViewController()
                    self?.view.window?.rootViewController = homeTabBarController

                    return
                }
                if !error.isEmpty {
                    self?.loggedMessage?.text = error
                }
            }
        }

        
        viewModel?.login(user: user, password: password)
        
        
        
        // 3.- Mostrar el token o el error devuelvo
        //to show logged message true or false
        
        
    }
}
