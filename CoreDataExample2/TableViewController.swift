//
//  TableViewController.swift
//  CoreDataExample2
//
//  Created by ruslan on 14.12.2021.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    
    let dataStoreManager = DataStoreManager()
    var fetchedResultsController: NSFetchedResultsController<User>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "The List"
        configureRFC()
        fetchedResultsController.delegate = self
    }
    
    // fetchedResultsController configuring
    private func configureRFC() {
        let context = dataStoreManager.persistentContainer.viewContext
        let fetchRequest = User.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: #keyPath(User.name), ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchRequest.fetchLimit = 15
        fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                              managedObjectContext: context,
                                                              sectionNameKeyPath: nil,
                                                              cacheName: nil)
        
        do {
            try fetchedResultsController.performFetch()
        } catch {
            fatalError("Failed to fetch entities: \(error)")
        }
    }
    
    @IBAction func addDidPressed(_ sender: Any) {
        dataStoreManager.addNewUser()
//        tableView.reloadData()
    }
    
    @IBAction func deleteAllDidPressed(_ sender: Any) {
        dataStoreManager.deleteAllUsers()
//        tableView.reloadData()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let frc = fetchedResultsController {
            return frc.sections!.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let sections = self.fetchedResultsController?.sections else {
            fatalError("No sections in fetchedResultsController")
        }
        let sectionInfo = sections[section]
        return sectionInfo.numberOfObjects
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        
        guard let object = self.fetchedResultsController?.object(at: indexPath) else {
            fatalError("Attempt to configure cell without a managed object")
        }
        
        cell.textLabel?.text = object.name
        cell.detailTextLabel?.text = object.book?.name
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let user = fetchedResultsController.object(at: indexPath)
            dataStoreManager.deleteUser(user)
        }
    }
}

// MARK: - FRC delegate

extension TableViewController: NSFetchedResultsControllerDelegate {
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            guard let newIndexPath = newIndexPath else { return }
            tableView.insertRows(at: [newIndexPath], with: .fade)
        case .delete:
            guard let indexPath = indexPath else { return }
            tableView.deleteRows(at: [indexPath], with: .fade)
//        case .move:
//            guard let indexPath = indexPath, let newIndexPath = newIndexPath else { return }
//            tableView.moveRow(at: indexPath, to: newIndexPath)
        default: return
        }
    }
}
