//
//  User.swift
//  firebaseTest
//
//  Created by 조은솔 on 2018. 4. 25..
//  Copyright © 2018년 sol. All rights reserved.
//

import UIKit

class User {
    
    var user_id: Int;
    var user_name: String;
    var user_pw: String;
    
    
    init(user_id: Int,user_name: String,user_pw: String) {
        self.user_id = user_id;
        self.user_pw = user_pw;
        self.user_name = user_name;
        
        
    }
    
    func get_user_id() -> Int {
        return user_id;
    }
    
    func get_user_name() ->String  {
        return user_name;
    }
    
    func get_user_pw() -> String {
        return user_pw;
    }
    
    
    
}
