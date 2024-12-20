//
//  ProfileViewController.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import Alamofire
import UIKit

class ProfileViewController: UIViewController {

    var profileView = ProfileView()
    var contactsAPI = ContactsAPI()
    var contactData: Contact = Contact(name: "", email: "", phone: 0)
    var contactName: ContactName?
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self,
            action: #selector(onEditButtonTapped))

        notificationCenter.addObserver(
            self, selector: #selector(updateContactNotification(notification:)),
            name: .updateContact, object: nil)

        Task {
            await loadProfileData(name: contactName?.name ?? "")
        }
    }

    @objc func onEditButtonTapped() {
        let editProfileVC = ContactViewController()
        editProfileVC.contactData = contactData
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    @objc func updateContactNotification(notification: Notification) {
        contactData = (notification.object as! Contact)
        displayData()
    }

    func displayData() {
        profileView.nameValueLabel.text = contactData.name
        profileView.emailValueLabel.text = "Email: \(contactData.email)"
        profileView.phoneValueLabel.text = "Phone: \(contactData.phone)"
    }

    func loadProfileData(name: String) async {
        do {
            contactData = try await contactsAPI.getContactDetails(
                name: name)
            self.displayData()
        } catch {
            showErrorAlert("Oops", "API call to fetch details failed")
        }
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
