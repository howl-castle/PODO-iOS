//
//  ExpertDetailViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/24.
//

import UIKit
import SnapKit
import Then

final class ExpertDetailViewController: UIViewController {

    init(data: QuestionData) {
        self.viewModel = ExpertDetailViewModel(data: data)
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
        self.hidesBottomBarWhenPushed = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    @objc private func didTapBackButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc private func didTapMoreButton(_ sender: UIButton) {
    }

    private var navigationView: UIView?
    private var backButton: UIButton?
    private var moreButton: UIButton?
    private var tableViewTopBackgroundView: UIView?
    private var tableViewBottomBackgroundView: UIView?
    private var tableView: UITableView?

    private let viewModel: ExpertDetailViewModel
}

// MARK: - TableView DataSource
extension ExpertDetailViewController: UITableViewDataSource {

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
    }
}

// MARK: - TableView Delegate
extension ExpertDetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
}

// MARK: - Setup
extension ExpertDetailViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTableViewBackgroundView()
        self.setupTableView()
        self.setupNavigationView()
        self.setupBackButton()
        self.setupMoreButton()
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

        let backButton = UIButton(frame: .zero)
        self.backButton = backButton
        self.navigationView?.addSubview(backButton)

        let moreButton = UIButton(frame: .zero)
        self.moreButton = moreButton
        self.navigationView?.addSubview(moreButton)
    }

    private func setupNavigationView() {
        self.navigationView?.snp.makeConstraints {
            $0.height.equalTo(44.0)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func setupBackButton() {
        guard let backButton = self.backButton else { return }

        backButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(backButton.snp.height).multipliedBy(1.0)
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.0)
        }

        backButton.do {
            $0.setImage(UIImage(named: "Left"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapBackButton), for: .touchUpInside)
        }
    }

    private func setupMoreButton() {
        guard let moreButton = self.moreButton else { return }

        moreButton.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.width.equalTo(moreButton.snp.height).multipliedBy(1.0)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20.0)
        }

        moreButton.do {
            $0.setImage(UIImage(named: "More"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapMoreButton), for: .touchUpInside)
        }
    }

    private func setupTableViewBackgroundView() {
        self.tableViewTopBackgroundView?.snp.makeConstraints {
            $0.height.equalTo(self.view.bounds.height / 3.0)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        self.tableViewTopBackgroundView?.do {
            $0.backgroundColor = .black1
        }

        self.tableViewBottomBackgroundView?.snp.makeConstraints {
            guard let tableViewTopBackgroundView = self.tableViewTopBackgroundView else { return }
            $0.top.equalTo(tableViewTopBackgroundView.snp.bottom)
            $0.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        self.tableViewBottomBackgroundView?.do {
            $0.backgroundColor = .black2
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
            view.rowHeight = 170.0//UITableView.automaticDimension
            view.sectionHeaderHeight = .leastNonzeroMagnitude
            view.sectionFooterHeight = .leastNonzeroMagnitude
            view.separatorStyle = .none
            view.backgroundColor = .clear
            view.dataSource = self
            view.delegate = self

            ExpertDetailViewModel.cellTypes.forEach { view.register(cell: $0) }
        }
    }
}

