//
//  WarField.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/20.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit
import CoreData

class WarField: NSManagedObject {
    
    @NSManaged var locations: NSOrderedSet
    @NSManaged var info: String
    @NSManaged var photo: NSData
    @NSManaged var annotationLatitude: NSNumber
    @NSManaged var annotationLongitude: NSNumber
    @NSManaged var name: String
    @NSManaged var date: NSDate
    
}


