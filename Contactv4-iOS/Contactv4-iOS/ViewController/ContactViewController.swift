//
//  AddContactViewController.swift
//  Contactv2-iOS
//
//  Created by Damyant Jain on 10/1/24.
//

import Alamofire
import PhotosUI
import UIKit

class ContactViewController: UIViewController {

    var addContactView = ContactView()
    var contactsAPI = ContactsAPI()
    var contactData: Contact?
    var isEdit: Bool = false
    let notificationCenter = NotificationCenter.default

    override func loadView() {
        view = addContactView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let tapRecognizer = UITapGestureRecognizer(
            target: self, action: #selector(hideKeyboardOnTap))
        tapRecognizer.cancelsTouchesInView = false
        view.addGestureRecognizer(tapRecognizer)

        navigationItem.rightBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .save, target: self,
            action: #selector(onSaveButtonTapped))
        if contactData != nil {
            setUpContactFields()
            isEdit = true
            title = "Edit Contact"
        } else {
            isEdit = false
            title = "Add Contact"
        }
    }

    func setUpContactFields() {
        addContactView.nameTextField.text = contactData?.name
        addContactView.emailTextField.text = contactData?.email
        addContactView.phoneTextField.text =
            contactData?.phone != nil ? "\(contactData!.phone)" : nil
    }

    @objc func hideKeyboardOnTap() {
        view.endEditing(true)
    }

    @objc func onSaveButtonTapped() {
        Task {
            await handleSaveButtonTapped()
        }
    }

    func handleSaveButtonTapped() async {
        let validation = validateForm()

        if validation.0 {
            if isEdit {
                notificationCenter.post(
                    name: .updateContact,
                    object: validation.1)
            } else {
                do {
                    let success = try await contactsAPI.addANewContact(
                        contact: validation.1)
                    if success {
                        notificationCenter.post(name: .addContact, object: nil)

                        navigationController?.popViewController(animated: true)
                    }
                } catch {
                    print("API call failed with error: \(error)")
                    showErrorAlert("Failed to add contact. Please try again.")
                }
            }
        }
    }

    func validateForm() -> (Bool, Contact) {
        var profileData = Contact(name: "", email: "", phone: 0)

        //check if fields are not empty
        if let name = addContactView.nameTextField.text {
            if name.isEmpty {
                showErrorAlert("Please enter your name")
                return (false, profileData)
            } else {
                profileData.name = name
            }
        }

        if let email = addContactView.emailTextField.text {
            if email.isEmpty || !isValidEmail(email) {
                showErrorAlert("Please enter a valid email")
                return (false, profileData)
            } else {
                profileData.email = email
            }
        }

        if let phoneNumber = addContactView.phoneTextField.text {
            if phoneNumber.isEmpty {
                showErrorAlert("Please enter your phone number")
                return (false, profileData)
            } else {
                profileData.phone = Int(phoneNumber) ?? 0
            }
        }
        return (true, profileData)
    }

    // Logic from stackoverflow - stackoverflow.com/a/25471164/15136189
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }

    func isCityStateValid(_ cityState: String) -> Bool {
        let arr = cityState.split(separator: ",")
        if arr.count != 2 {
            return false
        }
        return !arr[0].trimmingCharacters(in: .whitespaces).isEmpty
            && !arr[1].trimmingCharacters(in: .whitespaces).isEmpty
    }

    func showErrorAlert(_ message: String) {
        let alert = UIAlertController(
            title: "Validation Error", message: "\(message)",
            preferredStyle: .alert
        )

        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }

}
