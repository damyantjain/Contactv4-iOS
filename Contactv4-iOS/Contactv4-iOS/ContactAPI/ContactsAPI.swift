//
//  ContactsAPI.swift
//  Contactv4-iOS
//
//  Created by Damyant Jain on 10/21/24.
//

import Alamofire
import Foundation

class ContactsAPI: ContactsProtocol {
    func getAllContacts() async throws -> [String] {
        var contacts: [String] = []
        let url = APIConfigs.baseURL + "getall"
        let request = AF.request(url)
        let response = await request.serializingData().response
        let status = response.response?.statusCode
        switch response.result {
        case .success(let data):
            if let statusCode = status {
                switch statusCode {
                case 200...299:
                    let decoder = JSONDecoder()
                    do {
                        let receivedData =
                            try decoder
                            .decode(ContactsList.self, from: data)
                        for item in receivedData.contacts {
                            contacts.append(item.name)
                        }
                    } catch {
                        print("JSON couldn't be decoded.")
                    }
                    break
                case 400...499:
                    print("Client error: \(status!)")
                    break

                default:
                    print("Server error: \(status!)")
                    break
                }
            }
            break
        case .failure(let error):
            print("Request failed with error: \(error)")
            break
        }

        return contacts
    }

    func addANewContact(contact: Contact) async throws -> String {
        let url = URL(string: APIConfigs.baseURL + "add")
        return "test"
    }

    func getContactDetails(name: String) async throws -> Contact {
        return Contact(name: "", email: "", phone: 0)
    }

    func deleteContact(name: String) async throws -> String {
        return "test"
    }

}