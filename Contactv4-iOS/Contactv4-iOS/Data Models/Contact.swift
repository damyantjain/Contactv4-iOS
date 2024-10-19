//
//  Contact.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import Foundation
import UIKit

struct Contact: Codable{
    var name:String
    var email:String
    var phone:Int
    
    init(name: String, email: String, phone: Int) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}
