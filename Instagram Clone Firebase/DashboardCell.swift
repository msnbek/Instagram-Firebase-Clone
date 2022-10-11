//
//  DashboardCell.swift
//  Instagram Clone Firebase
//
//  Created by Mahmut Şenbek on 10.10.2022.
//

import UIKit
import SDWebImage
import Firebase

class DashboardCell: UITableViewCell {
    
   
    @IBOutlet weak var eMailLabel: UILabel!
    
    @IBOutlet weak var documenIdLabel: UILabel!
    
    @IBOutlet weak var postImageView: UIImageView!
    
    @IBOutlet weak var commentLabel: UILabel!
    
    @IBOutlet weak var likeCountLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func likeButtonClicked(_ sender: Any) {
        
        let firestoreDatabase = Firestore.firestore()
        if let likeCount = Int(likeCountLabel.text!) {
            
            let likeStore = ["like" : likeCount + 1] as [String : Any]
            
           firestoreDatabase.collection("Posts").document(documenIdLabel.text!).setData(likeStore, merge: true)
        }
       
        
            
            
        }
        
        
        
    }
    


