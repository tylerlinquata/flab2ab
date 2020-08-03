//
//  WorkoutViewController.swift
//  flab2ab
//
//  Created by Tyler Linquata on 7/30/20.
//  Copyright © 2020 Tyler Linquata. All rights reserved.
//

import UIKit

class WorkoutViewController: UIViewController {
    
    //MARK: Properties
    var workout = Workout()
    
    @IBOutlet var tableView: UITableView!

    @IBAction func addExercisePressed(_ sender: Any) {
        addNewExercisePopup()
        
    }
    
    //MARK: Public Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // hides empty rows
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    //MARK: Private Methods
    
    fileprivate func addExerciseToWorkout(_ workoutName: String) {
        workout.addExercise(name: workoutName)
        
        let indexPath = IndexPath(row: self.workout.exercises.count - 1, section: 0)
        tableView.beginUpdates()
        tableView.insertRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }
    
    private func addNewExercisePopup() {
        let ac = UIAlertController(title: "Exercise name", message: nil, preferredStyle: .alert)
        ac.addTextField()
        
        let submitAction = UIAlertAction(title: "Add", style: .default) { [unowned ac] _ in
            if let workoutName = ac.textFields![0].text {
                self.addExerciseToWorkout(workoutName)
            }
        }
    
        ac.addAction(submitAction)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        present(ac, animated: true)
    }
}

//MARK: Extensions

extension WorkoutViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("tapped")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.exercises.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "exerciseCell", for: indexPath)
        
        cell.textLabel?.text = workout.exercises[indexPath.row].name
        
        return cell
    }
}


