//
//  RegisterViewController.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/28/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: UITableViewController {
    
    @IBOutlet weak var fullnameTextField: AppTextField!
    @IBOutlet weak var usernameTextField: AppTextField!
    @IBOutlet weak var passwordTextField: AppTextField!
    @IBOutlet weak var submitPasswordTextField: AppTextField!
    @IBOutlet weak var emailTextField: AppTextField!
    @IBOutlet weak var registerButton: RoundedGradientButton!
    @IBOutlet weak var loginButton: RoundedGradientButton!
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var innerOrbitImageView: UIImageView!
    @IBOutlet weak var orbitImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.titleLabel?.font = Theme.Font.regular(size: 17)
        registerButton.titleLabel?.font = Theme.Font.regular(size: 17)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /// Animate the logo so it spins back and forth.
        logoImageView.startRotating(duration: 20, clockwise: true, delay: 1)
        
        /// Animate orbits to slowly rotate
        orbitImageView.startRotating(duration: 25, clockwise: false, delay: 1)
        innerOrbitImageView.startRotating(duration: 20, clockwise: true, delay: 1)
    }
    
    @IBAction func fullnameTextFieldTapped(_ sender: Any) {
        
    }
    @IBAction func usernameTextFieldTapped(_ sender: Any) {
        
    }
    @IBAction func passwordTextFieldTapped(_ sender: Any) {
        
    }
    @IBAction func submitPasswordTextFieldTapped(_ sender: Any) {
        
    }
    @IBAction func emailTextFieldTapped(_ sender: Any) {
        
    }
    
    @IBAction func registerButtonTapped(_ sender: Any) {
        
    }
    @IBAction func loginButtonTapped(_ sender: Any) {
        
    }
    // -------------------------------------
    // MARK: - Table View Functions
    // -------------------------------------
    
    /// Make the single static cell the same height of the phone
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var safeAreaHeight: CGFloat = 0
        
        if let window = UIApplication.shared.keyWindow {
            safeAreaHeight = window.safeAreaInsets.top + window.safeAreaInsets.bottom
        }
        
        return view.bounds.height - safeAreaHeight
    }
}
