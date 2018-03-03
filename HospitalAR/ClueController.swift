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
    
    var currentClue: Clue?
    var completedClues = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.getGlobalRealm { clueRealm in
            self.currentClue = clueRealm.objects(Clue.self).filter(NSPredicate(format: "NOT (id IN %@)", self.completedClues)).first
            // Update labels
            self.clueTitle.text = self.currentClue?.clueTitle
            self.clueText.text = self.currentClue?.clueText
        }
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
