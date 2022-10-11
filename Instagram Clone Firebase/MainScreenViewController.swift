//
//  MainScreenViewController.swift
//  Instagram Clone Firebase
//
//  Created by Mahmut Şenbek on 9.10.2022.
//

import UIKit
import Firebase
//import SDWebImage
import SDWebImageSwiftUI
//import SDWebImageLinkPlugin




class MainScreenViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{
    
    var userEmailArray = [String]()
    var userLikeCount = [Int]()
    var commentUser = [String]()
    var imageArray = [String]()
    var documentIdArray = [String]()
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        getDataFromFireBase()
    }
    
    func getDataFromFireBase() {
        let fireStoreDataBase = Firestore.firestore()
        
        fireStoreDataBase.collection("Posts").order(by: "date", descending: true).addSnapshotListener { snapshot, error in
            
            if error != nil {
                self.makeAlert(tittleInput: "Error", messageInput: error?.localizedDescription ?? "Error")
                
            }else {
                if snapshot?.isEmpty == false {
                    
                    self.userEmailArray.removeAll(keepingCapacity: false)
                    self.commentUser.removeAll(keepingCapacity: false)
                    self.userLikeCount.removeAll(keepingCapacity: false)
                    self.imageArray.removeAll(keepingCapacity: false)
                    self.documentIdArray.removeAll(keepingCapacity: false)
                    for documentt in snapshot!.documents {
                        
                        let documentID = documentt.documentID
                        self.documentIdArray.append(documentID)
                        if let postedBy = documentt.get("postedBy") as? String {
                            self.userEmailArray.append(postedBy)
                        }
                        if let like = documentt.get("like") as? Int {
                            self.userLikeCount.append(like)
                        }
                        if let comment = documentt.get("postComment") as? String {
                            self.commentUser.append(comment)
                        }
                        if let image = documentt.get("imageUrl") as? String {
                            self.imageArray.append(image)
                    
                        }
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
        
        
    }
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! DashboardCell
        cell.eMailLabel.text = userEmailArray[indexPath.row]
        cell.likeCountLabel.text = String(userLikeCount[indexPath.row])
        cell.commentLabel.text = commentUser[indexPath.row]
        cell.postImageView.sd_setImage(with: URL(string: imageArray[indexPath.row]))
        cell.documenIdLabel.text = documentIdArray[indexPath.row]
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userEmailArray.count
    }
    
    func makeAlert(tittleInput:String, messageInput:String) {
        let alert = UIAlertController(title: tittleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok!", style: UIAlertAction.Style.default)
        alert.addAction(okButton)
        self.present(alert, animated: true)

}

}
