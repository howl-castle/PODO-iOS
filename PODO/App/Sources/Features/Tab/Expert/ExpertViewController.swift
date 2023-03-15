//
//  ExpertViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class ExpertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    private var navigationView: UIView?
    private var titleLabel: UILabel?
    private var notificationButton: UIButton?
    private var tableViewTopBackgroundView: UIView?
    private var tableViewBottomBackgroundView: UIView?
    private var tableView: UITableView?

    private let viewModel = ExpertViewModel()
}

// MARK: - TableView DataSource
extension ExpertViewController: UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = self.viewModel.cellTypeForSection(indexPath.section) else {
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
        if let cell = cell as? ExpertTrendingTableViewCell {
            let data = self.viewModel.dataForSection(indexPath.section)
            cell.updateData(data)
        } else if let cell = cell as? ExpertRecommendTableViewCell {
            guard let data = self.viewModel.dataForIndexPath(indexPath) else { return }
            cell.updateData(data)
        }
    }
}

// MARK: - TableView Delegate
extension ExpertViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.viewModel.heightForRowInSection(indexPath.section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.viewModel.heightForHeaderInSection(section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewType = self.viewModel.headerViewTypeForSection(section) else { return nil }
        guard let view = tableView.dequeueReusableHeaderFooterView(viewType)  else { return nil }
        return view
    }
}

// MARK: - Setup
extension ExpertViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupNavigationView()
        self.setupTitleLabel()
        self.setupNotificationButton()
        self.setupTableView()
        self.setupTableViewBackgroundView()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black2
        }
    }

    private func setupViewHierarchy() {
        /*
        let navigationView = UIView(frame: .zero)
        self.navigationView = navigationView
        self.view.addSubview(navigationView)

        let titleLabel = UILabel(frame: .zero)
        self.titleLabel = titleLabel
        self.view.addSubview(titleLabel)

        let notificationButton = UIButton(frame: .zero)
        self.notificationButton = notificationButton
        self.view.addSubview(notificationButton)
         */

        let tableViewTopBackgroundView = UIView(frame: .zero)
        self.tableViewTopBackgroundView = tableViewTopBackgroundView
        self.view.addSubview(tableViewTopBackgroundView)

        let tableViewBottomBackgroundView = UIView(frame: .zero)
        self.tableViewBottomBackgroundView = tableViewBottomBackgroundView
        self.view.addSubview(tableViewBottomBackgroundView)

        let tableView = UITableView(frame: .zero, style: .grouped)
        self.tableView = tableView
        self.view.addSubview(tableView)
    }

    private func setupNavigationView() {
    }

    private func setupTitleLabel() {
    }

    private func setupNotificationButton() {
    }

    private func setupTableViewBackgroundView() {
        self.tableViewTopBackgroundView?.snp.makeConstraints {
            $0.height.equalTo(self.view.bounds.height / 2.0)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        self.tableViewTopBackgroundView?.do {
            $0.backgroundColor = .black2
        }

        self.tableViewBottomBackgroundView?.snp.makeConstraints {
            $0.height.equalTo(self.view.bounds.height / 2.0)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        self.tableViewBottomBackgroundView?.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupTableView() {
        self.tableView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.tableView?.do { view in
            view.contentInset = .zero
            // UIEdgeInsets(top: 44.0, left: .zero, bottom: .zero, right: .zero)
            view.sectionFooterHeight = .leastNonzeroMagnitude
            view.separatorStyle = .none
            view.backgroundColor = .clear
            view.dataSource = self
            view.delegate = self

            ExpertViewModel.cellTypes.forEach   { view.register(cell: $0)             }
            ExpertViewModel.headerTypes.forEach { view.register(headerFooterView: $0) }
        }
    }
}
