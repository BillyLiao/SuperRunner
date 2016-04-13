//
//  Run.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/13.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit
import CoreData

class Run: NSManagedObject {
    
    @NSManaged var duration: NSNumber
    @NSManaged var distance: NSNumber
    @NSManaged var timestamp: NSDate
    @NSManaged var locations: NSOrderedSet

}

