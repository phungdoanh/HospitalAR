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
    var btnList = [UIButton]()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var skinLabel: UILabel!
    @IBOutlet weak var hairLabel: UILabel!
    @IBOutlet weak var suitLabel: UILabel!
    
    @IBOutlet weak var skinToggle: UIButton!
    @IBOutlet weak var hairToggle: UIButton!
    @IBOutlet weak var suitToggle: UIButton!
    
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = "NAME: " + hero.name
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? ClueController {
            self.delegate.getUserRealm { realm in
                try! realm.write {
                    realm.add(self.hero)
                }
            }
            destination.currentHero = self.hero
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func addButtons(trait : String) {
        let wh:CGFloat = 30
        let ySpace:CGFloat = 8;
        let btnX = skinToggle.frame.minX + 4 //xbuffer
        var btnY = skinToggle.frame.maxY + ySpace
        
        switch trait {
        case "hair":
            let array = Hero.Hair.array
            for (n,i) in array.reversed().enumerated() {
                let btn = UIButton(type: UIButtonType.system) as UIButton
                btn.frame = CGRect(x:btnX, y:btnY, width:wh, height:wh)
                changeToHairBtn(btn: btn, hair: i)
                self.view.addSubview(btn)
                btn.alpha = 0;
                btnList.append(btn)
                btnY = btn.frame.maxY + ySpace
                UIView.animate(withDuration: 0.5, delay: TimeInterval(Double(array.count-n)/25.0), usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    print(n)
                    btn.alpha = 1.0;
                }, completion: nil)
            }
        case "skin":
            let array = Hero.Skin.array
            for (n,i) in array.reversed().enumerated() {
                let btn = UIButton(type: UIButtonType.system) as UIButton
                btn.frame = CGRect(x:btnX, y:btnY, width:wh, height:wh)
                changeToSkinBtn(btn: btn, skin: i)
                self.view.addSubview(btn)
                btn.alpha = 0;
                btnList.append(btn)
                btnY = btn.frame.maxY + ySpace
                UIView.animate(withDuration: 0.5, delay: TimeInterval(Double(array.count-n)/25.0), usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    print(n)
                    btn.alpha = 1.0;
                }, completion: nil)
            }
        default:
            let array = Hero.Suit.array
            for (n,i) in array.reversed().enumerated() {
                let btn = UIButton(type: UIButtonType.system) as UIButton
                btn.frame = CGRect(x:btnX, y:btnY, width:wh, height:wh)
                changeToSuitBtn(btn: btn, suit: i)
                btnList.append(btn)
                self.view.addSubview(btn)
                btn.alpha = 0;
                btnList.append(btn)
                btnY = btn.frame.maxY + ySpace
                UIView.animate(withDuration: 0.5, delay: TimeInterval(Double(array.count-n)/25.0), usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                    print(n)
                    btn.alpha = 1.0;
                }, completion: nil)
            }
        }
    }
    
    func changeToHairBtn(btn: UIButton, hair: Hero.Hair) {
        btn.backgroundColor = hair.uiColor
        btn.removeTarget(nil, action: nil, for:  .touchUpInside)
        btn.tag = hair.hashValue
        btn.addTarget(self, action: #selector(HeroCustomizeController.setHair), for: .touchUpInside)
    }
    
    func changeToSkinBtn(btn: UIButton, skin: Hero.Skin) {
        btn.backgroundColor = skin.uiColor
        btn.removeTarget(nil, action: nil, for:  .touchUpInside)
        btn.tag = skin.hashValue
        btn.addTarget(self, action: #selector(HeroCustomizeController.setSkin), for: .touchUpInside)
    }
    
    func changeToSuitBtn(btn: UIButton, suit: Hero.Suit) {
        btn.backgroundColor = suit.uiColor
        btn.removeTarget(nil, action: nil, for:  .touchUpInside)
        btn.tag = suit.hashValue
        btn.addTarget(self, action: #selector(HeroCustomizeController.setSuit), for: .touchUpInside)
    }
    
    
    @objc func setHair(sender:UIButton) {
        switch sender.tag {
        case 0:
            hero.hair = Hero.Hair.Blond
        case 1:
            hero.hair = Hero.Hair.Red
        case 2:
            hero.hair = Hero.Hair.Brown
        default:
            hero.hair = Hero.Hair.Black
        }
        hairLabel.text = "HAIR: " + hero.hair!.rawValue
    }
    
    @objc func setSkin(sender:UIButton) {
        switch sender.tag {
        case 0:
            hero.skin = Hero.Skin.White
        case 1:
            hero.skin = Hero.Skin.Light
        case 2:
            hero.skin = Hero.Skin.Tan
        default:
            hero.skin = Hero.Skin.Dark
        }
        skinLabel.text = "SKIN: " + hero.skin!.rawValue
    }
    
    @objc func setSuit(sender:UIButton) {
        switch sender.tag {
        case 0:
            hero.suit = Hero.Suit.Red
        case 1:
            hero.suit = Hero.Suit.Green
        case 2:
            hero.suit = Hero.Suit.Blue
        default:
            hero.suit = Hero.Suit.Purple
        }
        suitLabel.text = "SUIT: " + hero.suit!.rawValue
    }
    
    //SHOW & HIDE VIEWS
    @IBAction func toggleSkin(_ sender: UIButton) {
        skinToggle.isHidden = false;
        hairToggle.isHidden = !hairToggle.isHidden;
        suitToggle.isHidden = !suitToggle.isHidden;
        if(suitToggle.isHidden){
            addButtons(trait: "skin")
        } else {
            removeBtns()
        }
    }
    
    @IBAction func toggleHair(_ sender: UIButton) {
        hairToggle.isHidden = false;
        skinToggle.isHidden = !skinToggle.isHidden;
        suitToggle.isHidden = !suitToggle.isHidden;
        var translate = self.skinToggle.frame.minY-self.hairToggle.frame.minY
        
        if(skinToggle.isHidden) {
            translate = self.skinToggle.frame.minY-self.hairToggle.frame.minY
            addButtons(trait: "hair")
        } else {
            translate = self.hairToggle.frame.minY-self.skinToggle.frame.minY
            removeBtns()
        }
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.hairToggle.transform = CGAffineTransform(translationX: 0, y: translate);
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
    
    @IBAction func toggleSuit(_ sender: UIButton) {
        suitToggle.isHidden = false;
        hairToggle.isHidden = !hairToggle.isHidden;
        skinToggle.isHidden = !skinToggle.isHidden;
        var translate = self.skinToggle.frame.minY-self.suitToggle.frame.minY
        
        if(skinToggle.isHidden) {
            translate = self.skinToggle.frame.minY-self.suitToggle.frame.minY
            addButtons(trait: "suit")
        } else {
            translate = self.suitToggle.frame.minY-self.skinToggle.frame.minY
            removeBtns()
        }
        
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
            self.suitToggle.transform = CGAffineTransform(translationX: 0, y: translate);
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func removeBtns() {
        for (n,i) in btnList.enumerated() {
            i.alpha = 1.0
            UIView.animate(withDuration: 0.1, delay: TimeInterval(Double(n)/15.0), usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: .curveEaseInOut, animations: {
                i.alpha = 0.0;
            }, completion: {
                (value: Bool) in
                i.removeFromSuperview()
            })
        }
        btnList = [UIButton]()
    }
}
