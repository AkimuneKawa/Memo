//
//  MemoTextView.swift
//  Memo
//
//  Created by 河明宗 on 2019/04/02.
//  Copyright © 2019 Akimune Kawa. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then

final class memoTextView: UIView {
    struct Const {
        static let identifier = "MemoTextView"
    }
    //MARK: - Views
    
    var textView = UITextView()
    
    //MARK: - Initializers
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstrains()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupViews
    
    private func setupViews(){
        backgroundColor = .white
        textView.backgroundColor = .white
        
        addSubview(textView)
    }
    
    private func setupConstrains() {
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
}
