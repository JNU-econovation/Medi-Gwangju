//
//  selectDIVController+ButtonsUI.swift
//  MedicalGwangju
//
//  Created by Cory Kim on 16/07/2018.
//  Copyright © 2018 sol. All rights reserved.
//

import UIKit

extension selectDIVController {
    func setButtonsUI() {
        setBorder(selectButton: General)
        setBorder(selectButton: Dentist)
        setBorder(selectButton: Inter)
        setBorder(selectButton: Surgery)
        setBorder(selectButton: Orthopedics)
        setBorder(selectButton: Otorhinolaryngology)
        setBorder(selectButton: Urology)
        setBorder(selectButton: Dermatology)
        setBorder(selectButton: Plastic)
        setBorder(selectButton: Ophthalmology)
        setBorder(selectButton: Obstetrics)
        setBorder(selectButton: Clinic)
        setBorder(selectButton: Nursing)
        setBorder(selectButton: Public)
        setBorder(selectButton: Nursing)
        setBorder(selectButton: Etc)
    }
    
    private func setBorder(selectButton: UIButton) {
        selectButton.layer.borderColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.2).cgColor
        selectButton.layer.borderWidth = 0.3
    }
}
