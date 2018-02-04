//
//  ViewController.swift
//  Virtual Trainer
//
//  Created by Farbod Rafezy on 2/3/18.
//  Copyright © 2018 Farbod Rafezy. All rights reserved.
//

import UIKit

enum Load {
    case light
    case medium
    case heavy
    case none
}

enum WeightType{
    case cut
    case maintain
    case bulk
    case none
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


class Schedule{
    let setDefault = 5
    let cardioDefault = 30
    let largeIncrement: [String] = ["Barbell Squat", "Deadlift"]
    var weightMax: [String: Double] = ["Barbell Squat": 0.0, "Barbell Bench Press": 0.0, "Barbell Row": 0.0, "Deadlift": 0.0, "Overhead Press": 0.0, "Leg Press": 0.0, "Leg Extension": 0.0, "Leg Press": 0.0]
    var failCount: [String: Int] = ["Barbell Squat": 0, "Barbell Bench Press": 0, "Barbell Row": 0, "Deadlift": 0, "Overhead Press": 0, "Leg Press": 0, "Leg Extension": 0, "Leg Press": 0, "High Knees": 0, "Burpee": 0, "Mountain Climbers": 0, "Skaters": 0, "Lunges": 0, "Rowing": 0, "Jump Rope(Invisible)": 0]
    var day: [String: Day] = ["Sunday": Day(), "Monday": Day(), "Tuesday": Day(), "Wednesday": Day(), "Thursday": Day(), "Friday": Day(), "Saturday": Day()]
    
    func incrementMax(exercise: String){
        if failCount[exercise] == 0{
            if largeIncrement.contains(exercise){
                weightMax[exercise] = weightMax[exercise]! + 5.0
            } else{
                weightMax[exercise] = weightMax[exercise]! + 2.5
            }
        }
    }
    
}

class Day: Schedule{
    var weightType: WeightType = .none
    var load: Load = .none
    var exercises: [String: (Int, Int)] = ["Barbell Squat": (0,0), "Barbell Bench Press": (0,0), "Barbell Row": (0,0), "Deadlift": (0,0), "Overhead Press": (0,0), "Leg Press": (0,0), "Leg Extension": (0,0), "Leg Press": (0,0), "High Knees": (0,0), "Burpee": (0,0), "Mountain Climbers": (0,0), "Skaters": (0,0), "Lunges": (0,0), "Rowing": (0,0), "Jump Rope(Invisible)": (0,0)]
    let cardio: [String] = ["High Knees", "Burpee", "Mountain Climbers", "Skaters", "Lunges", "Rowing", "Jump Rope(Invisible)"]
    let weight: [String] = ["Barbell Squat", "Barbell Bench Press", "Barbell Row", "Deadlift", "Overhead Press", "Leg Press", "Leg Extension", "Leg Press"]
    
    func cardio(load: Load, exercise1: Int, exercise2: Int){
        self.load = load
        if self.load == .light{
            exercises[cardio[exercise1]] = (3,cardioDefault)
            exercises[cardio[exercise2]] = (3,cardioDefault)
        }
        if self.load == .medium{
            exercises[cardio[exercise1]] = (5,cardioDefault)
            exercises[cardio[exercise2]] = (5,cardioDefault)
        }
        if self.load == .heavy{
            exercises[cardio[exercise1]] = (8,cardioDefault)
            exercises[cardio[exercise2]] = (8,cardioDefault)
        }
    }
    
    func weight(type: WeightType, exercise1: Int, exercise2: Int, exercise3: Int)
    {
        weightType = type
        if weightType == .cut{
            exercises[weight[exercise1]] = (setDefault, 12)
            exercises[weight[exercise2]] = (setDefault, 12)
            exercises[weight[exercise3]] = (setDefault, 12)
        }
        if weightType == .maintain{
            exercises[weight[exercise1]] = (setDefault, 8)
            exercises[weight[exercise2]] = (setDefault, 8)
            exercises[weight[exercise3]] = (setDefault, 8)
        }
        if weightType == .bulk{
            exercises[weight[exercise1]] = (setDefault, 5)
            exercises[weight[exercise2]] = (setDefault, 5)
            exercises[weight[exercise3]] = (setDefault, 5)
        }
    }
    
    func changeWeightType(type: WeightType)
    {
        for (exercise, rep) in exercises{
            if rep != (0,0) && weight.contains(exercise){
                if type == .cut{
                    exercises[exercise] = (setDefault,12)
                } else if type == .maintain{
                    exercises[exercise] = (setDefault,8)
                } else if type == .bulk{
                    exercises[exercise] = (setDefault,5)
                } else{
                    deleteWeightReps()
                }
            }
        }
    }
    
    func changeLoad(load: Load)
    {
        for (exercise, rep) in exercises{
            if rep != (0,0) && cardio.contains(exercise){
                if load == .light{
                    exercises[exercise] = (8,cardioDefault)
                } else if load == .medium{
                    exercises[exercise] = (5,cardioDefault)
                } else if load == .heavy{
                    exercises[exercise] = (3,cardioDefault)
                } else{
                    deleteCardioReps()
                }
            }
        }
    }
    
    func deleteAllReps(){
        for (exercise, _) in exercises{
            exercises[exercise] = (0,0)
        }
    }
    
    func deleteWeightReps(){
        for (exercise, _) in exercises{
            if weight.contains(exercise){
                exercises[exercise] = (0,0)
            }
        }
    }
    
    func deleteCardioReps(){
        for (exercise, _) in exercises{
            if cardio.contains(exercise){
                exercises[exercise] = (0,0)
            }
        }
    }
    
    func getExercises() -> [String: (Int,Int)]{
        return exercises
    }
    
    func getTrainingMax() -> [String: [Double]]{
        var result: [String: [Double]] = [:]
        for (exercise, max) in weightMax{
            if exercises[exercise]! != (0,0){
                var temp: [Double] = []
                for i in 1...setDefault{
                    let fraction: Double = Double(i)/Double(setDefault)
                    if weightType == .cut{
                        let temp1: Double = max * (0.4 + 0.3*fraction)
                        temp.append(Double(Int(temp1/2.5)) * 2.5)
                    }
                    if weightType == .maintain{
                        let temp2: Double = max * (0.6 + 0.2*fraction)
                        temp.append(Double(Int(temp2/2.5)) * 2.5)
                    }
                    if weightType == .bulk{
                        let temp3: Double = max * (0.7 + 0.2*fraction)
                        temp.append(Double(Int(temp3/2.5)) * 2.5)
                    }
                }
                result[exercise] = temp
            }
        }
        return result
    }
}

