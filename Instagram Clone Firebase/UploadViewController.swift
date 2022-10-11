//
//  UploadViewController.swift
//  Instagram Clone Firebase
//
//  Created by Mahmut Şenbek on 9.10.2022.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {

    @IBOutlet weak var commentText: UITextField!
    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.isUserInteractionEnabled = true
        let imageGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(imageGesture)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(hiddenKeyboard))
        view?.addGestureRecognizer(gesture)
    }
    @objc func imageTapped() {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true)
    }
    
    @objc func hiddenKeyboard() {
        
        view.endEditing(true)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadButtonClicked(_ sender: Any) {
        if  self.imageView.image == UIImage(named: "x") && self.commentText.text! == "" {
            self.makeAlert(tittleInput: "Error", messageInput: "Please choose photo!")
        }else {
            
            let storage = Storage.storage()
            let storageReference = storage.reference()
            
            let mediaFolder = storageReference.child("media")
            
            if let data = imageView.image?.jpegData(compressionQuality: 0.5) {
                
                let uuid = UUID().uuidString
                
                let imageReference = mediaFolder.child("\(uuid).jpg")
                imageReference.putData(data, metadata: nil) { storageMetaData, error in
                    if error != nil {
                        self.makeAlert(tittleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                    } else {
                        imageReference.downloadURL { url, error in
                            if error == nil {
                                let imageURL = url?.absoluteString
                            
                                let fireStoreDatabase = Firestore.firestore()
                                
                                var fireStoreReference : DocumentReference? = nil
                                
                                let fireStorePost = ["imageUrl" : imageURL!, "postedBy": Auth.auth().currentUser?.email! , "postComment": self.commentText.text!,"date": FieldValue.serverTimestamp(), "like": 0] as [String: Any]
                               
                                fireStoreReference = fireStoreDatabase.collection("Posts").addDocument(data: fireStorePost, completion: { error in
                                    if error != nil {
                                        self.makeAlert(tittleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                                       
                                    } else {
                                        
                                        self.imageView.image = UIImage(named: "x")
                                        self.commentText.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                    
                                })
                                
                                
                            }
                        }
                    }
                }
                
            }
            
            
        }
        
        
       
            
    }
    
    func makeAlert(tittleInput:String, messageInput:String) {
        let alert = UIAlertController(title: tittleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok!", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)

}
    
}
