//
//  CustomCell.swift
//  Customcell
//
//  Created by 조은솔 on 2018. 3. 15..
//  Copyright © 2018년 sol. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    //이거는 커스텀셀만드는 파일이다 스토리보드에서 커스텀셀 클래스 연결 해줘야해
    
    @IBOutlet weak var h_nameLabel: UILabel!
    @IBOutlet weak var h_distanceLabel: UILabel!
    @IBOutlet weak var h_addrLabel: UILabel!
    
    
    //여기 제일먼저 호출
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
