//
//  MemosManager.swift
//  Memo
//
//  Created by 河明宗 on 2019/04/02.
//  Copyright © 2019 Akimune Kawa. All rights reserved.
//

import Foundation
import Then

protocol MemosManagerType {
    func loadMemos() -> [Memo]
    func saveMemo(memo: Memo)
    func deleteMemo(id: String)
    func allDelete()
}

final class MemosManager: MemosManagerType{
    let userDefaults = UserDefaults.standard
    let userDefaultKey = "Memos"
    
    func loadMemos() -> [Memo] {
        var retMemos: [Memo] = []
        var unsortedMemos: Dictionary<String,[String]> = [:]
        if let tmpMemos = userDefaults.dictionary(forKey: userDefaultKey) as? Dictionary<String,[String]> {
            unsortedMemos = tmpMemos
        }
        
        let sortedMemos = unsortedMemos.sorted{ $0.1[1] > $1.1[1] }
        
        for ( key , value) in sortedMemos {
            var memo = Memo()
            memo.id = key
            memo.content = value[0]
            memo.dateLastTouched = value[1]
            
            retMemos.append(memo)
        }
        
        return retMemos
    }
    
    func saveMemo(memo: Memo) {
        var savedMemos: Dictionary<String,[String]> = [:]
        let dateLastTouched: String = DateFormatter.default.string(from: Date())
        
        if let tmpMemos = userDefaults.dictionary(forKey: userDefaultKey) as? Dictionary<String,[String]> {
            savedMemos = tmpMemos
        }
        
        savedMemos[memo.id] = [memo.content,dateLastTouched]
        
        userDefaults.set(savedMemos, forKey: userDefaultKey)
    }
    
    func deleteMemo(id: String) {
        let memos = loadMemos()
        allDelete()
        for memo in memos {
            if memo.id != id {
                saveMemo(memo: memo)
            }
        }
    }
    
    func allDelete() {
        userDefaults.removeObject(forKey: userDefaultKey)
    }
}
