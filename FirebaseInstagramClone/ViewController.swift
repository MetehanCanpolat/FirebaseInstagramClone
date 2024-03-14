//
//  ViewController.swift
//  FirebaseInstagramClone
//
//  Created by Metehan Canpolat on 5.03.2024.
//

import UIKit
import Firebase

//firebase bağlantısı yapıldı

class ViewController: UIViewController {
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        
        //klavye dışına dokununca klavye kapatma
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
    }
    

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    


    @IBAction func signInButton(_ sender: Any) {
        
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { (authdata,error) in
            if error != nil {
                self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
            } else{
                self.performSegue(withIdentifier: "toFeedVC", sender: nil)
            }
        }
        
    }
    
    @IBAction func signUpButton(_ sender: Any) {
        
        //kullanıcı oluşturma işlemi
        //Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!)
        
        if emailText.text != "" && passwordText.text != "" {
            
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdata,error) in
                
                if error != nil {
                    
                    self.makeAlert(titleInput: "ERROR", messageInput: error?.localizedDescription ?? "error")
                    
                }else {
                    self.performSegue(withIdentifier: "toFeedVC", sender: nil)
                }
            }
        } else {
         makeAlert(titleInput: "Error!", messageInput: "You have to enter an email and password!")
        }
    }
    
    func makeAlert(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }

}

