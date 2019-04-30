//
//  DashboardNavigationController.swift
//  CanteenApp
//
//  Created by Dario Vieira on 2019/04/30.
//  Copyright © 2019 Dario. All rights reserved.
//

import Foundation
import UIKit

class DashboardNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViewControllers([DashboardViewController()], animated: true)
    }
}
