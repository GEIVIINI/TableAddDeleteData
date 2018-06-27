//
//  NewCareerTableViewCell.swift
//  TableViewAddDeleteData
//
//  Created by Soemsak on 3/22/2561 BE.
//  Copyright © 2561 Soemsak. All rights reserved.
//

import UIKit

protocol NewCareerTableViewCellDelegate {
    func getDone(career:String)
}

class NewCareerTableViewCell: UITableViewCell, UITextFieldDelegate {

    @IBOutlet weak var newCareerTextField: UITextField!
    
    var newCareer: String?
    var delegate: NewCareerTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        newCareerTextField.delegate = self
        newCareerTextField.addTarget(self, action: #selector(NewCareerTableViewCell.textFieldDidChange(_:)), for: .editingChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        newCareerTextField.text! = ""
        textField.resignFirstResponder()
        delegate?.getDone(career: newCareer!)
        return true
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {
        newCareer = newCareerTextField.text!
    }
}
