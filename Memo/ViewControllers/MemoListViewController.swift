//
//  MemoListViewController.swift
//  Memo
//
//  Created by 河明宗 on 2019/04/02.
//  Copyright © 2019 Akimune Kawa. All rights reserved.
//

import Foundation
import UIKit
import SnapKit
import Then

final class MemoListViewController: UIViewController {
    struct Const {
        static let footerHeight: CGFloat = 48
    }
    //MARK: - Variables
    
    var memos: [Memo] = []
    
    //MARK: - Views
    
    private let tableView = UITableView().then {
        $0.backgroundColor = .white
        $0.alwaysBounceVertical = true
        $0.rowHeight = MemoCell.Const.cellHeight
        $0.register(MemoCell.self , forCellReuseIdentifier: MemoCell.Const.identifier)
    }
    
    private let footerView = UIView().then {
        $0.layer.borderWidth = 0.5
        $0.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        $0.backgroundColor = UIColor(white: 0.98, alpha: 1)
    }
    
    private let newMemoButton = UIButton(type: .system).then {
        $0.setTitle("追加", for: .normal)
        $0.translatesAutoresizingMaskIntoConstraints = false
        $0.addTarget(self, action: #selector(didTapNewMemoButton), for: .touchUpInside)
    }
    
    //MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        setupConstrains()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadRequest()
    }
    
    //MARK: - SetupMethods
    
    private func setupViews() {
        navigationItem.title = "メモ一覧"
        view.backgroundColor = .white
        
        tableView.dataSource = self
        tableView.delegate = self
        
        view.addSubview(tableView)
        view.addSubview(footerView)
        footerView.addSubview(newMemoButton)
    }
    
    private func setupConstrains() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        footerView.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(Const.footerHeight)
        }
        newMemoButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.right.equalToSuperview().offset(-20)
        }
    }
    
    //MARK: - Methods
    
    private func reloadRequest() {
        let memosManager = MemosManager()
        memos = memosManager.loadMemos()
        
        tableView.reloadData()
    }
    
    @objc private func didTapNewMemoButton() {
        let memoTextViewController = MemoTextViewController(memo: Memo())
        navigationController?.pushViewController(memoTextViewController, animated: true)
    }
}

//MARK: - UITableViewDataSource

extension MemoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MemoCell.Const.identifier, for: indexPath)
        
        let memo = memos[indexPath.row]
        
        if let memoCell = cell as? MemoCell {
            memoCell.contentLabel.text = memo.content
            memoCell.dateLabel.text = memo.dateLastTouched
        }
        
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension MemoListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memoTextViewController = MemoTextViewController(memo: memos[indexPath.row])
        navigationController?.pushViewController(memoTextViewController, animated: true)
    }
}
