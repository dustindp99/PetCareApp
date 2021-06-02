//
//  PetList.swift
//  PetCareApp
//
//  Created by Dustin on 11/1/20.
//  Copyright © 2020 Dustin Dekker-Parrent. All rights reserved.
//

import Foundation

class PetList {
    
    var currentPet: Int = 0
    var numberOfPets: Int = 0
    var petList: [Pet] = [Pet]()
    
    func getCount() -> Int {
        return petList.count
    }
    
    func addPet(_ newPet: Pet) {
        petList.append(newPet)
        numberOfPets += 1
    }
    
    func deletePet(_ index: Int) -> Bool {
        if (numberOfPets != 0) {
            petList.remove(at: index)
            numberOfPets -= 1
            return true
        }
        return false
    }
    
    func indexOfPet(_ searchedPet: Pet) -> Int {
        var index = 0
        for pet in petList {
            if pet.petName == searchedPet.petName && pet.petType == searchedPet.petType && pet.petBreed == searchedPet.petBreed {
                return index
            }
            index += 1
        }
        return -1
    }
    
    func changePetAge(_ index: Int, _ age: Int32) {
        petList[index].petAge = age
    }
    
    func changePetWeight(_ index: Int, _ weight: Double) {
        petList[index].petWeight = weight
    }
    
    func removeAll() {
        currentPet = 0
        numberOfPets = 0
        petList.removeAll()
    }
    
    func getPetObject(_ index: Int) -> Pet {
        return petList[index]
    }
}
