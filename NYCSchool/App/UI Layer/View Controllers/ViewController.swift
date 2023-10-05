//
//  ViewController.swift
//  NYCSchool
//
//  Created by Eliezer Antonio on 29/09/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let schoolsViewModel: SchoolsViewModel = SchoolsViewModel()
    private var cancellables = Set<AnyCancellable>()

    override func viewDidLoad() {
        super.viewDidLoad()
   
        setupBinders()
        schoolsViewModel.getSchools ()
        
    
    }
    
    private func setupBinders() {
        schoolsViewModel.$schools
            .receive(on: RunLoop.main)
            .sink { schools in
                print("retrieved \(schools.count) schools")
            }
            .store(in: &cancellables)
        
        schoolsViewModel.$error
            .receive(on: RunLoop.main)
            .sink { [weak self] error in
                if let error = error {
                    let alert = UIAlertController(title: "Error",
                                                  message: "Could not retrieve schools: \(error.localizedDescription)",
                                                  preferredStyle: .alert)
                    
                    let action = UIAlertAction(title: "OK",
                                               style: .default)
                    alert.addAction(action)
                    self?.present(alert,
                                  animated: true)
                }
            }
            .store(in: &cancellables)
    }

}

