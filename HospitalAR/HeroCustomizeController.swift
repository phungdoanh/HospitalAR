//
//  HeroCustomizeController.swift
//  HospitalAR
//
//  Created by Andrea Gonzales on 2/25/18.
//  Copyright © 2018 Andrea Gonzales. All rights reserved.
//

import Foundation
import RealmSwift

class HeroCustomizeController : UIViewController {
    var hero = Hero()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skinLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var suitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        hero.name
        nameLabel.text = "NAME: " + hero.name
//        var realm = try! Realm()
// print(realm.configuration.fileURL!.absoluteString)
//        try! realm.write {
//            realm.add(hero)
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func skinWhiteClick(_ sender: UIButton) {
        hero.skin = Skin.white
        skinLabel.text = "SKIN: " + hero.skin.rawValue
    }
    
    @IBAction func skinLightClick(_ sender: UIButton) {
        hero.skin = Skin.light
        skinLabel.text = "SKIN: " + hero.skin.rawValue
    }
    
    @IBAction func skinTanClick(_ sender: UIButton) {
        hero.skin = Skin.tan
        skinLabel.text = "SKIN: " + hero.skin.rawValue
    }
    
    @IBAction func skinDarkClick(_ sender: UIButton) {
        hero.skin = Skin.dark
        skinLabel.text = "SKIN: " + hero.skin.rawValue
    }
    
    //HAIR
    @IBAction func hairBlondClick(_ sender: UIButton) {
        hero.hair = Hair.blond
        hairLabel.text = "HAIR: " + hero.hair.rawValue
    }
    
    @IBAction func hairRedClick(_ sender: UIButton) {
        hero.hair = Hair.red
        hairLabel.text = "HAIR: " + hero.hair.rawValue
    }
    
    @IBAction func hairBrownClick(_ sender: UIButton) {
        hero.hair = Hair.brown
        hairLabel.text = "HAIR: " + hero.hair.rawValue
    }
    
    @IBAction func hairBlackClick(_ sender: UIButton) {
        hero.hair = Hair.black
        hairLabel.text = "HAIR: " + hero.hair.rawValue
    }
    
    //SUIT
    @IBAction func suitRedClick(_ sender: UIButton) {
        hero.suit = Suit.red
        suitLabel.text = "SUIT: " + hero.suit.rawValue
    }
    
    @IBAction func suitGreenClick(_ sender: UIButton) {
        hero.suit = Suit.green
        suitLabel.text = "SUIT: " + hero.suit.rawValue
    }
    
    @IBAction func suitBlueClick(_ sender: UIButton) {
        hero.suit = Suit.blue
        suitLabel.text = "SUIT: " + hero.suit.rawValue
    }
    
    @IBAction func suitPurpleClick(_ sender: UIButton) {
        hero.suit = Suit.purple
        suitLabel.text = "SUIT: " + hero.suit.rawValue
    }
}
