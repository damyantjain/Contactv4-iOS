//
//  ContactsProtocol.swift
//  Contactv4-iOS
//
//  Created by Damyant Jain on 10/19/24.
//

import Foundation

protocol ContactsProtocol {
    
    func getAllContacts() async throws -> [String]
    
    func addANewContact(contact: Contact) async throws -> Bool
    
    func getContactDetails(name: String) async throws -> Contact
    
    func deleteContact(name: String) async throws -> Bool
}
