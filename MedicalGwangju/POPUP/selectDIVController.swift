//
//  selectDIVController.swift
//  MedicalGwangju
//
//  Created by 조은솔 on 2018. 7. 12..
//  Copyright © 2018년 sol. All rights reserved.
//

import UIKit

class selectDIVController: UIViewController {
    
    var delegate: MapViewController?
    
    @IBOutlet weak var General: UIButton!
    @IBOutlet weak var Dentist: UIButton!
    @IBOutlet weak var Inter: UIButton!
    @IBOutlet weak var Surgery: UIButton!
    @IBOutlet weak var Orthopedics: UIButton!
    @IBOutlet weak var Otorhinolaryngology: UIButton!
    @IBOutlet weak var Urology: UIButton!
    @IBOutlet weak var Dermatology: UIButton!
    @IBOutlet weak var Plastic: UIButton!
    @IBOutlet weak var Ophthalmology: UIButton!
    @IBOutlet weak var Obstetrics: UIButton!
    @IBOutlet weak var Clinic: UIButton!
    @IBOutlet weak var Nursing: UIButton!
    @IBOutlet weak var Public: UIButton!
    @IBOutlet weak var Etc: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        backButton.setTitle(NSLocalizedString("뒤로가기", comment: ""), for: .normal)
        
        General.setTitle(NSLocalizedString("일반의원/종합", comment: ""), for: .normal)
        Dentist.setTitle(NSLocalizedString("치과", comment: ""), for: .normal)
        Inter.setTitle(NSLocalizedString("내과", comment: ""), for: .normal)
        Surgery.setTitle(NSLocalizedString("외과", comment: ""), for: .normal)
        Orthopedics.setTitle(NSLocalizedString("정형외과", comment: ""), for: .normal)
        Otorhinolaryngology.setTitle(NSLocalizedString("이비인후과", comment: ""), for: .normal)
        Urology.setTitle(NSLocalizedString("비뇨기과", comment: ""), for: .normal)
        Dermatology.setTitle(NSLocalizedString("피부과", comment: ""), for: .normal)
        Plastic.setTitle(NSLocalizedString("성형외과", comment: ""), for: .normal)
        Ophthalmology.setTitle(NSLocalizedString("안과", comment: ""), for: .normal)
        Obstetrics.setTitle(NSLocalizedString("산부인과", comment: ""), for: .normal)
        Clinic.setTitle(NSLocalizedString("한의원", comment: ""), for: .normal)
        Nursing.setTitle(NSLocalizedString("요양병원", comment: ""), for: .normal)
        Public.setTitle(NSLocalizedString("보건소", comment: ""), for: .normal)
        Etc.setTitle(NSLocalizedString("기타", comment: ""), for: .normal)
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        setButtonsUI()
    }
    
    @IBAction func back(_ sender: Any) {
        
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //일반의원, 종합
    @IBAction func GeneralSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "A")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //치과
    @IBAction func DentistSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "M")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //내과
    @IBAction func InternalSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "F")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //외과
    @IBAction func SurgerySelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "J")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //정형외과
    @IBAction func OrthopedicsSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "K")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //이비인후과
    @IBAction func OtorhinolaryngologySelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "L")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //비뇨기과
    @IBAction func UrologySelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "O")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //피부과
    @IBAction func DermatologySelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "Q")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //성형외과
    @IBAction func PlasticSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "P")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //안과
    @IBAction func OphthalmologySelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "S")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //한의원
    @IBAction func ClinicSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "E")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //산부인과
    @IBAction func ObstetricsSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "T")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //요양병원
    @IBAction func NursingSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "D")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //보건소
    @IBAction func PublicSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "R")
        self.presentingViewController?.dismiss(animated: true)
    }
    
    //기타
    @IBAction func EtcSelect(_ sender: Any) {
        
        self.delegate?.subView?.changeDIV(DIVcode: "I")
        self.presentingViewController?.dismiss(animated: true)
    }
}
