//
//  UserDataViewController.swift
//  TestCovidProject
//
//  Created by AP Yauheni Hramiashkevich on 11/1/20.
//

import UIKit

class UserDataViewController: UIViewController {
    var userNameLabel = UILabel(frame: CGRect(x: 10, y: 10, width: 10, height: 10))
    var userNameLabelText: String!
    
    var logoutBtn = UIButton(frame: CGRect(x: 10, y: 10, width: 100, height: 50))
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUserNameLabel()
        setLogoutBtn()
        print(userNameLabelText ?? "Login")
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    

    func setUserNameLabel() {
        self.view.addSubview(userNameLabel)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        userNameLabel.text = userNameLabelText
        userNameLabel.textAlignment = .center
        
        let userLabelTopConstr = NSLayoutConstraint(
            item: userNameLabel,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 100)
        
        let userLabelCenterConstr = NSLayoutConstraint(
            item: userNameLabel,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)
        
        let userLabelHeightConstr = NSLayoutConstraint(
            item: userNameLabel,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 30)
        
        let userLabelWidthConstr = NSLayoutConstraint(
            item: userNameLabel,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 200)
        
        self.view.addConstraints([userLabelTopConstr, userLabelWidthConstr, userLabelCenterConstr, userLabelHeightConstr])
    }
    
    func setLogoutBtn()  {
        self.view.addSubview(logoutBtn)
        logoutBtn.translatesAutoresizingMaskIntoConstraints = false
        logoutBtn.setTitle("Logout", for: .normal)
        logoutBtn.backgroundColor = .gray
        
        logoutBtn.addTarget(self, action: #selector(goBackToInitialViewController), for: .touchUpInside)
        
        let logoutBtnTopConst = NSLayoutConstraint(
            item: logoutBtn,
            attribute: .top,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .top,
            multiplier: 1,
            constant: 200)
        
        let logoutBtnCenterConst = NSLayoutConstraint(
            item: logoutBtn,
            attribute: .centerX,
            relatedBy: .equal,
            toItem: self.view,
            attribute: .centerX,
            multiplier: 1,
            constant: 0)
        
        let logoutBtnWidthConst = NSLayoutConstraint(
            item: logoutBtn,
            attribute: .width,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100)
        
        let logoutBtnHeightConst = NSLayoutConstraint(
            item: logoutBtn,
            attribute: .height,
            relatedBy: .equal,
            toItem: nil,
            attribute: .notAnAttribute,
            multiplier: 1,
            constant: 100)
        
        self.view.addConstraints([logoutBtnTopConst, logoutBtnCenterConst, logoutBtnWidthConst, logoutBtnHeightConst])
        
    }
    
    @objc func goBackToInitialViewController(){
        navigationController!.popViewController(animated: true)
    }

  

}
