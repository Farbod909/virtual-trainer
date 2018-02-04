//
//  CardioPickerVC.swift
//  Virtual Trainer
//
//  Created by Farbod Rafezy on 2/3/18.
//  Copyright © 2018 Farbod Rafezy. All rights reserved.
//

import Foundation
import UIKit

class CardioPickerVC : UIViewController {

    var numSelected = 0
    var load: Load = .none
    @IBOutlet weak var tableView: UITableView!
    var selectedExercises = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self

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

        if (segue.identifier == "cardioExercisesDone") {
            let destinationVC = segue.destination as! CardioScheduleVC
            destinationVC.exercise1 = selectedExercises[0]
            destinationVC.exercise2 = selectedExercises[1]
            destinationVC.load = self.load
        }
    }
}

extension CardioPickerVC : UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cardioExercises.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)

        cell.textLabel?.text = cardioExercises[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {

            if cell.accessoryType == .none {
                if numSelected < 2 {
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
