//
//  Formatter.swift
//  Memo
//
//  Created by 河明宗 on 2019/04/02.
//  Copyright © 2019 Akimune Kawa. All rights reserved.
//

import Foundation
import Then

extension DateFormatter {
    static let `default` = DateFormatter().then {
        $0.locale = Locale.current
        $0.dateStyle = .short
        $0.timeStyle = .short
    }
}
