//
//  SettingViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import Combine
import UIKit
import SnapKit
import Then

final class SettingViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bindViewModel()
    }

    private func bindViewModel() {
        self.viewModel.fetchCompletionPublihser
            .sink(receiveValue: { [weak self] in
                self?.tableView.reloadData()
            })
            .store(in: &self.cancellables)
    }

    private var cancellables = Set<AnyCancellable>()

    private let topBackgroundView = UIView(frame: .zero)
    private let tableView = UITableView(frame: .zero, style: .grouped)

    private let viewModel = SettingViewModel()
}

// MARK: - TableView DataSource
extension SettingViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRows
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(self.viewModel.cellType, for: indexPath) else {
            return UITableViewCell()
        }

        if let title = self.viewModel.titleForRow(indexPath.row) {
            cell.updateTitle(title)
        }

        cell.selectionStyle = .none
        return cell
    }
}

// MARK: - TableView Delegate
extension SettingViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        //
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let view = tableView.dequeueReusableHeaderFooterView(self.viewModel.headerType)  else { return nil }
        view.update()
        return view
    }
}

// MARK: - Setup
extension SettingViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTopBackgroundView()
        self.setupTableView()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black2
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.topBackgroundView)
            $0.addSubview(self.tableView)
        }
    }

    private func setupTopBackgroundView() {
        self.topBackgroundView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.top.leading.trailing.equalToSuperview()
        }

        self.topBackgroundView.do {
            $0.backgroundColor =  .gray3
        }
    }


    private func setupTableView() {
        self.tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.tableView.do {
            $0.contentInset = .zero
            $0.rowHeight = self.viewModel.cellHeight
            $0.sectionHeaderHeight = self.viewModel.headerHeight
            $0.sectionFooterHeight = .leastNonzeroMagnitude
            $0.separatorStyle = .none
            $0.backgroundColor = .clear
            $0.bounces = false
            $0.dataSource = self
            $0.delegate = self

            $0.register(cell: self.viewModel.cellType)
            $0.register(headerFooterView: self.viewModel.headerType)
        }
    }
}
