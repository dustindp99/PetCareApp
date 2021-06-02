//
//  PetEntity+CoreDataProperties.swift
//  PetCareApp
//
//  Created by Dustin on 11/27/20.
//  Copyright © 2020 Dustin Dekker-Parrent. All rights reserved.
//
//

import Foundation
import CoreData


public class PetEntity: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PetEntity> {
        return NSFetchRequest<PetEntity>(entityName: "PetEntity")
    }

    @NSManaged public var petNameData: String?
    @NSManaged public var petTypeData: String?
    @NSManaged public var petBreedData: String?
    @NSManaged public var petAgeData: Int32
    @NSManaged public var petWeightData: Double
    @NSManaged public var petImageData: Data?
    
    func set(petNameData: String, petTypeData: String, petBreedData: String, petAgeData: Int32,
             petWeightData: Double, petImageData: Data) {
        
        self.petNameData = petNameData
        self.petTypeData = petTypeData
        self.petBreedData = petBreedData
        self.petAgeData = petAgeData
        self.petWeightData = petWeightData
        self.petImageData = petImageData
        
    }

}
