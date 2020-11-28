//
//  List+CoreDataProperties.swift
//  ListOfNames
//
//  Created by Łukasz Rajczewski on 28/11/2020.
//
//

import Foundation
import CoreData


extension List {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<List> {
        return NSFetchRequest<List>(entityName: "List")
    }

    @NSManaged public var name: String?

}

extension List : Identifiable {

}
