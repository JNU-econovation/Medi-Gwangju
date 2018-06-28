import UIKit
import Firebase

class ViewController: UIViewController {

   var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        var user1 = User(user_id: 101, user_name: "은솔", user_pw: "p1234");
        
        self.ref = Database.database().reference(); //데이터 베이스를 읽는데 레퍼런스
        let itemref = self.ref.child("User");
        
        //아이템 추가
    //    itemref.child("\(user1.get_user_id())").setValue(["user_id": user1.get_user_id(),"user_name": user1.get_user_name(),"user_pw": user1.get_user_pw()]);
        
        /* itemref.child("user2").setValue(["user_id": user1.get_user_id(),"user_name": user1.get_user_name(),"user_pw": user1.get_user_pw()]);*/
      
        
        
        //아이템 검색
        ref.child("User").child("\(user1.get_user_id())").observeSingleEvent(of: .value, with: { (snapshot) in
            
            let value = snapshot.value as? NSDictionary
            let userId = value?["user_id"] as? Int ?? 0
            let username = value?["user_name"] as? String ?? ""
            let userpw = value?["user_pw"] as? String ?? ""
            let user = User(user_id: userId, user_name: username, user_pw: userpw);
            
            print("아이디:\(user.get_user_name())  비번: \(user.get_user_pw())");
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
        //////////////////////////////////////////
        
        //아이템 삭제
        // itemref.child("dadadadada").removeValue();
        
        //////////////////////////////////////////
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

