//
//  MockSchoolAPI.swift
//  NYCSchoolTests
//
//  Created by Eliezer Antonio on 04/10/23.
//

import Foundation

@testable import NYCSchool

class MockSchoolAPI : SchoolAPILogic {
    
    var loadState: SchoolListLoadState = .empty
    
    func getSchools(completion: @escaping (NYCSchool.SchoolListAPIResponse)) {
        switch loadState{
        case .error:
            completion(.failure(.networkingError("could not fech schools")))
        case .loaded:
            let mock = School(dbn: "02M260",
                              schoolName: "Clinton School Writers & Artists, M.S. 260",
                              overviewParagraph: "Students who are prepared for college must have an education that encourages them to take...",
                              schoolEmail: "admissions@theclintonschool.net",
                              academicOpportunities1: "Free college courses at neighboring universities",
                              academicOpportunities2: "International Travel, Special Arts Programs, Music, Internships, College Mentoring English Language Learner Programs: English as a New Language",
                              neighborhood: "Chelsea-Union Sq",
                              phoneNumber: "212-524-4360",
                              website: "www.theclintonschool.net",
                              finalgrades: "6-12",
                              totalStudents: "376",
                              schoolSports: "Cross Country, Track and Field, Soccer, Flag Football, Basketball",
                              primaryAddressLine: "10 East 15th Street",
                              city: "Manhattan",
                              zip: "10003",
                              latitude: "40.73653",
                              longitude: "-73.9927")
            
            completion(.success([mock]))
        case .empty:
            completion(.success([]))
        }
        
    }
    
    
}
