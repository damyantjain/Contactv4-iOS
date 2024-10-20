//
//  ContactsProtocol.swift
//  Contactv4-iOS
//
//  Created by Damyant Jain on 10/19/24.
//

import Foundation

protocol ContactsProtocol{
    func getAllContacts()
    func addANewContact(contact: Contact)
    func getContactDetails(name: String)
}

