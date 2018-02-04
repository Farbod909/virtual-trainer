//
//  WeightsPickerVC.swift
//  Virtual Trainer
//
//  Created by Farbod Rafezy on 2/3/18.
//  Copyright © 2018 Farbod Rafezy. All rights reserved.
//

import Foundation
import UIKit

class WeightsPickerVC : UIViewController {

    var weightType = WeightType.none
    @IBOutlet weak var tableView: UITableView!
    var numSelected = 0
    let numSelectedMax = 3
    var selectedExercises = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func recommendedPicksPressed(_ sender: UIButton) {

    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.

        if (segue.identifier == "weightsExercisesDone") {
            let destinationVC = segue.destination as! WeightsScheduleVC
            destinationVC.exercise1 = selectedExercises[0]
            destinationVC.exercise2 = selectedExercises[1]
            destinationVC.exercise3 = selectedExercises[2]
            destinationVC.weightType = self.weightType
        }
    }
}

extension WeightsPickerVC : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weightExercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)

        cell.textLabel?.text = weightExercises[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {

            if cell.accessoryType == .none {
                if numSelected < numSelectedMax {
                    cell.accessoryType = .checkmark
                    numSelected += 1
                    selectedExercises.append((cell.textLabel?.text)!)
                }
            } else {
                cell.accessoryType = .none
                numSelected -= 1
                if let index = selectedExercises.index(of: (cell.textLabel?.text)!) {
                    selectedExercises.remove(at: index)
                }
            }

        }
    }
    
}
