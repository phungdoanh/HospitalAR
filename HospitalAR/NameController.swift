//
//  NameController.swift
//  HospitalAR
//
//  Created by Andrea Gonzales on 2/26/18.
//  Copyright © 2018 Andrea Gonzales. All rights reserved.
//

import Foundation
import RealmSwift

class NameController : UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? HeroCustomizeController {
            destination.hero.name = nameField.text!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
