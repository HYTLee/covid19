//
//  CasesDetailsViewController.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/3/20.
//

import UIKit

class CasesDetailsViewController: UIViewController {
    
    let countryLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
    let casesLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
    let deathLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 10, height: 10))


    override func viewDidLoad() {
        super.viewDidLoad()
        setCountryLabel()
        setCasesLabel()
        setDeathLabel()

        self.view.backgroundColor = .white
    }
    
    
    func setCountryLabel(){
        self.view.addSubview(countryLabel)
        countryLabel.translatesAutoresizingMaskIntoConstraints = false
    
        
        let countryLableTopConstr = NSLayoutConstraint(
            item: countryLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 100)
        
        let countryLableLeftConstr = NSLayoutConstraint(
            item: countryLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .leading,
            multiplier: 1,
            constant: 10)
        
        let countryLableRightConstr = NSLayoutConstraint(
            item: countryLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .trailing,
            multiplier: 1,
            constant: -10)
        
        self.view.addConstraints([countryLableTopConstr, countryLableLeftConstr, countryLableRightConstr])
    }

    func setCasesLabel(){
        self.view.addSubview(casesLabel)
        casesLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let casesLableTopConstr = NSLayoutConstraint(
            item: casesLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: countryLabel,
            attribute: .top,
            multiplier: 1,
            constant: 40)
        
        let casesLableLeftConstr = NSLayoutConstraint(
            item: casesLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .leading,
            multiplier: 1,
            constant: 10)
        
        let casesLableRightConstr = NSLayoutConstraint(
            item: casesLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .trailing,
            multiplier: 1,
            constant: -10)
        
        self.view.addConstraints([casesLableTopConstr, casesLableLeftConstr, casesLableRightConstr])
    }
    
    func setDeathLabel(){
        self.view.addSubview(deathLabel)
        deathLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let deathLableTopConstr = NSLayoutConstraint(
            item: deathLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: casesLabel,
            attribute: .top,
            multiplier: 1,
            constant: 40)
        
        let deathLableLeftConstr = NSLayoutConstraint(
            item: deathLabel,
            attribute: .leading,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .leading,
            multiplier: 1,
            constant: 10)
        
        let deathLableRightConstr = NSLayoutConstraint(
            item: deathLabel,
            attribute: .trailing,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .trailing,
            multiplier: 1,
            constant: -10)
        
        self.view.addConstraints([deathLableTopConstr, deathLableLeftConstr, deathLableRightConstr])
    }

}
