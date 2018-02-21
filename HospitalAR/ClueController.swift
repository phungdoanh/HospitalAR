//
//  ClueController.swift
//  HospitalAR
//
//  Created by Peter Andringa on 2/20/18.
//  Copyright © 2018 Peter Andringa. All rights reserved.
//

import Foundation
import RealmSwift

class ClueController: UIViewController {
    
    @IBOutlet weak var clueTitle: UILabel!
    @IBOutlet weak var clueText: UILabel!
    
    let clueRealm = try! Realm()
    var currentClue: Clue?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Pick out the current clue
        self.currentClue = clueRealm.objects(Clue.self).first
        
        // Update Label Values
        clueTitle.text = currentClue?.clueTitle
        clueText.text = currentClue?.clueText
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ToCameraController" {
            if let destination = segue.destination as? CameraController {
                destination.currentClue = self.currentClue
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
