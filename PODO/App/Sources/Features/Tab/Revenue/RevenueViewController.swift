//
//  RevenueViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class RevenueViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTableView()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        let tableView = UITableView(frame: .zero, style: .grouped)
        self.tableView = tableView
        self.view.addSubview(tableView)
    }

    private func setupTableView() {
        self.tableView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.tableView?.do { view in
            view.backgroundColor = .clear
            view.contentInset = .zero
            view.contentInsetAdjustmentBehavior = .never
            view.sectionHeaderHeight = .leastNonzeroMagnitude
            view.sectionFooterHeight = .leastNonzeroMagnitude
            view.separatorStyle = .none
            view.dataSource = self
            view.delegate = self

            RevenueViewModel.cellTypes.forEach {
                view.register(cell: $0)
            }
        }
    }

    private var tableView: UITableView?

    private let viewModel = RevenueViewModel()
}

extension RevenueViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = self.viewModel.cellTypeForRow(indexPath.row) else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(cellType, for: indexPath)  else {
            return UITableViewCell()
        }

        self.configureCell(cell, atIndexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }

    private func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        if let cell = cell as? RevenueListTableViewCell {
        } else if let cell = cell as? RevenueExpertTableViewCell {
        }
    }
}

extension RevenueViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.viewModel.heightForRow(indexPath.row)
    }
}
