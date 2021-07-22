//
//  AddPanelVC.swift
//  SolarX
//
//  Created by Utkarsh Sharma on 13/07/21.
//

import UIKit
import SceneKit
import ARKit
import CDAlertView
import SVProgressHUD
import CoreML
import SAConfettiView

class AddPanelVC: UIViewController {

    var percentageLabel: UITextField!
    var areaLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func augmentedRealityBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func mapBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func manualEntryPressed(_ sender: Any) {
        displayForm(message: "Please enter your roof area and percentage usable for solar installation")
    }
    
    @IBAction func cancelButtonPressed(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
        nextViewController.modalPresentationStyle = .fullScreen
        self.present(nextViewController, animated:false, completion:nil)
    }
    
    func displayForm(message:String){
            var localCost = 0
        
            //create alert
            let alert = UIAlertController(title: "Installation Cost Estimator", message: message, preferredStyle: .alert)
            
            //create cancel button
            let cancelAction = UIAlertAction(title: "Cancel" , style: .cancel)
            
            //create save button
            let saveAction = UIAlertAction(title: "Submit", style: .default) { (action) -> Void in
               //validation logic goes here
                if((self.percentageLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!){
                    //if this code is run, that mean at least of the fields doesn't have value
                    self.percentageLabel.text = ""
                    
                    self.displayForm(message: "One of the values entered was invalid. Please enter accurate information.")
                }
                
                if((self.areaLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)!){
                    //if this code is run, that mean at least of the fields doesn't have value
                    self.areaLabel.text = ""
                    
                    self.displayForm(message: "One of the values entered was invalid. Please enter accurate information.")
                }
                
                DispatchQueue.main.async {
                    percentage = Double(self.percentageLabel.text!)!
                    supremeArea = Double(self.areaLabel.text!)!

                    DispatchQueue.main.async {
                        
                        // Import custom trained CoreML models
                        let costModel = InstallationCost()
                        let co2Model = LifetimeCO2()
                        let monthlySavingsModel = MonthySavings()
                        
                        let irridation = 1046.26
                        
                        supremeArea = (percentage * supremeArea)/100
                        print(supremeArea)
                        
                        // Installation Cost Model Prediction
                        guard let costModelOutput = try? costModel.prediction(Roof_Area: supremeArea) else {
                            fatalError("Unexpected runtime error.")
                        }
                        
                        let cost = costModelOutput.Installation_Cost
                        
                        globalInstallation = globalInstallation + cost.rounded(toPlaces: 2)
                        print(cost)
                        
                        // Lifetime CO2 Mitigation Model Prediction
                        guard let co2ModelPred = try? co2Model.prediction(Roof_Area: supremeArea, Average_Solar_Irridation__W_sq_m_: irridation) else {
                            fatalError("Unexpected runtime error.")
                        }
                        
                        let co2Mitigation = co2ModelPred.Lifetime_CO2_Mitigation__mt_
                        
                        globalCO2Mitigation = globalCO2Mitigation + co2Mitigation.rounded(toPlaces: 2)
                        
                        // Monthly Savings Model Prediction
                        guard let monthlySavingsPrediction = try? monthlySavingsModel.prediction(Roof_Area: supremeArea, Average_Solar_Irridation__W_sq_m_: irridation) else {
                            fatalError("Unexpected runtime error.")
                        }
                        
                        let monthlySavings = monthlySavingsPrediction.Monthly_Savings
                        
                        globalCostSaving = globalCostSaving + monthlySavings.rounded(toPlaces: 2)
                        
                        let confettiView = SAConfettiView(frame: self.view.bounds)
                        self.view.addSubview(confettiView)

                        confettiView.startConfetti()
                        
                        let alert = CDAlertView(title: "Yay!", message: "Welcome to the green revolution with SolarX. Your estimated instalation cost is Rs. \(Int(cost)). You can save an average of Rs. 16000 with the recommended subsidy - GBI.", type: .success)
                        let doneAction = CDAlertViewAction(title: "Got it! 🌞")
                        alert.add(action: doneAction)
                        alert.show()
                        
                        let seconds = 5.0
                        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
                            self.showSimpleActionSheet(controller: self, localCost: Int(cost), savings: Int(monthlySavings), co2: Int(co2Mitigation))
                            confettiView.stopConfetti()
                        }
                       
                    }
                    
                }
                
            }
            
            //add button to alert
            alert.addAction(cancelAction)
            alert.addAction(saveAction)
            
            alert.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "Total roof area (sqm)"
                textField.keyboardType = .decimalPad
                self.areaLabel = textField
            })
        
            alert.addTextField(configurationHandler: {(textField: UITextField!) in
                textField.placeholder = "What percentage will be in use?"
                textField.keyboardType = .decimalPad
                self.percentageLabel = textField
            })
            
            self.present(alert, animated: true, completion: nil)
        }
    
    
    func showSimpleActionSheet(controller: UIViewController, localCost: Int, savings: Int, co2: Int) {
            let mes = """
            Installation cost: Rs. \(localCost)
            Expected monthly savings: Rs. \(savings)
            Lifetime CO2 Mitigation: \(co2) mt
            """
            let alert = UIAlertController(title: "Savings Summary", message: mes, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "GBI Scheme", style: .default, handler: { (_) in
                subsidyNumber = 0
                if let url = URL(string: "https://www.tatapower-ddl.com/solar-rooftop/register"),
                    UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url, options: [:])
                }
            }))

            alert.addAction(UIAlertAction(title: "Explore more subsidies", style: .default, handler: { (_) in
                let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                let nextViewController = storyBoard.instantiateViewController(withIdentifier: "SubsidiesVC") as! SubsidiesVC
                nextViewController.modalPresentationStyle = .fullScreen
                self.present(nextViewController, animated:true, completion:nil)
            }))

            alert.addAction(UIAlertAction(title: "Proceed without subsidy", style: .destructive, handler: { (_) in
                
            }))

            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
                
            }))

            self.present(alert, animated: true, completion: {
                
            })
        }
    
}
