//
//  DetailHospitalController.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 13..
//  Copyright © 2018년 sol. All rights reserved.
//

import UIKit

class DetailHospitalController: UIViewController {
    
    var superView: MapViewController?
    var detailHospital: Hospital?
    var subView: DetailMapViewController?
    
    @IBOutlet weak var FreeDiagnose: UIButton!
    @IBOutlet weak var directionsButton: UIButton!
    @IBOutlet weak var forStudentButton: UIButton!
    @IBOutlet weak var warnIcon: UIImageView!
    @IBOutlet weak var warnText: UILabel!
    
    //이름, 요일
    @IBOutlet weak var h_name_label: UILabel!
    @IBOutlet weak var h_addr_label: UILabel!
    @IBOutlet weak var h_phone_label: UILabel!
    @IBOutlet weak var mon_label: UILabel!
    @IBOutlet weak var tues_label: UILabel!
    @IBOutlet weak var wed_label: UILabel!
    @IBOutlet weak var thur_label: UILabel!
    @IBOutlet weak var fri_label: UILabel!
    @IBOutlet weak var sat_label: UILabel!
    @IBOutlet weak var sun_label: UILabel!
    @IBOutlet weak var holi_label: UILabel!
    
    
    @IBOutlet weak var dutytime: UILabel!
    @IBOutlet weak var addr: UILabel!
    @IBOutlet weak var phone: UILabel!
    
    @IBOutlet weak var mon: UILabel!
    @IBOutlet weak var tues: UILabel!
    @IBOutlet weak var wed: UILabel!
    @IBOutlet weak var thur: UILabel!
    @IBOutlet weak var fri: UILabel!
    @IBOutlet weak var sat: UILabel!
    @IBOutlet weak var hol: UILabel!
    @IBOutlet weak var sun: UILabel!
    
    @IBOutlet weak var dutytimealert: UILabel!
    @IBOutlet weak var warnLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailHospital = superView?.selHosptial
        
        guard  let hospital = detailHospital else{
            return
        }
        
        dutytime.text! = NSLocalizedString("운영시간" , comment: "")
        addr.text! = NSLocalizedString("주소" , comment: "")
        phone.text! = NSLocalizedString("전화" , comment: "")
        forStudentButton.setTitle(NSLocalizedString("외국인 유학생 무료진료" , comment: ""), for: .normal)
        directionsButton.setTitle(NSLocalizedString("길찾기" , comment: ""), for: .normal)
        
        mon.text! = NSLocalizedString("월요일" , comment: "")
        tues.text! = NSLocalizedString("화요일" , comment: "")
        wed.text! = NSLocalizedString("수요일" , comment: "")
        thur.text! = NSLocalizedString("목요일" , comment: "")
        fri.text! = NSLocalizedString("금요일" , comment: "")
        sat.text! = NSLocalizedString("토요일" , comment: "")
        sun.text! = NSLocalizedString("일요일" , comment: "")
        hol.text! = NSLocalizedString("공휴일" , comment: "")
        
        dutytimealert.text! = NSLocalizedString("진료시간은 변동될 수 있으므로, 119 또는 병의원에 확인 후 이용하세요." , comment: "")
        warnLabel.text! = NSLocalizedString("해당 병원은 등록된 외국인 환자 유치 의료기관이 아니기 때문에 초진만 가능합니다." , comment: "")
        
        subView?.changeCamera()
        let h_name = NSLocalizedString(hospital.h_name, comment: "")
        
        self.navigationItem.title = h_name
        self.h_name_label.text! = h_name
        self.h_addr_label.text! = NSLocalizedString(hospital.h_addr, comment: "")
        self.h_phone_label.text! = hospital.h_pnumber
        
        if(hospital.mon_dutytime_s != "-1" && hospital.mon_dutytime_s.count == 4){
            
            var starttime = hospital.mon_dutytime_s
            var finishtime = hospital.mon_dutytime_c
            starttime.insert(":", at: starttime.index(starttime.startIndex, offsetBy: 2))
            finishtime.insert(":", at: finishtime.index(finishtime.startIndex, offsetBy: 2))
            
            self.mon_label.text! = starttime + " ~ " + finishtime
            
        }else{
            
            self.mon_label.text! = NSLocalizedString("휴무" , comment: "")
        }
        
        if(hospital.tues_dutytime_s != "-1" && hospital.tues_dutytime_s.count == 4){
            
            var starttime = hospital.tues_dutytime_s
            var finishtime = hospital.tues_dutytime_c
            starttime.insert(":", at: starttime.index(starttime.startIndex, offsetBy: 2))
            finishtime.insert(":", at: finishtime.index(finishtime.startIndex, offsetBy: 2))
            
            self.tues_label.text! = starttime + " ~ " + finishtime
            
        }else{
            
            self.tues_label.text! = NSLocalizedString("휴무" , comment: "")
        }
        
        if(hospital.wed_dutytime_s != "-1" && hospital.wed_dutytime_s.count == 4){
            
            var starttime = hospital.wed_dutytime_s
            var finishtime = hospital.wed_dutytime_c
            starttime.insert(":", at: starttime.index(starttime.startIndex, offsetBy: 2))
            finishtime.insert(":", at: finishtime.index(finishtime.startIndex, offsetBy: 2))
            
            self.wed_label.text! = starttime + " ~ " + finishtime
            
        }else{
            
            self.wed_label.text! = NSLocalizedString("휴무" , comment: "")
        }
        
        if(hospital.thur_dutytime_s != "-1" && hospital.thur_dutytime_s.count == 4){
            
            var starttime = hospital.thur_dutytime_s
            var finishtime = hospital.thur_dutytime_c
            starttime.insert(":", at: starttime.index(starttime.startIndex, offsetBy: 2))
            finishtime.insert(":", at: finishtime.index(finishtime.startIndex, offsetBy: 2))
            
            self.thur_label.text! = starttime + " ~ " + finishtime
            
        }else{
            
            self.thur_label.text! = NSLocalizedString("휴무" , comment: "")
        }
        
        if(hospital.fri_dutytime_s != "-1" && hospital.fri_dutytime_s.count == 4){
            
            var starttime = hospital.fri_dutytime_s
            var finishtime = hospital.fri_dutytime_c
            starttime.insert(":", at: starttime.index(starttime.startIndex, offsetBy: 2))
            finishtime.insert(":", at: finishtime.index(finishtime.startIndex, offsetBy: 2))
            
            self.fri_label.text! = starttime + " ~ " + finishtime
            
        }else{
            
            self.fri_label.text! = NSLocalizedString("휴무" , comment: "")
        }
        
        if(hospital.sat_dutytime_s != "-1" && hospital.sat_dutytime_s.count == 4){
            
            var starttime = hospital.sat_dutytime_s
            var finishtime = hospital.sat_dutytime_c
            starttime.insert(":", at: starttime.index(starttime.startIndex, offsetBy: 2))
            finishtime.insert(":", at: finishtime.index(finishtime.startIndex, offsetBy: 2))
            
            self.sat_label.text! = starttime + " ~ " + finishtime
            
        }else{
            
            self.sat_label.text! = NSLocalizedString("휴무" , comment: "")
        }
        
        if(hospital.sun_dutytime_s != "-1" && hospital.sun_dutytime_s.count == 4){
            
            var starttime = hospital.sun_dutytime_s
            var finishtime = hospital.sun_dutytime_c
            starttime.insert(":", at: starttime.index(starttime.startIndex, offsetBy: 2))
            finishtime.insert(":", at: finishtime.index(finishtime.startIndex, offsetBy: 2))
            
            self.sun_label.text! = starttime + " ~ " + finishtime
            
        }else{
            
            self.sun_label.text! = NSLocalizedString("휴무" , comment: "")
        }
        
        if(hospital.holi_dutytime_s != "-1" && hospital.holi_dutytime_s.count == 4){
            
            var starttime = hospital.holi_dutytime_s
            var finishtime = hospital.holi_dutytime_c
            starttime.insert(":", at: starttime.index(starttime.startIndex, offsetBy: 2))
            finishtime.insert(":", at: finishtime.index(finishtime.startIndex, offsetBy: 2))
            
            self.holi_label.text! = starttime + " ~ " + finishtime
            
        }else{
            
            self.holi_label.text! = NSLocalizedString("휴무" , comment: "")
        }
        
        if(hospital.h_pid == "FOR"){
            // 라벨 보이게
            FreeDiagnose.isHidden = false
        } else if !hospital.forignHospitalCheck
        {
            warnIcon.isHidden = false
            warnText.isHidden = false
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        setupButtonUI()
    }
    
    @IBAction func FreeDiagnoseAction(_ sender: Any)
    {
        let diagnoseVC:MedicalTourism_Attractions = UIStoryboard(name: "Attractions", bundle: nil).instantiateViewController(withIdentifier: "Attractions") as! MedicalTourism_Attractions
        
        diagnoseVC.url = "http://health.bukgu.gwangju.kr/menu.es?mid=b10410010000"
        self.present(diagnoseVC, animated: true)
    }
    
    
    // 목적지 길안내 -  WGS84
    @IBAction func callKaKao(_ sender: Any) {
        
        guard  let hospital = detailHospital else{
            return
        }
        
        let destination = KNVLocation(name: hospital.h_name, x: hospital.h_longitude as! NSNumber, y: hospital.h_latitude as! NSNumber)
        let options = KNVOptions()
        options.coordType = KNVCoordType.WGS84
        let params = KNVParams(destination: destination, options: options)
        KNVNaviLauncher.shared().navigate(with: params) { (error) in
            self.handleError(error: error)
        }
    }
    
    func handleError(error: Error?) -> Void {
        if let error = error as NSError? {
//            print(error)
            let alert = UIAlertController(title: self.title!, message: error.localizedFailureReason, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "mapviewSegue" {
            //세그웨이의 목적지는 (형변환) 이 클래스의 변수에게  값 넣을 수 있다.           //선택된 값의 인덱스
            let detailmapviewVC = segue.destination as! DetailMapViewController
            detailmapviewVC.superView = self
            self.subView = detailmapviewVC
        }
    }
    
    fileprivate func setupButtonUI() {
        directionsButton.layer.cornerRadius = 5
        directionsButton.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        directionsButton.clipsToBounds = true
        
        forStudentButton.layer.cornerRadius = 5
        forStudentButton.layer.borderWidth = 0.0/UIScreen.main.nativeScale
        forStudentButton.clipsToBounds = true
    }
}
