//
//  AlertController.swift
//  
//
//  Created by Sophie Amin on 2018-04-23.
//

import Foundation
import UIKit

class AlertController{
    static func showAlert(inViewController: UIViewController, title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(action)
        inViewController.present(alert, animated: true, completion: nil)
    }
}
