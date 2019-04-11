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
    
    private var memos: [Memo] = []
    
    private let memosManager: MemosManagerType
    
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
    
    //MARK: - Initializers
    
    init(memosManager:MemosManagerType){
        self.memosManager = memosManager
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        reloadRequest()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        setEditing(false, animated: true)
    }
    
    //MARK: - SetupMethods
    
    private func setupViews() {
        navigationItem.title = "メモ一覧"
        navigationItem.rightBarButtonItem = editButtonItem
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
        memos = memosManager.loadMemos()
        
        tableView.reloadData()
    }
    
    @objc private func didTapNewMemoButton() {
        let memoTextViewController = MemoTextViewController(memo: Memo(), memosManager: memosManager)
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
            memoCell.set(memo: memo)
        }
        
        return cell
    }
    
    
}

//MARK: - UITableViewDelegate

extension MemoListViewController: UITableViewDelegate, UISearchBarDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memoTextViewController = MemoTextViewController(memo: memos[indexPath.row], memosManager: memosManager)
        navigationController?.pushViewController(memoTextViewController, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.isEditing = editing
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            memosManager.deleteMemo(id: memos[indexPath.row].id)
            memos.remove(at: indexPath.row)
            
            tableView.deleteRows(at: [indexPath], with: .fade)
        case .none, .insert:
            break
        }
    }
}
