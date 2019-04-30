//
//  DashboardViewController.swift
//  CanteenApp
//
//  Created by Dario Vieira on 2019/04/29.
//  Copyright © 2019 Dario. All rights reserved.
//

import Foundation
import UIKit

class DashboardViewController: UIViewController{
    
    var accessToken: String?
    var userEmail: String?
    
    @IBAction func launchFoodList(_ sender: UIButton) {
        

        
//        let foodlistVC = UIStoryboard.init(name: "LaunchScreen", bundle: Bundle.main).instantiateViewController(withIdentifier: "FoodlistViewController") as? FoodlistViewController
//        print(foodlistVC)
//        self.navigationController?.pushViewController(foodlistVC!, animated: true)
        
        let storyboard = UIStoryboard(name: "LaunchScreen", bundle: Bundle.main)
        

        guard let foodlistVC = storyboard.instantiateViewController(withIdentifier: "FoodlistViewController") as? FoodlistViewController else {
            return
        }
        
        self.parent!.navigationController!.pushViewController(foodlistVC, animated: true)
//
//        if let foodlistVC = foodlistNavigationVC.topViewController as? FoodlistViewController{
//            foodlistVC.userEmail = userEmail
//        }
//
//        self.present(foodlistNavigationVC, animated: true, completion: nil)
    }
    
    private let dashboardContentView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let orderNowButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("Order now", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    private let viewOrderButton:UIButton = {
        let btn = UIButton()
        btn.setTitle("View order", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .red
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(launchFoodList), for: .touchUpInside)
        return btn
    }()
    
    let imgLogo:UIImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "Logo2")
        img.translatesAutoresizingMaskIntoConstraints = false
        img.backgroundColor = UIColor(red: 0xc8, green: 0x00, blue: 0x00, alpha: 0x01)
        
        return img
    }()
    
    let imgLogoContainer:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 0xc8, green: 0x00, blue: 0x00, alpha: 0x01)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    func setUpAutoLayout(){
        dashboardContentView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
        dashboardContentView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
        if #available(iOS 11.0, *) {
            dashboardContentView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor).isActive = true
        } else {
            dashboardContentView.heightAnchor.constraint(equalToConstant: view.frame.height).isActive = true
            
        }
        dashboardContentView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        dashboardContentView.layoutIfNeeded()
        
        NSLayoutConstraint.activate([
            orderNowButton.centerXAnchor.constraint(equalTo: dashboardContentView.centerXAnchor),
            orderNowButton.centerYAnchor.constraint(equalTo: dashboardContentView.centerYAnchor, constant: -(orderNowButton.frame.size.height/2 + 10)),
            orderNowButton.widthAnchor.constraint(equalTo: dashboardContentView.widthAnchor, constant: -100),
            orderNowButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        NSLayoutConstraint.activate([
            viewOrderButton.centerXAnchor.constraint(equalTo: dashboardContentView.centerXAnchor),
            viewOrderButton.centerYAnchor.constraint(equalTo: dashboardContentView.centerYAnchor, constant: (orderNowButton.frame.size.height/2 + 10)),
            viewOrderButton.widthAnchor.constraint(equalTo: dashboardContentView.widthAnchor, constant: -100),
            viewOrderButton.heightAnchor.constraint(equalToConstant: 50),
            ])
        //Image logo container constraints
        NSLayoutConstraint.activate([
            imgLogoContainer.centerXAnchor.constraint(equalTo: dashboardContentView.centerXAnchor),
            imgLogoContainer.topAnchor.constraint(equalTo: dashboardContentView.topAnchor),
            imgLogoContainer.widthAnchor.constraint(equalTo: dashboardContentView.widthAnchor),
            imgLogoContainer.heightAnchor.constraint(equalTo: imgLogo.heightAnchor),
            ])
        
        //Image logo constraints
        NSLayoutConstraint.activate([
            imgLogo.centerXAnchor.constraint(equalTo: imgLogoContainer.centerXAnchor),
            imgLogo.topAnchor.constraint(equalTo: imgLogoContainer.topAnchor),
            imgLogo.heightAnchor.constraint(equalToConstant: 100),
            imgLogo.widthAnchor.constraint(equalToConstant: 200),
            ])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dashboardContentView.addSubview(orderNowButton)
        dashboardContentView.addSubview(viewOrderButton)
        
        imgLogoContainer.addSubview(imgLogo)
        dashboardContentView.addSubview(imgLogoContainer)
        
        view.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        view.addSubview(dashboardContentView)
        
        setUpAutoLayout()
    }
    
}
