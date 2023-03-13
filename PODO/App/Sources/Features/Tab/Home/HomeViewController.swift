//
//  HomeViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

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

        let tableViewBackgroundView = UIView(frame: .zero)
        self.tableViewBackgroundView = tableViewBackgroundView
        self.view.addSubview(tableViewBackgroundView)

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
        self.tableViewBackgroundView?.snp.makeConstraints {
            $0.height.equalTo(254.0)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        self.tableViewBackgroundView?.do {
            $0.backgroundColor = .orange
        }
    }

    private func setupTableView() {
        self.tableView?.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.tableView?.do { view in
            view.contentInset = .zero
            view.sectionFooterHeight = .leastNonzeroMagnitude
            view.separatorStyle = .none
            view.backgroundColor = .clear
            view.dataSource = self
            view.delegate = self

            HomeViewModel.cellTypes.forEach   { view.register(cell: $0)             }
            HomeViewModel.headerTypes.forEach { view.register(headerFooterView: $0) }
        }
    }

    private var navigationView: UIView?
    private var titleLabel: UILabel?
    private var notificationButton: UIButton?
    private var tableViewBackgroundView: UIView?
    private var tableView: UITableView?

    private let viewModel = HomeViewModel()
}

extension HomeViewController: UITableViewDataSource {

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
        if let cell = cell as? HomeNewTableViewCell {
            let data = self.viewModel.dataForSection(indexPath.section)
            cell.delegate = self
            cell.updateData(data)
        } else if let cell = cell as? HomeHottestTableViewCell {
            let data = self.viewModel.dataForSection(indexPath.section)
            cell.delegate = self
            cell.updateData(data)
        } else if let cell = cell as? HomeInsightTableViewCell {
            guard let data = self.viewModel.dataForIndexPath(indexPath) else { return }
            cell.updateData(data)
        }
    }
}

extension HomeViewController: UITableViewDelegate {

    private func showLoginViewIfNeeded() {
        let viewController = SignInViewController()
        let navigationController = PortraitNavigationController(rootViewController: viewController)
        navigationController.modalPresentationStyle = .fullScreen
        navigationController.isNavigationBarHidden = true
        self.present(navigationController, animated: false)
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard self.viewModel.canSelectForSection(indexPath.section) else {
            self.showLoginViewIfNeeded()
            return
        }

        guard let data = self.viewModel.dataForIndexPath(indexPath) else { return }
        let viewController = ContentViewController(data: data)
        self.present(viewController, animated: true)
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
        self.configureHeaderView(view)
        return view
    }

    private func configureHeaderView(_ view: UITableViewHeaderFooterView) {
        if let view = view as? HomeInsightTableViewHeaderView {
            view.updateCategories(self.viewModel.categories, selectedCategory: self.viewModel.selectedCategory)
            view.delegate = self
        }
    }
}

extension HomeViewController: HomeTableViewCellDelegate {

    func homeTableViewCell(_ cell: UITableViewCell, didTapItem item: ArticleData, atIndex index: Int) {
        let viewController = ContentViewController(data: item)
        self.present(viewController, animated: true)
    }
}

extension HomeViewController: HomeInsightTableViewHeaderViewDelegate {

    func homeInsightTableViewHeaderView(_ view: HomeInsightTableViewHeaderView, didTapCategory tag: Int) {
        self.viewModel.updateSelectedCategory(tag)

        let section = HomeViewModel.SectionType.insight.rawValue
        let count = self.viewModel.dataForSection(HomeViewModel.SectionType.insight.rawValue).count

        var indexPaths: [IndexPath] = []
        for index in (0..<count) {
            indexPaths.append(IndexPath(row: index, section: section))
        }

        self.tableView?//.reloadRows(at: indexPaths, with: .automatic)
            .reloadSections(IndexSet(section...section), with: .none)
    }
}
