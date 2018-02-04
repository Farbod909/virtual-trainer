//
//  CategoryPickerVC.swift
//  Virtual Trainer
//
//  Created by Farbod Rafezy on 2/4/18.
//  Copyright © 2018 Farbod Rafezy. All rights reserved.
//

import UIKit

class CategoryPickerVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if (segue.identifier == "bulk") {
            let destinationVC = segue.destination as! WeightsPickerVC
            destinationVC.weightType = .bulk
        } else if (segue.identifier == "cut") {
            let destinationVC = segue.destination as! WeightsPickerVC
            destinationVC.weightType = .cut
        } else if (segue.identifier == "maintain") {
            let destinationVC = segue.destination as! WeightsPickerVC
            destinationVC.weightType = .maintain
        }

    }

}
