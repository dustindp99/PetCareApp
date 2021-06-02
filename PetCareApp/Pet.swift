//
//  Pet.swift
//  PetCareApp
//
//  Created by Dustin on 11/1/20.
//  Copyright © 2020 Dustin Dekker-Parrent. All rights reserved.
//

import Foundation

class Pet {
    var petName : String
    var petType : String
    var petBreed: String
    var petAge: Int32
    var petWeight: Double
    var petImage: Data
    
    
    init(petName: String, petType: String, petBreed: String, petAge: Int32, petWeight: Double, petImage: Data) {
        self.petName = petName
        self.petType = petType
        self.petBreed = petBreed
        self.petAge = petAge
        self.petWeight = petWeight
        self.petImage = petImage
    }
    
    func getPetName() -> String {
        return self.petName
    }
    
    func getPetType() -> String {
        return self.petType
    }
    
    func getPetBreed() -> String {
        return self.petBreed
    }
    
    func getPetAge() -> Int32 {
        return self.petAge
    }
    
    func getPetWeight() -> Double {
        return self.petWeight
    }
    
    func getPetImage() -> Data {
        return self.petImage
    }
}
