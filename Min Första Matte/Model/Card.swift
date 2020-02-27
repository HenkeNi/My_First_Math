//
//  Card.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-12-30.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

protocol Card {
    
    var imageName: String { get }
    var number: Int { get set }
    var isFlipped: Bool { get set }
    var labelText: String { get }
}

