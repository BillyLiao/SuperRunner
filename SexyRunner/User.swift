//
//  User.swift
//  SexyRunner
//
//  Created by 廖慶麟 on 2016/3/24.
//  Copyright © 2016年 廖慶麟. All rights reserved.
//

import UIKit
import CoreData

class User: NSManagedObject{
    
    @NSManaged var tribe: String!
    @NSManaged var tribePhoto: NSData!
}

