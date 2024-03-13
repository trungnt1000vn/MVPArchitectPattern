//
//  ViewController.swift
//  MVPArchitectPattern
//
//  Created by Trung on 13/03/2024.
//

import UIKit

class UsersViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UserPresenterDelegate {
   
    

    private let tableView: UITableView = {
       let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var users = [User]()
    
    private let presenter = UserPresenter()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Users"
        //Table
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
        
        
        //Presenter
        presenter.setViewDelegate(delegate: self)
        presenter.getUsers()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = users[indexPath.row].name
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Ask the presenter to do its job
        presenter.didTapUser(user: users[indexPath.row])
    }
    
    //Presenter Delegate
    
    func presentUsers(users: [User]) {
        self.users = users
        
        DispatchQueue.main.async{
            self.tableView.reloadData()
        }
    }
    func presentAlert(title: String, message: String) {
      
    }
}

