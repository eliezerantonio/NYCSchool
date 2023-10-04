//
//  File.swift
//  NYCSchool
//
//  Created by Eliezer Antonio on 29/09/23.
//

import Foundation

struct School : Codable {
    
    let dbn: String
    let schoolName: String?
    let overviewParagraph: String?
    let schoolEmail: String?
    let academicOpportunities1: String?
    let academicOpportunities2: String?
    let neighborhood: String?
    let phoneNumber: String?
    let website: String?
    let finalgrades: String?
    let totalStudents: String?
    let schoolSports: String?
    let primaryAddressLine: String?
    let city: String?
    let zip : String?
    let latitude: String?
    let longitude: String?
    
    enum CodingKeys: String, CodingKey {
        case dbn
        case schoolName = "school_name"
        case overviewParagraph = "overview_paragraph"
        case schoolEmail = "school_email"
        case academicOpportunities1 = "academicopportunities1"
        case academicOpportunities2 = "academicopportunities2"
        case neighborhood
        case phoneNumber = "phoneNumber"
        case website
        case finalgrades
        case totalStudents = "total_students"
        case schoolSports = "school_sports"
        case primaryAddressLine = "primary_address_line_1"
        case city
        case zip
        case latitude
        case longitude
    }
}
