//
//  PetListViewController.swift
//  PetCareApp
//
//  Created by Dustin on 11/27/20.
//  Copyright © 2020 Dustin Dekker-Parrent. All rights reserved.
//

import UIKit
import CoreData

class PetListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var petList: PetList = PetList()
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    var fetchedResults = [PetEntity]()
    
    @IBOutlet weak var petTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petList.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = petTable.dequeueReusableCell(withIdentifier: "petCell", for: indexPath) as! PetTableViewCell
        
        let petItem = petList.getPetObject(indexPath.row)
        
        cell.petNameLabel.text = petItem.getPetName()
        cell.petTypeLabel.text = petItem.getPetType()
        cell.petImageView.image = UIImage(data: petItem.getPetImage())
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool
    {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath)
    {
        
        if(petList.deletePet(indexPath.row)){
            managedObjectContext.delete(fetchedResults[indexPath.row])
            
            fetchedResults.remove(at: indexPath.row)
            
            self.petTable.reloadData()
            
            do {
                try managedObjectContext.save()
            } catch {
                print("error saving deletion")
            }
            
            
        }
        
        
        
        
    }

    
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "Add Pet", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Name of the Pet Here"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Type of the Pet Here"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Breed of the Pet Here"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Age of the Pet Here"
        })
        
        alert.addTextField(configurationHandler: { textField in
            textField.placeholder = "Enter Weight of the Pet Here"
        })
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            if let name = alert.textFields?.first?.text, let type = alert.textFields?[1].text, let breed = alert.textFields?[2].text, let age = alert.textFields?[3].text, let weight = alert.textFields?[4].text {
                
                var newPet = Pet(petName: name, petType: type, petBreed: breed, petAge: Int32(age)!, petWeight: Double(weight)!, petImage: (UIImage(named: "dog")?.pngData())!)

                self.petList.addPet(newPet)
            
                self.petTable.reloadData()
                
                let ent = NSEntityDescription.entity(forEntityName: "PetEntity", in: self.managedObjectContext)
                
                let newItem = PetEntity(entity: ent!, insertInto: self.managedObjectContext)
                newItem.set(petNameData: name, petTypeData: type, petBreedData: breed, petAgeData: Int32(age)!, petWeightData: Double(weight)!, petImageData: (UIImage(named: "dog")?.pngData())!)
                
                self.fetchedResults.append(newItem)
                
                
                do {
                    try self.managedObjectContext.save()
                } catch _ {
                    print("error in saving")
                }
                
            }
            
        }))
        
        self.present(alert, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let selectedIndex: IndexPath = self.petTable.indexPath(for: sender as! UITableViewCell)!
        
        let pet = petList.getPetObject(selectedIndex.row)
        
        if segue.identifier == "detailView" {
            if let viewController: PetDetailViewController = segue.destination as? PetDetailViewController {
                
                viewController.pet = pet
                viewController.petList = petList
                viewController.selectedPetName = pet.getPetName()
                viewController.selectedPetBreed = pet.getPetBreed()
                viewController.selectedPetAge = pet.getPetAge()
                viewController.selectedPetWeight = pet.getPetWeight()
                viewController.selectedPetImage = pet.getPetImage()
                
            }
        }
    }
    
    @IBAction func fromDetailView(segue: UIStoryboardSegue) {
        if let viewController = segue.source as? PetDetailViewController {
            petList = viewController.petList
            fetchedResults = viewController.fetchedResults
            self.petTable.reloadData()
            
            
            
        }
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
