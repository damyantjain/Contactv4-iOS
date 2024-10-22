//
//  ViewControllerTableView.swift
//  Contactv4-iOS
//
//  Created by Damyant Jain on 10/21/24.
//

import UIKit

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
        let contactName = contacts[indexPath.row]
        cell.selectionStyle = .none
        cell.nameLabel?.text = contactName.name

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
        let contact = contacts[indexPath.row]
        let profileViewController = ProfileViewController()
        selectedContactIndex = indexPath.row
        profileViewController.contactName = contact
        navigationController?.pushViewController(
            profileViewController, animated: true)
    }

}
