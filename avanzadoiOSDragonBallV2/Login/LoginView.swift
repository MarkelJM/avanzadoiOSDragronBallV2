//
//  LoginView.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 4/4/23.
//

import Foundation
import UIKit

class LoginView : UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpLoginView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let usernameView = {
        let label = UITextField()
        label.placeholder = "Enter your name"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let passwordView = {
        let label = UITextField()
        label.placeholder = "Enter your password"
        label.isSecureTextEntry = true
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15)
        label.textColor = .black
        label.backgroundColor = .white
        label.layer.cornerRadius = 5
        label.layer.masksToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    let loginButtonView = {
            let button = UIButton()
            button.setTitle("Login", for: .normal)
            button.setTitleColor(.white, for: .normal)
            button.backgroundColor = .blue
            button.layer.cornerRadius = 5
        
            
        
            button.translatesAutoresizingMaskIntoConstraints = false
        
            return button
        }()
    
    let loggedTextView = {
        let label = UILabel()
        label.text = "Text"
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 5
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = UIColor.clear
        label.textColor = .black
        label.isHidden = true
        label.translatesAutoresizingMaskIntoConstraints = false /* muy importante siempre a false!!!*/
        return label
    }()
    func setUpLoginView() {
        backgroundColor = .lightGray
        
        addSubview(usernameView)
        addSubview(passwordView)
        addSubview(loginButtonView)
        addSubview(loggedTextView)
        
        NSLayoutConstraint.activate([
            usernameView.topAnchor.constraint(equalTo: topAnchor,constant: 200),
            usernameView.leadingAnchor.constraint(equalTo: leadingAnchor,constant: 50),
            usernameView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            usernameView.heightAnchor.constraint(equalToConstant: 30),
            
            passwordView.topAnchor.constraint(equalTo: usernameView.topAnchor, constant: 50),
            passwordView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            passwordView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -50),
            passwordView.heightAnchor.constraint(equalToConstant: 30),
            
            loginButtonView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -200),
            loginButtonView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 90),
            loginButtonView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -90),
            loginButtonView.heightAnchor.constraint(equalToConstant: 30),
            
            loggedTextView.topAnchor.constraint(equalTo: passwordView.topAnchor, constant: 60),
            loggedTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 35),
            loggedTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35),
            
        ])
        
        
    }
   
    
    func getLoginButtonView() -> UIButton {
        return loginButtonView
    }
    
    func getEmailView()-> UITextField {
        return usernameView
    }
    
    func getPasswordView()-> UITextField {
        return passwordView
    }
    
    func getLoggedMessage()-> UILabel {
        return loggedTextView
    }
     
}
