//
//  PetDetailViewController.swift
//  PetCareApp
//
//  Created by Dustin on 11/1/20.
//  Copyright © 2020 Dustin Dekker-Parrent. All rights reserved.
//

import UIKit
import CoreData

class PetDetailViewController: UIViewController {

    
    var selectedPetName:String?
    var selectedPetBreed:String?
    var selectedPetAge:Int32?
    var selectedPetWeight:Double?
    var selectedPetImage:Data?
    var petList: PetList = PetList()
    var pet:Pet?
    var fetchedResults = [PetEntity]()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var petNameLabel: UILabel!
    @IBOutlet weak var petBreedLabel: UILabel!
    @IBOutlet weak var petAgeLabel: UILabel!
    @IBOutlet weak var petWeightLabel: UILabel!
    @IBOutlet weak var petImage: UIImageView!
    @IBOutlet weak var newAgeTextBox: UITextField!
    @IBOutlet weak var newWeigthTextBox: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.petNameLabel.text = selectedPetName
        self.petBreedLabel.text = selectedPetBreed
        self.petAgeLabel.text = String(selectedPetAge!)
        self.petWeightLabel.text = String(selectedPetWeight!)
        let image = UIImage(data: selectedPetImage!)
        self.petImage.image = image
        fetchCoreDataEntities()
        // Do any additional setup after loading the view.
    }
    
    func fetchCoreDataEntities() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "PetEntity")
        fetchedResults = ((try? managedObjectContext.fetch(fetchRequest)) as? [PetEntity])!
        
        petList.removeAll()
        
        for entity in fetchedResults {
            if let petName = entity.petNameData, let petType = entity.petTypeData, let petBreed = entity.petBreedData, let petImage = entity.petImageData {
                petList.addPet(Pet(petName: petName, petType: petType, petBreed: petBreed, petAge: entity.petAgeData, petWeight: entity.petWeightData, petImage: petImage))
            }
        }
    }
    
    @IBAction func updateAge(_ sender: Any) {
        let newAge:Int32? = Int32(newAgeTextBox.text!)
        
        newAgeTextBox.text = ""
        let indexOfPet = petList.indexOfPet(pet!)
        
        if indexOfPet > -1 && newAge != nil{
            petList.changePetAge(indexOfPet, newAge!)
            fetchedResults[indexOfPet].petAgeData = newAge!
            petAgeLabel.text = "\(newAge!)"
        }
        
        
        do {
            try self.managedObjectContext.save()
        } catch _ {
            print("error in saving")
        }
        
    }
    
    @IBAction func updateWeight(_ sender: Any) {
        let newWeight:Double? = Double(newWeigthTextBox.text!)
        
        newWeigthTextBox.text = ""
        let indexOfPet = petList.indexOfPet(pet!)
        
        if indexOfPet > -1  && newWeight != nil{
            petList.changePetWeight(indexOfPet, newWeight!)
            fetchedResults[indexOfPet].petWeightData = newWeight!
            petWeightLabel.text = "\(newWeight!)"
        }
        
        do {
            try self.managedObjectContext.save()
        } catch _ {
            print("error in saving")
        }

    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
            
        if segue.identifier == "parkSegue" {
            if let viewController: ParkViewController = segue.destination as? ParkViewController {
                    
                }
            }
        else if segue.identifier == "weatherSegue" {
            if let viewController: WeatherViewController = segue.destination as? WeatherViewController {
                
            }
        }
    
    }
    
    @IBAction func fromPetFoodView(segue: UIStoryboardSegue) {
        
    }
    
    @IBAction func fromMapView(segue: UIStoryboardSegue) {
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
