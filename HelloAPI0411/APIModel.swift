//
//  APIModel.swift
//  HelloAPI0411
//
//  Created by 建基吳 on 2020/4/11.
//  Copyright © 2020 sourceinn. All rights reserved.
//

import UIKit
import Alamofire

class APIModel{
    
    static var share = APIModel()
    private var apiURL = "https://randomuser.me/"
    private init(){
        
    }
    func queryRandomUser(completion:@escaping(_ Data:Any?, _ respError:Error?)->())->(){
        let urlString:String = apiURL + "api/"
        let parameters:Parameters? = nil
        DispatchQueue.global().async {
            AF.request(urlString, method: .get, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON(completionHandler:{(response) in
                DispatchQueue.main.async(execute: {
                    switch response.result {
                    case .success(_):
                        return completion(response.data, nil)
                    case .failure(let error):
                        return completion(nil, error)
                    }
                })
            })
        }
    }
}





