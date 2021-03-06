//
//  ProfileDetailViewController.swift
//  LabsScaffolding
//
//  Created by Spencer Curtis on 7/27/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

protocol DetailProfileDelegate: class {
    func profileWasAdded()
}

class ProfileDetailViewController: UIViewController {
    
    // MARK: - Properties and Outlets
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var lastLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var skypeLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBOutlet weak var editStackView: UIStackView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var middleTextField: UITextField!
    @IBOutlet weak var lastTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var skypeTextField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
   
//    @IBOutlet weak var avatarURLTextField: UITextField!
    
    var profileController: ProfileController = ProfileController.shared
    var profile: Profile?
    var isUsersProfile = true
    var wasEdited = false
    weak var delegate: DetailProfileDelegate?
    var keyboardDismissalTapRecognizer: UITapGestureRecognizer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateViews()
        setUpKeyboardDismissalRecognizer()
        
        nameTextField.delegate = self
        middleTextField.delegate = self
        lastTextField.delegate = self
        emailTextField.delegate = self
        skypeTextField.delegate = self
        phoneNumberField.delegate = self
    }
    
    @IBAction func cancelProfileUpdate(_ sender: Any) {
        setEditing(false, animated: true)
    }
    
    @IBAction func saveProfileChanges(_ sender: Any) {
        // ToDo - send user back to
    }
    
    // Change to edit profile, figure out how to change button from edit to cancel
    @IBAction func updateProfile(_ sender: Any) {
        
        guard let profile = profileController.authenticatedUserProfile,
            let name = nameTextField.text,
            let middle = middleTextField.text,
            let last = lastTextField.text,
            let email = emailTextField.text,
            let skype = skypeTextField.text,
            let number = phoneNumberField.text
        else {
                presentSimpleAlert(with: "Some information was missing",
                                   message: "Please enter all information in to continue.",
                                   preferredStyle: .alert,
                                   dismissText: "Dismiss")
                return
        }
        
        profileController.updateAuthenticatedUserProfile(profile, with: name, middleName: middle, lastName: last, userEmail: email, userSkypeId: skype, userPhone: number) { [weak self] (updatedProfile) in
            guard let self = self else { return }
            self.updateViews(with: updatedProfile)
            self.navigationController?.popToRootViewController(animated: true)
          
        }

    }

        
    // MARK: - Private Methods

    private func setUpKeyboardDismissalRecognizer() {
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(recognizer)
        keyboardDismissalTapRecognizer = recognizer
    }
    
    @objc override func dismissKeyboard() {
        view.endEditing(true)
    }
    
    // MARK: View Setup
    
    private func updateViews() {
        
        if let profile = profile {
            title = "Details"
            updateViews(with: profile)
        } else if isUsersProfile,
            let profile = profileController.authenticatedUserProfile {
            title = "Me"
            updateViews(with: profile)
        }
    }
    
    private func updateViews(with profile: Profile) {
        guard isViewLoaded else { return }
        
        nameLabel.text = profile.firstName
        middleLabel.text = profile.middleName
        lastLabel.text = profile.lastName
        emailLabel.text = profile.userEmail
        skypeLabel.text = profile.userSkypeId
        numberLabel.text = profile.userPhone
        
        guard isUsersProfile else { return }
        
        navigationItem.rightBarButtonItem = editButtonItem
        
        nameTextField.text = profile.firstName
        middleTextField.text = profile.middleName
        lastTextField.text = profile.lastName
        emailTextField.text = profile.userPhone
        skypeTextField.text = profile.userSkypeId
        phoneNumberField.text = profile.userPhone
    }
}


// MARK: - UITextFieldDelegate

extension ProfileDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        
        case nameTextField:
            middleTextField.becomeFirstResponder()
        case middleTextField:
            lastTextField.becomeFirstResponder()
        case lastTextField:
            emailTextField.becomeFirstResponder()
        case emailTextField:
            skypeTextField.becomeFirstResponder()

        default:
            break
        }
        return true
    }
}
