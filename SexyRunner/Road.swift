//
//  Road.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit
import CoreData

class Road: NSManagedObject {
    
    @NSManaged var name: String
    @NSManaged var locations: NSOrderedSet
    @NSManaged var distance: NSNumber
    @NSManaged var info: String
    @NSManaged var photo: NSData
}