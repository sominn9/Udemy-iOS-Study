//
//  Memo.swift
//  Todoey
//
//  Created by 신소민 on 2021/10/30.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation

struct Memo: Codable {
    var content: String = ""
    var isCheckmarked: Bool = false
}
