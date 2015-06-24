//
//  Contacts.swift
//  CoreDataDemo
//
//  Created by Nisha Sowdri NM on 24/06/2015.
//  Copyright (c) 2015 appi5. All rights reserved.
//

import Foundation
import CoreData

class Contacts: NSManagedObject {

    @NSManaged var address: String
    @NSManaged var phone: String
    @NSManaged var name: String

}
