//
//  ProfileViewController.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import UIKit

class ProfileViewController: UIViewController {

    var profileView = ProfileView()
    var contactData: Contact = Contact()
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = profileView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .edit, target: self,
            action: #selector(onEditButtonTapped))
        notificationCenter.addObserver(self, selector: #selector(updateContactNotification(notification:)), name: .updateContact, object: nil)
        
        loadProfileData()
    }

    @objc func onEditButtonTapped() {
        let editProfileVC = ContactViewController()
        editProfileVC.contactData = contactData
        navigationController?.pushViewController(editProfileVC, animated: true)
    }
    
    @objc func updateContactNotification(notification: Notification) {
        contactData = (notification.object as! Contact)
        loadProfileData()
    }

    func loadProfileData() {
        profileView.nameValueLabel.text = contactData.name
        profileView.emailValueLabel.text = "Email: \(contactData.email ?? "")"
        profileView.phoneValueLabel.text = "Phone: \(contactData.phone ?? "")"
    }

}
