//
//  ExpertViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import Combine
import UIKit
import SnapKit
import Then

final class ExpertViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
        self.bindViewModel()
    }

    private func bindViewModel() {
        self.viewModel.fetchCompletionPublihser
            .sink(receiveValue: { [weak self] in
                self?.tableView?.reloadData()
            })
            .store(in: &self.cancellables)
    }

    @objc private func didTapWriteButton(_ sneder: UIButton) {
        let viewController = ExpertWriteViewController()
        self.present(viewController, animated: true)
    }

    private var cancellables = Set<AnyCancellable>()
    
    private var navigationView: UIView?
    private var titleLabel: UILabel?
    private var subtitleLabel: UILabel?
    private var writeButton: UIButton?
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

        guard let data = self.viewModel.dataForIndexPath(indexPath) else { return }
        let viewController = ExpertDetailViewController(data: data)
        self.navigationController?.pushViewController(viewController, animated: true)
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
        self.setupTableViewBackgroundView()
        self.setupTableView()
        self.setupNavigationView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupWriteButton()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black2
        }
    }

    private func setupViewHierarchy() {
        let tableViewTopBackgroundView = UIView(frame: .zero)
        self.tableViewTopBackgroundView = tableViewTopBackgroundView
        self.view.addSubview(tableViewTopBackgroundView)

        let tableViewBottomBackgroundView = UIView(frame: .zero)
        self.tableViewBottomBackgroundView = tableViewBottomBackgroundView
        self.view.addSubview(tableViewBottomBackgroundView)

        let tableView = UITableView(frame: .zero, style: .grouped)
        self.tableView = tableView
        self.view.addSubview(tableView)

        let navigationView = UIView(frame: .zero)
        self.navigationView = navigationView
        self.view.addSubview(navigationView)

        let titleLabel = UILabel(frame: .zero)
        self.titleLabel = titleLabel
        self.navigationView?.addSubview(titleLabel)

        let subtitleLabel = UILabel(frame: .zero)
        self.subtitleLabel = subtitleLabel
        self.navigationView?.addSubview(subtitleLabel)

        let writeButton = UIButton(frame: .zero)
        self.writeButton = writeButton
        self.navigationView?.addSubview(writeButton)
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
        guard let navigationView = self.navigationView else { return }

        self.tableView?.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.bottom.leading.trailing.equalToSuperview()
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

    private func setupNavigationView() {
        self.navigationView?.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func setupTitleLabel() {
        guard let writeButton = self.writeButton else { return }

        self.titleLabel?.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.top.equalToSuperview().inset(20.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalTo(writeButton.snp.leading).offset(34.0)
        }

        self.titleLabel?.do {
            $0.font = .systemFont(ofSize: 20.0, weight: .bold)
            $0.textColor = .white1
            $0.text = "Expert"
        }
    }

    private func setupSubtitleLabel() {
        guard let titleLabel = self.titleLabel   else { return }

        self.subtitleLabel?.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8.0)
            $0.bottom.equalToSuperview().inset(11.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalTo(titleLabel.snp.trailing).offset(34.0)
        }

        self.subtitleLabel?.do {
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .gray1
            $0.text = "Check out the new answer!"
        }
    }

    private func setupWriteButton() {
        let size: CGFloat = 36.0
        self.writeButton?.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.writeButton?.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .orange
            $0.layer.cornerRadius = size / 2.0
            $0.setImage(UIImage(named: "Edit_Line"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapWriteButton), for: .touchUpInside)
        }
    }
}
