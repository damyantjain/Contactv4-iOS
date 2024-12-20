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
    var contacts = [ContactName]()
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
            selector: #selector(getAllContactNotification),
            name: .addContact,
            object: nil)

        notificationCenter.addObserver(
            self, selector: #selector(getAllContactNotification),
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

    @objc func onAddBarButtonTapped() {
        let addContactViewController = ContactViewController()
        navigationController?.pushViewController(
            addContactViewController, animated: true)
    }

    @objc func getAllContactNotification() {
        Task {
            await getAllContacts()
        }
    }

    func deleteContact(at index: Int) async {
        let contactName = contacts[index]
        do {
            let isDeleted = try await contactsAPI.deleteContact(
                name: contactName.name)
            if isDeleted {
                await getAllContacts()
            } else {
                showErrorAlert("Oops", "Failed to delete contact")
            }
        } catch {
            print("Error deleting contact: \(error)")
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
                handler: { _ in
                    Task {
                        await self.deleteContact(at: contact)
                    }
                })
        )
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

        self.present(alert, animated: true)
    }

    func showErrorAlert(_ title: String, _ message: String) {
        let alert = UIAlertController(
            title: title, message: "\(message)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
}
