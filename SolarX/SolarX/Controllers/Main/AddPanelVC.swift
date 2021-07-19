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
                        guard let costModelOutput = try? costModel.prediction(Total_Roof_Top_Area__in_Sq__m__: supremeArea) else {
                            fatalError("Unexpected runtime error.")
                        }
                        
                        let cost = costModelOutput.Installation_Cost
                        
                        globalInstallation = globalInstallation + cost.rounded(toPlaces: 2)
                        localCost = Int(cost.rounded(toPlaces: 2))
                        
                        // Lifetime CO2 Mitigation Model Prediction
                        guard let co2ModelPred = try? co2Model.prediction(Total_Roof_Top_Area__in_Sq__m__: supremeArea, Average_Solar_Irridation__W_sq_m_: irridation) else {
                            fatalError("Unexpected runtime error.")
                        }
                        
                        let co2Mitigation = co2ModelPred.Lifetime_CO2_Mitigation__mt_
                        
                        globalCO2Mitigation = globalCO2Mitigation + co2Mitigation.rounded(toPlaces: 2)
                        
                        // Monthly Savings Model Prediction
                        guard let monthlySavingsPrediction = try? monthlySavingsModel.prediction(Total_Roof_Top_Area__in_Sq__m__: supremeArea, Average_Solar_Irridation__W_sq_m_: irridation) else {
                            fatalError("Unexpected runtime error.")
                        }
                        
                        let monthlySavings = monthlySavingsPrediction.Monthly_Savings
                        
                        globalCostSaving = globalCostSaving + monthlySavings.rounded(toPlaces: 2)
                    }
                    
                    self.showSimpleActionSheet(controller: self, localCost: localCost)
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
                        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
                        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "OverviewVC") as! OverviewVC
                        nextViewController.modalPresentationStyle = .fullScreen
                        self.present(nextViewController, animated:true, completion:nil)
                    })
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
    
    
    func showSimpleActionSheet(controller: UIViewController, localCost: Int) {
            let alert = UIAlertController(title: "Yay!", message: "Welcome to the green revolution with SolarX. Your estimated instalation cost is \(localCost). You can save an average of Rs. 16000 with the recommended subsidy - AJAY.", preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "AJAY Scheme", style: .default, handler: { (_) in
                print("User click Approve button")
            }))

            alert.addAction(UIAlertAction(title: "Explore more subsidies", style: .default, handler: { (_) in
                print("User click Edit button")
            }))

            alert.addAction(UIAlertAction(title: "Proceed without subsidy", style: .destructive, handler: { (_) in
                print("User click Delete button")
            }))

            alert.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: { (_) in
                print("User click Dismiss button")
            }))

            self.present(alert, animated: true, completion: {
                print("completion block")
            })
        }
    
}
