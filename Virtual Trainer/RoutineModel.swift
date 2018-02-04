//
//  RoutineModel.swift
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

enum WeightType {
    case cut
    case maintain
    case bulk
    case none
}

let cardioExercises: [String] = ["High Knees", "Burpee", "Mountain Climbers",
                        "Skaters", "Lunges", "Rowing", "Jump Rope(Invisible)"]

let weightExercises: [String] = ["Barbell Squat", "Barbell Bench Press",
                        "Barbell Row", "Deadlift", "Overhead Press",
                        "Leg Press", "Leg Extension", "Leg Press"]

var weightMax: [String: Double] = [
    "Barbell Squat": 0.0,
    "Barbell Bench Press": 0.0,
    "Barbell Row": 0.0,
    "Deadlift": 0.0,
    "Overhead Press": 0.0,
    "Leg Press": 0.0,
    "Leg Extension": 0.0,
    "Leg Press": 0.0
]


class Routine {
    static let setDefault = 5 // number of sets
    static let cardioDefault = 30 // number of seconds per rep
    static let largeIncrement: [String] = ["Barbell Squat", "Deadlift"]

    var failCount: [String: Int] = [
        "Barbell Squat": 0,
        "Barbell Bench Press": 0,
        "Barbell Row": 0,
        "Deadlift": 0,
        "Overhead Press": 0,
        "Leg Press": 0,
        "Leg Extension": 0,
        "Leg Press": 0,
        "High Knees": 0,
        "Burpee": 0,
        "Mountain Climbers": 0,
        "Skaters": 0,
        "Lunges": 0,
        "Rowing": 0,
        "Jump Rope(Invisible)": 0
    ]
    var day: [String: Day] = [
        "Sunday": Day(),
        "Monday": Day(),
        "Tuesday": Day(),
        "Wednesday": Day(),
        "Thursday": Day(),
        "Friday": Day(),
        "Saturday": Day()
    ]
    
    func incrementMax(exercise: String) {
        if failCount[exercise] == 0 {
            if Routine.largeIncrement.contains(exercise){
                weightMax[exercise] = weightMax[exercise]! + 5.0
            } else{
                weightMax[exercise] = weightMax[exercise]! + 2.5
            }
        }
    }
    
}

class Day {
    var weightType: WeightType = .none
    var load: Load = .none
    var exercises: [String: (Int, Int)] = [
        "Barbell Squat": (0,0),
        "Barbell Bench Press": (0,0),
        "Barbell Row": (0,0),
        "Deadlift": (0,0),
        "Overhead Press": (0,0),
        "Leg Press": (0,0),
        "Leg Extension": (0,0),
        "Leg Press": (0,0),
        "High Knees": (0,0),
        "Burpee": (0,0),
        "Mountain Climbers": (0,0),
        "Skaters": (0,0),
        "Lunges": (0,0),
        "Rowing": (0,0),
        "Jump Rope(Invisible)": (0,0)
    ]
    
    func cardio(load: Load, exercise1: Int, exercise2: Int) {
        self.load = load
        if self.load == .light {
            exercises[cardioExercises[exercise1]] = (3, Routine.cardioDefault)
            exercises[cardioExercises[exercise2]] = (3, Routine.cardioDefault)
        }
        if self.load == .medium {
            exercises[cardioExercises[exercise1]] = (5, Routine.cardioDefault)
            exercises[cardioExercises[exercise2]] = (5, Routine.cardioDefault)
        }
        if self.load == .heavy {
            exercises[cardioExercises[exercise1]] = (8, Routine.cardioDefault)
            exercises[cardioExercises[exercise2]] = (8, Routine.cardioDefault)
        }
    }
    
    func weight(type: WeightType, exercise1: Int, exercise2: Int, exercise3: Int)
    {
        weightType = type
        if weightType == .cut{
            exercises[weightExercises[exercise1]] = (Routine.setDefault, 12)
            exercises[weightExercises[exercise2]] = (Routine.setDefault, 12)
            exercises[weightExercises[exercise3]] = (Routine.setDefault, 12)
        }
        if weightType == .maintain{
            exercises[weightExercises[exercise1]] = (Routine.setDefault, 8)
            exercises[weightExercises[exercise2]] = (Routine.setDefault, 8)
            exercises[weightExercises[exercise3]] = (Routine.setDefault, 8)
        }
        if weightType == .bulk{
            exercises[weightExercises[exercise1]] = (Routine.setDefault, 5)
            exercises[weightExercises[exercise2]] = (Routine.setDefault, 5)
            exercises[weightExercises[exercise3]] = (Routine.setDefault, 5)
        }
    }
    
    func changeWeightType(type: WeightType)
    {
        for (exercise, rep) in exercises {
            if rep != (0,0) && weightExercises.contains(exercise){
                if type == .cut {
                    exercises[exercise] = (Routine.setDefault, 12)
                } else if type == .maintain {
                    exercises[exercise] = (Routine.setDefault, 8)
                } else if type == .bulk {
                    exercises[exercise] = (Routine.setDefault, 5)
                } else{
                    deleteWeightReps()
                }
            }
        }
    }
    
    func changeLoad(load: Load) {
        for (exercise, rep) in exercises {
            if rep != (0,0) && cardioExercises.contains(exercise) {
                if load == .light{
                    exercises[exercise] = (8, Routine.cardioDefault)
                } else if load == .medium {
                    exercises[exercise] = (5, Routine.cardioDefault)
                } else if load == .heavy {
                    exercises[exercise] = (3, Routine.cardioDefault)
                } else{
                    deleteCardioReps()
                }
            }
        }
    }
    
    func deleteAllReps() {
        for (exercise, _) in exercises {
            exercises[exercise] = (0,0)
        }
    }
    
    func deleteWeightReps() {
        for (exercise, _) in exercises {
            if weightExercises.contains(exercise) {
                exercises[exercise] = (0,0)
            }
        }
    }
    
    func deleteCardioReps() {
        for (exercise, _) in exercises {
            if cardioExercises.contains(exercise) {
                exercises[exercise] = (0,0)
            }
        }
    }
    
    func getExercises() -> [String: (Int,Int)] {
        return exercises
    }
    
    func getTrainingMax() -> [String: [Double]] {
        var result: [String: [Double]] = [:]
        for (exercise, max) in weightMax {
            if exercises[exercise]! != (0,0){
                var temp: [Double] = []
                for i in 1...Routine.setDefault{
                    let fraction: Double = Double(i)/Double(Routine.setDefault)
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


