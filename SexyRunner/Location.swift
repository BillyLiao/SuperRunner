//
//  Location.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit
import CoreData

class Location: NSManagedObject {
    
    @NSManaged var timestamp: NSDate?
    @NSManaged var latitude: NSNumber
    @NSManaged var longtitude: NSNumber
    @NSManaged var run: NSManagedObject
    
}
