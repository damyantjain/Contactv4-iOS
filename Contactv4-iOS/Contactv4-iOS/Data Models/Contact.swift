//
//  Contact.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import Foundation
import UIKit

public struct Contact {
    var name: String?
    var email: String?
    var phone: Int?

    init(
        name: String? = nil, email: String? = nil, phone: Int? = nil
    ) {
        self.name = name
        self.email = email
        self.phone = phone
    }
}
