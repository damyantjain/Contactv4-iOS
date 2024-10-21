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
    var contactsAPI = ContactsAPI()
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

        Task { await getAllContacts() }

    }

    func getAllContacts() async {
        do {
            contacts = try await contactsAPI.getAllContacts()
            self.landingView.contactsTableView.reloadData()
        } catch {
            print("error")
        }
    }

    func addANewContact(contact: Contact, completion: @escaping (Bool) -> Void)
    {
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
                case .success(_):
                    if let uwStatusCode = status {
                        switch uwStatusCode {
                        case 200...299:
                            completion(true)
                            break

                        case 400...499:
                            completion(false)
                            print("Client error: \(status!)")
                            break

                        default:
                            completion(false)
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

    func deleteContact(contact: String, completion: @escaping (Bool) -> Void) {
        if let url = URL(string: APIConfigs.baseURL + "delete") {

            AF.request(url, method: .get, parameters: ["name": contact])
                .responseData(completionHandler: { response in
                    let status = response.response?.statusCode

                    switch response.result {
                    case .success(_):
                        if let uwStatusCode = status {
                            switch uwStatusCode {
                            case 200...299:
                                completion(true)
                                break

                            case 400...499:
                                print("Client error: \(status!)")
                                completion(false)
                                break

                            default:
                                print("Server error: \(status!)")
                                completion(false)
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
        let contact = (notification.object as! Contact)
        addANewContact(contact: contact) { isAdded in
            if isAdded {
                //self.getAllContacts()
            }
        }
    }

    @objc func updateContactNotification(notification: Notification) {
        if let selectedContactIndex = selectedContactIndex {
            let contact = (notification.object as! Contact)
            let contactName = contacts[selectedContactIndex]
            deleteContact(contact: contactName) { isDeleted in
                if isDeleted {
                    self.addANewContact(contact: contact) { isAdded in
                        if isAdded {
                            self.notificationCenter.post(
                                name: .contactEdited,
                                object: contact.name)
                            //  self.getAllContacts()
                        }
                    }
                }
            }
        }
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
                    let contactName = self.contacts[contact]
                    self.deleteContact(contact: contactName) { isDeleted in
                        if isDeleted {
                            //self.getAllContacts()
                        }
                    }
                }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true)
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
        buttonOptions.frame = CGRect(x: 0, y: 0, width: 35, height: 35)
        buttonOptions.setImage(
            UIImage(systemName: "trash"), for: .normal)
        buttonOptions.addAction(
            UIAction(
                title: "Delete",
                handler: { (_) in
                    self.deleteSelectedFor(contact: indexPath.row)
                }), for: .touchUpInside)
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
