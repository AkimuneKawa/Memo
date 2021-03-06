//
//  MemoTextViewController.swift
//  Memo
//
//  Created by 河明宗 on 2019/04/02.
//  Copyright © 2019 Akimune Kawa. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then

final class MemoTextViewController: UIViewController { //TODO:
    //MARK: - Variables
    
    private var memo: Memo
    
    //MARK: - Views
    
    private let memoTextView: MemoTextView
    
    let memosManager: MemosManagerType
    
    //MARK: - Initializers
    
    init(memo: Memo, memosManager:MemosManagerType){
        self.memo = memo
        self.memosManager = memosManager
        self.memoTextView = MemoTextView()
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
    }
    
    override func willMove(toParent parent: UIViewController?) {
        super.willMove(toParent: parent)
        
        appendNewMemo(parent: parent)
        memoTextView.resignFirstResponder()
    }
    
    //MARK: - SetupMethods
    
    private func setupViews() {
        view.backgroundColor = .white
        
        navigationItem.title = memo.dateLastTouched.isEmpty ? "メモ追加" : "メモ編集"
        
        memoTextView.textView.text = memo.dateLastTouched.isEmpty ? "" : memo.content
        memoTextView.becomeFirstResponder()
        
        view.addSubview(memoTextView)
    }
    
    private func setupConstrains() {
        memoTextView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    //MARK: - Methods
    
    private func appendNewMemo(parent: UIViewController?) {
        if parent == nil && !memoTextView.textView.text.isEmpty{
            memo.content = memoTextView.textView.text
            memosManager.saveMemo(memo: memo)
        }
    }
}
