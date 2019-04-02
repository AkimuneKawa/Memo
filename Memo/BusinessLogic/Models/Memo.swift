//
//  Memo.swift
//  Memo
//
//  Created by 河明宗 on 2019/04/01.
//  Copyright © 2019 Akimune Kawa. All rights reserved.
//

import Foundation

struct Memo {
    var id: String
    var content: String = ""
    var dateLastTouched: String = ""
    
    init() {
        id = String(Date().timeIntervalSince1970)
    }
}
