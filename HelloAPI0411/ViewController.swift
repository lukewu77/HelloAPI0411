//
//  ViewController.swift
//  HelloAPI0411
//
//  Created by 建基吳 on 2020/4/11.
//  Copyright © 2020 sourceinn. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

class ViewController: UIViewController {

    @IBOutlet weak var nameText: UILabel!
    @IBOutlet weak var emailText: UILabel!
    
    @IBOutlet weak var myImage: UIImageView!
    
    var timer: Timer?
    @IBAction func getJson(_ sender: Any) {
        update()
    }

    @objc func update(){
        let model = APIModel.share
        model.queryRandomUser { (res, error) in
            if(error != nil){
                print("error:\(error?.localizedDescription)")
            }

            if let data = res as? Data{
                let json = JSON(data)
                print(json)
                let name = json["results"][0]["name"]["title"].stringValue + " " + json["results"][0]["name"]["last"].stringValue + " " +  json["results"][0]["name"]["first"].stringValue
                self.nameText.text = name
                print("name=\(name)")
                
                let email = json["results"][0]["email"].stringValue
                self.emailText.text = email
                print("email=\(email)")

                if let url = URL(string: json["results"][0]["picture"]["medium"].stringValue) {
                    do{
    //                  let imageData = try Data(contentsOf: url)
                        DispatchQueue.main.async {
    //                            self.myImage.image = UIImage(data: imageData)
                            self.myImage.kf.setImage(with: url)
                        }
                    }catch{
                       print("Image Error")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //                contentView.clipsToBounds = false
        //                contentView.backgroundColor = UIColor.clear
        //                contentView.layer.shadowRadius = 20
        //                contentView.layer.shadowOpacity = 0.6
        //                contentView.layer.shadowOffset = CGSize(width: 10, height: 10)
        //                contentView.layer.shadowColor = UIColor.black.cgColor
                        
        myImage.clipsToBounds = true
        print("width 1 = \(myImage.frame.width)")
        myImage.layer.cornerRadius = myImage.frame.width/2
        print("width 2 = \(myImage.frame.width/2)")
        
        update()
        self.timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        
        
    }


}

