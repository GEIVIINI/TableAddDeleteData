//
//  ViewController.swift
//  TableViewAddDeleteData
//
//  Created by Soemsak on 3/21/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, NewCareerTableViewCellDelegate {

    @IBOutlet weak var addButton: UIBarButtonItem!
    @IBOutlet weak var editButton: UIBarButtonItem!
    
    var career = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func onEditTapped(_ sender: Any) {
        self.setEditing(!self.isEditing, animated: true)
        let setButton = UIBarButtonItem(barButtonSystemItem: (self.isEditing) ? .done : .edit, target: self, action: #selector(onEditTapped(_:)))
        self.navigationItem.setRightBarButton(setButton, animated: true)
        if isEditing {
            addButton.isEnabled = false
            tableView.isEditing = true
        } else {
            addButton.isEnabled = true
            tableView.isEditing = false
        }
    }

    @IBAction func onAddTapped(_ sender: Any) {
        let alert = UIAlertController(title: "Add career", message: nil, preferredStyle: .alert)
        alert.addTextField { (careerTF) in
            careerTF.placeholder = "Enter career"
        }
        let action = UIAlertAction(title: "Add", style: .default) { (_) in
            guard let career = alert.textFields?.first?.text else { return }
            print(career)
            self.add(career)
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func add(_ addCareer: String) {
        let index = career.count
        career.insert(addCareer, at: index)
        
        let indexPath = IndexPath(row: index, section: 0)
        tableView.insertRows(at: [indexPath], with: .left)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return career.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < career.count {
            let cell = UITableViewCell()
            let career = self.career[indexPath.row]
            cell.textLabel?.text = career
            //cell.accessoryType = .detailButton
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! NewCareerTableViewCell
            cell.delegate = self
            let paddingCareer = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 0))
            cell.newCareerTextField.leftView = paddingCareer
            cell.newCareerTextField.leftViewMode = UITextFieldViewMode.always
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        career.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let alert = UIAlertController(title: "Edit career", message: nil, preferredStyle: .alert)
        alert.addTextField { (careerTF) in
            careerTF.text = self.career[indexPath.row]
        }
        let action = UIAlertAction(title: "Edit", style: .default) { (_) in
            guard let editCareer = alert.textFields?.first?.text else { return }
            print("editCareer", editCareer)
            self.career[indexPath.row] = editCareer
            tableView.reloadData()
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .delete
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let movedObject = career[sourceIndexPath.row]
        career.remove(at: sourceIndexPath.row)
        career.insert(movedObject, at: destinationIndexPath.row)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let alert = UIAlertController(title: "Edit career", message: nil, preferredStyle: .alert)
        alert.addTextField { (careerTF) in
            careerTF.text = self.career[indexPath.row]
        }
        let action = UIAlertAction(title: "Edit", style: .default) { (_) in
            guard let editCareer = alert.textFields?.first?.text else { return }
            print("editCareer", editCareer)
            self.career[indexPath.row] = editCareer
            tableView.reloadData()
        }
        alert.addAction(action)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true)
    }
    
    func getDone(career: String) {
        self.add(career)
    }
    
}
