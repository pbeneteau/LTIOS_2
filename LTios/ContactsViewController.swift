//
//  ContactsViewController.swift
//  LTios
//
//  Created by antoine beneteau on 2017-07-31.
//  Copyright © 2017 Tastyapp. All rights reserved.
//

import UIKit

class ContactsViewController: UIViewController, UITableViewDataSource {
    
    var containerView = UIView()
    
    var tableView = ContactsTableView()
    
    var contacts = [Contact]()
    var filteredContacts = [Contact]()
    var search: String = ""
    
    var isSearching = false
    
    lazy var searchLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    lazy var searchIcon: UIImageView = {
        let view = UIImageView()
        view.image = #imageLiteral(resourceName: "searchIconContact")
        return view
    }()
    
    lazy var searchTextField: UITextField = {
        let view = UITextField()
        view.textColor = .gray
        view.font = UIFont(name: "Roboto-Regular", size: 20)
        view.placeholder = "Search"
        view.borderStyle = .none
        view.keyboardType = .default
        view.keyboardAppearance = .light
        view.autocorrectionType = .no
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contacts = [
            Contact(name: "Antoine", surname: "Beneteau", country: "France"),
            Contact(name: "Paul", surname: "Beneteau", country: "France"),
            Contact(name: "Ines", surname: "Grabaud", country: "France"),
            Contact(name: "Jean", surname: "Kollin", country: "France"),
            Contact(name: "Arthur", surname: "Axolrs", country: "France"),
            Contact(name: "Joey", surname: "Amaduret", country: "France"),
            Contact(name: "Aline", surname: "Baludot", country: "France"),
            Contact(name: "Emilie", surname: "Melanchon", country: "France"),
            Contact(name: "Bob", surname: "Gastanaud", country: "France"),
            Contact(name: "Christian", surname: "Frajot", country: "France"),
            Contact(name: "Georges", surname: "Galudere", country: "France"),
            Contact(name: "Axel", surname: "Basanot", country: "France"),
            Contact(name: "Elliot", surname: "Grautt", country: "France")]
        
        view.backgroundColor = .clear
        containerView.backgroundColor = .white
        
        view.addSubview(containerView)
        containerView.addSubview(tableView)
        view.addSubview(searchLine)
        view.addSubview(searchIcon)
        view.addSubview(searchTextField)
        
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchConstraintsActive), for: .allEditingEvents)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.reloadData()
        
        view.setNeedsUpdateConstraints()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        containerView.layer.cornerRadius = 10
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.15
        containerView.layer.shadowOffset = CGSize(width: 0, height: 0)
        containerView.layer.shadowRadius = 5
    }
    
    @objc func searchConstraintsActive() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
            
            self.tableView.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(self.containerView.snp.width).multipliedBy(0.97)
                make.height.equalTo(self.containerView.snp.height).offset(-60)
                make.centerX.equalTo(self.containerView.snp.centerX)
                make.top.equalTo(self.containerView.snp.top).offset(60)
            }
            
            self.searchLine.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(self.containerView.snp.width)
                make.height.equalTo(0.5)
                make.top.equalTo(self.containerView.snp.top).offset(50)
                make.centerX.equalTo(self.containerView.snp.centerX)
            }
            
            self.searchIcon.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(25)
                make.height.equalTo(25)
                make.top.equalTo(self.containerView.snp.top).offset(12.5)
                make.left.equalTo(self.containerView.snp.left).offset(16)
            }
            
            self.searchTextField.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(self.containerView.snp.width).multipliedBy(0.8)
                make.top.equalTo(self.containerView.snp.top).offset(13)
                make.left.equalTo(self.searchIcon.snp.right).offset(10)
            }
            
            self.searchTextField.superview?.layoutIfNeeded()
        })
    }
    
    func searchConstraintsDisable() {
        UIView.animate(withDuration: 0.3, delay: 0, options: [.curveEaseInOut], animations: { () -> Void in
            
            self.tableView.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(self.containerView.snp.width).multipliedBy(0.97)
                make.height.equalTo(self.containerView.snp.height).offset(-50)
                make.centerX.equalTo(self.containerView.snp.centerX)
                make.top.equalTo(self.containerView.snp.top).offset(50)
            }
            
            self.searchLine.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(self.containerView.snp.width)
                make.height.equalTo(0.5)
                make.top.equalTo(self.containerView.snp.top).offset(40)
                make.centerX.equalTo(self.containerView.snp.centerX)
            }
            
            self.searchIcon.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(20)
                make.height.equalTo(20)
                make.top.equalTo(self.containerView.snp.top).offset(10)
                make.left.equalTo(self.containerView.snp.left).offset(16)
            }
            
            self.searchTextField.snp.remakeConstraints { (make) -> Void in
                make.width.equalTo(self.containerView.snp.width).multipliedBy(0.8)
                make.top.equalTo(self.containerView.snp.top).offset(9)
                make.left.equalTo(self.searchIcon.snp.right).offset(10)
            }
            
            self.searchTextField.superview?.layoutIfNeeded()
        })
    }
    
}

extension ContactsViewController {
    
    override func updateViewConstraints() {
        
        containerView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(view.snp.width)
            make.height.equalTo(view.snp.height)
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(view.snp.bottom).multipliedBy(0.1)
        }
        
        tableView.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView.snp.width).multipliedBy(0.97)
            make.height.equalTo(containerView.snp.height).multipliedBy(0.9)
            make.centerX.equalTo(containerView.snp.centerX)
            make.top.equalTo(containerView.snp.top).offset(50)
        }
        
        searchLine.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView.snp.width)
            make.height.equalTo(0.5)
            make.top.equalTo(containerView.snp.top).offset(40)
            make.centerX.equalTo(containerView.snp.centerX)
        }
        
        searchIcon.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(20)
            make.height.equalTo(20)
            make.top.equalTo(containerView.snp.top).offset(10)
            make.left.equalTo(containerView.snp.left).offset(16)
        }
        
        searchTextField.snp.makeConstraints { (make) -> Void in
            make.width.equalTo(containerView.snp.width).multipliedBy(0.8)
            make.top.equalTo(containerView.snp.top).offset(9)
            make.left.equalTo(searchIcon.snp.right).offset(10)
        }
        
        super.updateViewConstraints()
    }
    
}

extension ContactsViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return false
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        isSearching = true
        
        if string.isEmpty {
            search = String(search.dropLast())
        } else {
            search=textField.text!+string
        }
        
        filteredContacts.removeAll(keepingCapacity: false)
        let filtered = contacts.filter { $0.name!.range(of: search, options: [.caseInsensitive]) != nil
            || $0.surname?.range(of: search, options: [.caseInsensitive]) != nil }
        
        
        if filtered.count > 0 {
            filteredContacts.removeAll(keepingCapacity: true)
            filteredContacts = filtered
        } else {
            filteredContacts = contacts
        }
        tableView.reloadData()
        return true
    }
}

extension ContactsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filteredContacts.count
        } else {
            return contacts.count
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ContactsTableViewCell? = tableView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath) as? ContactsTableViewCell
        cell?.selectionStyle = .none
        return cell!
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? ContactsTableViewCell {
            _configureCell(cell, atIndexPath: indexPath)
        }
    }
    
    
    fileprivate func _configureCell(_ cell: ContactsTableViewCell, atIndexPath indexPath: IndexPath) {
        cell.queue.cancelAllOperations()
        
        let operation: BlockOperation = BlockOperation()
        operation.addExecutionBlock { [weak operation] () -> Void in
            
            DispatchQueue.main.sync(execute: { [weak operation] () -> Void in
                
                if let operation = operation, operation.isCancelled { return }
                
                if self.isSearching {
                    cell.name.text = self.filteredContacts[indexPath.row].name
                    cell.surname.text = self.filteredContacts[indexPath.row].surname
                    cell.country.text = self.filteredContacts[indexPath.row].country
                    cell.status.text = "added 3h ago"
                } else {
                    cell.name.text = self.contacts[indexPath.row].name
                    cell.surname.text = self.contacts[indexPath.row].surname
                    cell.country.text = self.contacts[indexPath.row].country
                    cell.status.text = "added 3h ago"
                }
//                
//                if true {
//                    cell.profilePicture.layer.borderWidth = 2
//                    cell.profilePicture.layer.borderColor = UIColor(red:0.11, green:0.20, blue:0.35, alpha:1.0).cgColor
//                }
            })
        }
        cell.queue.addOperation(operation)
    }
}

extension ContactsViewController: UIScrollViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        view.endEditing(true)
        searchConstraintsDisable()
    }
}
