//
//  List.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-03-18.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

struct List<T> {
    
    var listItems = [T]()
    
    mutating func add(item: T) {
        listItems.append(item)
    }
    
}

extension List where T: Score {
    
}
