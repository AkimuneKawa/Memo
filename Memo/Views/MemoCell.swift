//
//  MemoCell.swift
//  Memo
//
//  Created by 河明宗 on 2019/04/02.
//  Copyright © 2019 Akimune Kawa. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then

final class MemoCell: UITableViewCell {
    struct Const {
        static let identifier: String = "MemoCell"
        static let cellHeight: CGFloat = 50
    }
    //MARK: - Views
    
    var contentLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 16)
        $0.textColor = .black
        $0.lineBreakMode = .byTruncatingTail
    }
    
    var dateLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 12)
        $0.textColor = .gray
        $0.lineBreakMode = .byTruncatingTail
    }
    
    //MARK: - Initializers
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SetupMethods
    
    private func setupViews() {
        contentView.backgroundColor = .white
        contentView.addSubview(contentLabel)
        contentView.addSubview(dateLabel)
    }
    
    private func setupConstraints() {
        contentLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.bottom.equalTo(contentView.snp.centerY).offset(-2)
            $0.right.lessThanOrEqualTo(-20)
        }
        dateLabel.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20)
            $0.top.equalTo(contentView.snp.centerY).offset(2)
            $0.right.lessThanOrEqualTo(-20)
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        contentLabel.text = nil
        dateLabel.text = nil
    }
    
    //MARK: - Methods
    
    func set (memo: Memo){
        contentLabel.text = memo.content
        dateLabel.text = memo.dateLastTouched
    }
    
}
