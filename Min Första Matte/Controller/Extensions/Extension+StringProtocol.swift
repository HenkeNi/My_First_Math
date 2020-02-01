//
//  Extension+StringProtocol.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2020-02-01.
//  Copyright © 2020 Henrik Jangefelt Nilsson. All rights reserved.
//

import Foundation

extension StringProtocol {
    var firstLetterUppercased: String { prefix(1).uppercased() + dropFirst() }
}
