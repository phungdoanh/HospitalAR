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
    
//    @IBOutlet weak var name: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func submitName(_ sender: UIButton) {
//        let hCVC = storyboard?.instantiateViewController(withIdentifier: "HeroCustomizeController") as! HeroCustomizeController
////        hCVC.hero.name = name.text!
//        navigationController?.pushViewController(hCVC, animated: true)
    }
}
