//
//  DebtEntry.swift
//  I Owe Money
//
//  Created by Kevin on 2017-05-26.
//  Copyright © 2017 Kevin. All rights reserved.
//

import Foundation
import CoreData

class DebtEntry: NSManagedObject {
    @NSManaged var name: String
    @NSManaged var amount: Double
    @NSManaged var due: Date
}
