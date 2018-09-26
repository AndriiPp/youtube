//
//  Video.swift
//  youtube
//
//  Created by Andrii Pyvovarov on 19.04.18.
//  Copyright © 2018 Andrii Pyvovarov. All rights reserved.
//

import UIKit

class Video : NSObject {
    var thumbnailImageName : String?
    var title : String?
    var numberOfViews : NSNumber?
    var uploadDate : NSDate?
    var channel : Channel?
}

class Channel: NSObject {
    var name : String?
    var profileImageName : String?
}
