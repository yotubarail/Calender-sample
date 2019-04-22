//
//  Event.swift
//  test
//
//  Created by 滝浪翔太 on 2019/04/08.
//  Copyright © 2019 滝浪翔太. All rights reserved.
//

import Foundation
import RealmSwift

class Event: Object {
    @objc dynamic var date: String = ""
    @objc dynamic var event: String = ""
}
