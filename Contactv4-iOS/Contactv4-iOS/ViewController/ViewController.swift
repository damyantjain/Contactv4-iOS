//
//  ViewController.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 9/30/24.
//

import UIKit

class ViewController: UIViewController {

    let landingView = LandingView()

    var contacts = [Contact]()
    var selectedContactIndex: Int?

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

    }

    @objc func onAddBarButtonTapped() {
        let addContactViewController = ContactViewController()
        addContactViewController.landingPageDelegate = self
        navigationController?.pushViewController(
            addContactViewController, animated: true)
    }

    func saveContact(_ contact: Contact) {
        contacts.append(contact)
        landingView.contactsTableView.reloadData()
    }

    func updateUserProfile(_ contact: Contact) {
        if let selectedContactIndex = selectedContactIndex {
            contacts[selectedContactIndex] = contact
            landingView.contactsTableView.reloadData()
        }
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
        let contact = contacts[indexPath.row]
        cell.selectionStyle = .none
        cell.nameLabel?.text = contact.name
        cell.emailLabel?.text = contact.email
        cell.phoneLabel?.text = contact.phone
        return cell
    }

    func tableView(
        _ tableView: UITableView, didSelectRowAt indexPath: IndexPath
    ) {
        let contact = contacts[indexPath.row]
        let profileViewController = ProfileViewController()
        selectedContactIndex = indexPath.row
        profileViewController.contactData = contact
        profileViewController.landingPageDelegate = self
        navigationController?.pushViewController(
            profileViewController, animated: true)
    }
}
