//
//  Onboarding.swift
//  SolarX
//
//  Created by Utkarsh Sharma on 22/07/21.
//

import UIKit
import CoreLocation

class Onboarding: UIViewController, CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource {
    
    var locationManager: CLLocationManager?

    @IBOutlet weak var incomePicker: UIPickerView!
    @IBOutlet weak var locbtn: UIButton!
    @IBOutlet weak var cambtn: UIButton!
    
    var pickerData: [String] = ["< 4 lakh INR pa", "4-12 lakh INR pa", ">12 lakh INR pa"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager = CLLocationManager()
        
        locbtn.setImage(UIImage(named: "LocRed.png"), for: .normal)
        
        self.incomePicker.delegate = self
        self.incomePicker.dataSource = self
        
        let status = CLLocationManager.authorizationStatus()
        switch status {
        case .notDetermined:
            locbtn.setImage(UIImage(named: "LocRed.png"), for: .normal)
//            locationManager?.requestWhenInUseAuthorization()
            return
        case .denied, .restricted:
            locbtn.setImage(UIImage(named: "LocRed.png"), for: .normal)
//            locationManager?.requestWhenInUseAuthorization()
            return
        case .authorizedAlways, .authorizedWhenInUse:
            locbtn.setImage(UIImage(named: "LocGreen.png"), for: .normal)
            break
        }
        
        locationManager?.delegate = self
    }
    
    @IBAction func locationBtn(_ sender: Any) {
        locationManager?.requestAlwaysAuthorization()
        locbtn.setImage(UIImage(named: "LocGreen.png"), for: .normal)
    }
    
    @IBAction func cameraBtn(_ sender: Any) {
        
    }
    
    @IBAction func proceedBtn(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "AddPanelVC") as! AddPanelVC
        self.present(nextViewController, animated:true, completion:nil)
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
        
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
}
