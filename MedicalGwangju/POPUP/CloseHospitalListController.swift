
//
//  CloseHospitalListController.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 8..
//  Copyright © 2018년 sol. All rights reserved.
//

import UIKit


class CloseHospitalListController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var hospitalItem: Array<Hospital>? = nil
    var delegate: MapViewContainer?
    private var myTableView = UITableView()
    
    convenience init(item: Array<Hospital>) {
        self.init()
        hospitalItem = nil
        hospitalItem = item
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var rect: CGRect?
        
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: myTableView.frame.size.width, height: 0))
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        myTableView.dataSource = self
        myTableView.delegate = self
        myTableView.tableFooterView = footerView
        self.myTableView.translatesAutoresizingMaskIntoConstraints = false
        
        
        self.view.addSubview(myTableView)
        
        if((hospitalItem?.count)!<6 && (hospitalItem?.count)!>0){
            rect = CGRect(x: 0, y: 0, width: Int(myTableView.frame.size.width), height: 44*(hospitalItem?.count)!)
        }else{
            rect = CGRect(x: 0, y: 0, width: myTableView.frame.size.width, height: 44*5)
        }
        
        self.preferredContentSize = rect!.size
        
        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView, attribute: .top, relatedBy: .equal, toItem: self.view, attribute: .top, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1.0, constant: 0))
        self.view.addConstraint(NSLayoutConstraint(item: self.myTableView, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1.0, constant: 0))
        
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.delegate?.clickHospitalList(item: hospitalItem![indexPath.row])
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return hospitalItem!.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        cell.textLabel!.text = NSLocalizedString(hospitalItem![indexPath.row].h_name, comment: "")
        return cell
    }
}
