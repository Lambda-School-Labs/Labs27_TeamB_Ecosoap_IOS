//
//  NewReportViewController.swift
//  labs-ios-starter
//
//  Created by Joseph Veverka on 10/6/20.
//  Copyright © 2020 Spencer Curtis. All rights reserved.
//

import UIKit

class NewReportViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    //MARK: - IBOutlet
    @IBOutlet var hoursWorkedTextField: UITextField!
    @IBOutlet var soapMakersTextField: UITextField!
    @IBOutlet var barsProducedTextField: UITextField!
    @IBOutlet var addAPhotoLabel: UILabel!
    @IBOutlet var addPhotoButtonOulet: UIButton!
    
    //MARK: - Class properties
    var imagePicker: UIImagePickerController?
    
    //MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBAction
    @IBAction func addPhotoButton(_ sender: UIButton) {
    }
    
    @IBAction func submitReportButton(_ sender: UIButton) {
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    //MARK: - Private methods
    
    // Access photo library
    private func presentPhotoLibraryActionSheet() {
        // make sure imagePicker is nill
        if self.imagePicker != nil {
            self.imagePicker?.delegate = nil
            self.imagePicker = nil
        }
        // init image picker
        self.imagePicker = UIImagePickerController()
        // action sheet
        let actionSheet = UIAlertController(title: "Select Source Type",
                                            message: nil,
                                            preferredStyle: .actionSheet)
        // imagePickerActions
        if UIImagePickerController.isSourceTypeAvailable(.camera) { // need to have real device
            actionSheet.addAction(UIAlertAction(title: "Camera",
                                                style: .default,
                                                handler: { _ in
                                                    self.presentImagePicker(controller: self.imagePicker!, sourceType: .camera)
                                                }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            actionSheet.addAction(UIAlertAction(title: "Photo Library",
                                                style: .default,
                                                handler: { _ in
                                                    self.presentImagePicker(controller: self.imagePicker!, sourceType: .photoLibrary)
                                                }))
        }
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum) {
            actionSheet.addAction(UIAlertAction(title: "Saved Albums",
                                                style: .default,
                                                handler: { _ in
                                                    self.presentImagePicker(controller: self.imagePicker!, sourceType: .savedPhotosAlbum)
                                                }))
        }
        actionSheet.addAction(UIAlertAction(title: "Cancel",
                                            style: .cancel))
        // present action sheet
        self.present(actionSheet, animated: true)
    }
    
    func presentImagePicker(controller: UIImagePickerController,
                            sourceType: UIImagePickerController.SourceType) {
        
        controller.delegate = self
        controller.sourceType = sourceType
        self.present(controller, animated: true)
    }
}
