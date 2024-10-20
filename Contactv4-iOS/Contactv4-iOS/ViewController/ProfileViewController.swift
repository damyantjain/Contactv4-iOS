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
    var contactData: Contact = Contact(name: "", email: "", phone: 0)
    var contactName: String?
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
        loadProfileData(name: contactName ?? "")
    }

    @objc func onEditButtonTapped() {
        let editProfileVC = ContactViewController()
        editProfileVC.contactData = contactData
        navigationController?.pushViewController(editProfileVC, animated: true)
    }

    @objc func updateContactNotification(notification: Notification) {
        contactData = (notification.object as! Contact)
        loadProfileData(name: contactName ?? "")
    }

    func displayData() {
        profileView.nameValueLabel.text = contactData.name
        profileView.emailValueLabel.text = "Email: \(contactData.email)"
        profileView.phoneValueLabel.text = "Phone: \(contactData.phone)"
    }

    func loadProfileData(name: String) {
        if let url = URL(string: APIConfigs.baseURL + "details") {
            AF.request(url, method: .get, parameters: ["name": name])
                .responseData(completionHandler: { response in
                    let status = response.response?.statusCode

                    switch response.result {
                    case .success(let data):
                        if let uwStatusCode = status {
                            switch uwStatusCode {
                            case 200...299:
                                let decoder = JSONDecoder()
                                do {
                                    let receivedData =
                                        try decoder
                                        .decode(Contact.self, from: data)
                                    self.contactData = receivedData
                                    self.displayData()
                                } catch (let error) {
                                    print(error)
                                }
                                break

                            case 400...499:
                                break

                            default:
                                break

                            }
                        }
                        break

                    case .failure(let error):
                        print(error)
                        break
                    }
                })
        }
    }

}
