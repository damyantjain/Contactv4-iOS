//
//  ContactsAPI.swift
//  Contactv4-iOS
//
//  Created by Damyant Jain on 10/21/24.
//

import Alamofire
import Foundation

class ContactsAPI: ContactsProtocol {
    func getAllContacts() async throws -> [ContactName] {
        var contacts: [ContactName] = []
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
                            contacts.append(ContactName(name: item.name))
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

    func addANewContact(contact: Contact) async throws -> Bool {

        let url = APIConfigs.baseURL + "add"
        let request = AF.request(
            url, method: .post,
            parameters: [
                "name": contact.name,
                "email": contact.email,
                "phone": contact.phone,
            ]
        )
        let response = await request.serializingData().response
        let status = response.response?.statusCode
        var success: Bool = false
        switch response.result {
        case .success(_):
            if let statusCode = status {
                switch statusCode {
                case 200...299:
                    success = true
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
        return success
    }

    func getContactDetails(name: String) async throws -> Contact {
        let url = APIConfigs.baseURL + "details"
        var contact: Contact = Contact(name: "", email: "", phone: 0)
        let request = AF.request(url, method: .get, parameters: ["name": name])
        let response = await request.serializingData().response
        let status = response.response?.statusCode
        switch response.result {
        case .success(let data):
            if let statusCode = status {
                switch statusCode {
                case 200...299:
                    contact = try JSONDecoder().decode(Contact.self, from: data)
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

        return contact
    }

    func deleteContact(name: String) async throws -> Bool {
        let url = APIConfigs.baseURL + "delete"
        let request = AF.request(url, method: .get, parameters: ["name": name])
        let response = await request.serializingData().response
        let status = response.response?.statusCode
        var success: Bool = false
        switch response.result {
        case .success(_):
            if let uwStatusCode = status {
                switch uwStatusCode {
                case 200...299:
                    success = true
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
        return success
    }
}
