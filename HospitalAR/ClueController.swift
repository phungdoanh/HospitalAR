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
    
    @IBOutlet weak var clueTitle1: UILabel!
    @IBOutlet weak var clueText1: UILabel!
    @IBOutlet weak var clueView1: UIView!
    @IBOutlet weak var clueTitle2: UILabel!
    @IBOutlet weak var clueText2: UILabel!
    @IBOutlet weak var clueView2: UIView!
    @IBOutlet weak var restartButton: UIButton!
    
    var clue1: Clue?
    var clue2: Clue?
    
    var currentHero: Hero? // Passed in from HeroCustomizeController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.getRealms { globalRealm, userRealm in
            
            let completedClues = userRealm.objects(CompletedClue.self).value(forKey:"id") as! [Int]
            let possibleClues = globalRealm.objects(Clue.self).filter(NSPredicate(format: "NOT (id IN %@)", completedClues))
            if(possibleClues.count > 0) {
                let clue1Index = Int(arc4random_uniform(UInt32(possibleClues.count)))
                self.clue1 = possibleClues[clue1Index]
                if(possibleClues.count > 1){
                    var clue2Index = clue1Index
                    while(clue2Index == clue1Index){
                        clue2Index = Int(arc4random_uniform(UInt32(possibleClues.count)))
                    }
                    self.clue2 = possibleClues[clue2Index]
                }
            
                // Update labels
                if let clue = self.clue1 {
                    self.clueTitle1.text = clue.clueTitle
                    self.clueText1.text = clue.clueText
                    self.clueTitle1.isHidden = false;
                    self.clueView1.isHidden = false;
                }else{
                    self.clueTitle1.isHidden = true;
                    self.clueView1.isHidden = true;
                }
            
                if let clue = self.clue2 {
                    self.clueTitle2.text = clue.clueTitle
                    self.clueText2.text = clue.clueText
                    self.clueTitle2.isHidden = false;
                    self.clueView2.isHidden = false;
                }else{
                    self.clueTitle2.isHidden = true;
                    self.clueView2.isHidden = true;
                }
                self.restartButton.isHidden = true;
            } else {
                self.clueTitle1.isHidden = true;
                self.clueView1.isHidden = true;
                self.clueTitle2.isHidden = true;
                self.clueView2.isHidden = true;
                self.restartButton.isHidden = false;
            }
        }
    }
    
    @IBAction func resetClues(_ sender: Any) {
        (UIApplication.shared.delegate as! AppDelegate).getUserRealm { realm in
            try! realm.write {
            realm.delete(realm.objects(CompletedClue.self))
                self.viewDidLoad()
            }
        }

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CameraController {
            if segue.identifier == "ToCameraController1" {
                destination.currentClue = self.clue1
            }
            if segue.identifier == "ToCameraController2" {
                destination.currentClue = self.clue2
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
