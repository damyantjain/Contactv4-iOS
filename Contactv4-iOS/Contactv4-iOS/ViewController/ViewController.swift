//
//  ViewController.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 9/30/24.
//

import Alamofire
import UIKit

class ViewController: UIViewController {

    let landingView = LandingView()

    var contacts = [String]()
    var selectedContactIndex: Int?
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = landingView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Contacts"
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add, target: self,
            action: #selector(onAddBarButtonTapped))

        landingView.contactsTableView.delegate = self
        landingView.contactsTableView.dataSource = self
        landingView.contactsTableView.separatorStyle = .none

        notificationCenter.addObserver(
            self,
            selector: #selector(
                saveContactNotification(notification:)),
            name: .addContact,
            object: nil)

        notificationCenter.addObserver(
            self, selector: #selector(updateContactNotification(notification:)),
            name: .updateContact, object: nil)

        getAllContacts()

    }

    func getAllContacts() {
        if let url = URL(string: APIConfigs.baseURL + "getall") {
            AF.request(url, method: .get).responseData(completionHandler: {
                response in
                let status = response.response?.statusCode

                switch response.result {
                case .success(let data):
                    if let uwStatusCode = status {
                        switch uwStatusCode {
                        case 200...299:
                            self.contacts.removeAll()
                            let decoder = JSONDecoder()
                            do {
                                let receivedData =
                                    try decoder
                                    .decode(ContactsList.self, from: data)

                                for item in receivedData.contacts {
                                    self.contacts.append(item.name)
                                }
                                self.landingView.contactsTableView.reloadData()
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
            })
        }
    }

    func addANewContact(contact: Contact) {
        if let url = URL(string: APIConfigs.baseURL + "add") {

            AF.request(
                url, method: .post,
                parameters: [
                    "name": contact.name,
                    "email": contact.email,
                    "phone": contact.phone,
                ]
            )
            .responseString(completionHandler: { response in
                let status = response.response?.statusCode

                switch response.result {
                case .success(let data):
                    if let uwStatusCode = status {
                        switch uwStatusCode {
                        case 200...299:
                            self.getAllContacts()
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
            })
        } else {
        }
    }

    func deleteContact(contact: String) {
        if let url = URL(string: APIConfigs.baseURL + "delete") {

            AF.request(url, method: .get, parameters: ["name": contact])
                .responseData(completionHandler: { response in
                    let status = response.response?.statusCode

                    switch response.result {
                    case .success(_):
                        if let uwStatusCode = status {
                            switch uwStatusCode {
                            case 200...299:
                                self.getAllContacts()
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
                })
        } else {
        }
    }

    @objc func onAddBarButtonTapped() {
        let addContactViewController = ContactViewController()
        navigationController?.pushViewController(
            addContactViewController, animated: true)
    }

    @objc func saveContactNotification(notification: Notification) {
        getAllContacts()
    }

    @objc func updateContactNotification(notification: Notification) {
        if let selectedContactIndex = selectedContactIndex {
            let contact = (notification.object as! Contact)
            contacts[selectedContactIndex] = contact.name
            landingView.contactsTableView.reloadData()
        }
    }

    func editSelectedFor(contact: Int) {
        print("Will edit \(contacts[contact])")
    }

    func deleteSelectedFor(contact: Int) {
        let alert = UIAlertController(
            title: "Delete",
            message: "Are you sure you want to delete this contact?",
            preferredStyle: .alert
        )

        alert.addAction(
            UIAlertAction(
                title: "YES", style: .default,
                handler: { action in
                    //                    self.contacts.remove(at: contact)
                    //                    self.landingView.contactsTableView.reloadData()
                    self.deleteContact(contactId: contact)
                }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true)
    }

    func deleteContact(contactId: Int) {
        let contactName = contacts[contactId]
        deleteContact(contact: contactName)
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int)
        -> Int
    {
        return contacts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath)
        -> UITableViewCell
    {
        let cell =
            tableView.dequeueReusableCell(
                withIdentifier: "contacts", for: indexPath)
            as! ContactTableViewCell
        let name = contacts[indexPath.row]
        cell.selectionStyle = .none
        cell.nameLabel?.text = name

        let buttonOptions = UIButton(type: .system)
        buttonOptions.sizeToFit()
        buttonOptions.showsMenuAsPrimaryAction = true
        buttonOptions.setImage(
            UIImage(systemName: "slider.horizontal.3"), for: .normal)

        buttonOptions.menu = UIMenu(
            title: "Edit/Delete?",
            children: [
                UIAction(
                    title: "Edit",
                    handler: { (_) in
                        self.editSelectedFor(contact: indexPath.row)
                    }),
                UIAction(
                    title: "Delete",
                    handler: { (_) in
                        self.deleteSelectedFor(contact: indexPath.row)
                    }),
            ])
        cell.accessoryView = buttonOptions

        return cell
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        let contactName = contacts[indexPath.row]
        let profileViewController = ProfileViewController()
        selectedContactIndex = indexPath.row
        profileViewController.contactName = contactName
        navigationController?.pushViewController(
            profileViewController, animated: true)
    }
}
