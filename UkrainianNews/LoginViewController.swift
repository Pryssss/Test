//
//  LoginViewController.swift
//  UkrainianNews
//
//  Created by Markiyan Prysiazhniuk on 5/28/19.
//  Copyright © 2019 Markiyan Prysiazhniuk. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class LoginViewController: UITableViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var loginButton: RoundedGradientButton!
    @IBOutlet weak var registerButton: RoundedGradientButton!
    @IBOutlet weak var innerOrbitImageView: UIImageView!
    @IBOutlet weak var orbitImageView: UIImageView!
    @IBOutlet weak var passwordTextField: AppTextField!
    @IBOutlet weak var usernameTextField: AppTextField!
    
    
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
    
    @IBAction func login(_ sender: Any) {
        
        /// Hide the keyboard
        view.endEditing(true)
        
        /// Increase the spin until logging is done and navigates away.
        logoImageView.stopRotating()
        logoImageView.startRotating(duration: 1, clockwise: true)
        
        if let email = usernameTextField.text, let password = passwordTextField.text {
            Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
                if error != nil {
                    print(error?.localizedDescription as Any)
                }
                
                let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let registerViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! ViewController
                self.present(registerViewController, animated: true, completion: nil)
                
            }
            
//            if Auth.auth().currentUser?.uid == nil {
//                handleLogout()
//            }
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Main") as! ViewController
        self.present(nextViewController, animated:true, completion:nil)
    }
    @IBAction func register(_ sender: Any) {
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let registerViewController = storyBoard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        self.present(registerViewController, animated: true, completion: nil)
        
    }
    @IBAction func forgotPassword(_ sender: Any) {
        
    }
    
    @IBAction func usernameNextKeyboardButtonTapped(_ sender: Any) {
        passwordTextField.becomeFirstResponder()
        
        /// This line prevents the view from scrolling under the keyboard.
        
            }
    
    // -------------------------------------
    // MARK: - private logOut Func
    // -------------------------------------
    
    private func handleLogout() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error)
        }
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "Register") as! RegisterViewController
        self.present(nextViewController, animated:true, completion:nil)
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
