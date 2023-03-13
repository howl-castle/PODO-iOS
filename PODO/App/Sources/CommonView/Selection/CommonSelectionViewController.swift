//
//  CommonSelectionViewController.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import UIKit
import SnapKit
import Then

protocol CommonSelectionViewControllerDelegate: AnyObject {

    func commonSelectionViewController(_ viewController: CommonSelectionViewController, didSelectItem item: String)
    func commonSelectionViewControllerWillDisappear(viewController: CommonSelectionViewController)
}

final class CommonSelectionViewController: UIViewController {

    weak var delegate: CommonSelectionViewControllerDelegate?

    init(items: [String], title: String, subtitle: String) {
        self.items = items
        self.titleText = title
        self.subtitleText = subtitle

        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.showWithAnimate()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.commonSelectionViewControllerWillDisappear(viewController: self)
    }

    @objc private func didTapBackground(gestureRecognizer: UITapGestureRecognizer) {
        self.hideWithAnimate { _ in
            self.dismiss(animated: false)
        }
    }

    @objc private func didTapConfirmButton(_ sender: UIButton) {
        if let selectedIndex = self.selectedIndex,
            let item = self.items[safe: selectedIndex] {
            self.delegate?.commonSelectionViewController(self, didSelectItem: item)
        }

        self.hideWithAnimate { _ in
            self.dismiss(animated: false)
        }
    }

    private func showWithAnimate() {
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundView.alpha = 1.0

            self.containerView.snp.updateConstraints {
                $0.bottom.equalToSuperview()
            }
            self.view.layoutSubviews()
        }, completion: { _ in
            self.containerView.do {
                $0.layer.cornerRadius = 8.0
                $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            }
        })
    }

    private func hideWithAnimate(completion: @escaping (Bool) -> Void) {
        UIView.animate(withDuration: 0.4, animations: {
            self.backgroundView.alpha = 0.0

            self.containerView.snp.updateConstraints {
                $0.bottom.equalToSuperview().offset(self.height)
            }
            self.view.layoutSubviews()
        }, completion: completion)
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupTableView()
        self.setupConfirmButton()
        self.setupBackgroundView()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.backgroundView)
            $0.addSubview(self.containerView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.tableView)
            $0.addSubview(self.confirmButtonView)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.height.equalTo(self.height)
            $0.bottom.equalToSuperview().offset(self.height)
            $0.leading.trailing.equalToSuperview()
        }

        self.containerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = 10.0
            $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            let margin: CGFloat = 24.0
            $0.top.equalTo(self.containerView.snp.top).offset(margin)
            $0.leading.equalTo(self.containerView.snp.leading).offset(margin)
            $0.trailing.equalTo(self.containerView.snp.trailing).offset(-margin)
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.textColor = .white1
            $0.font = .systemFont(ofSize: 20.0, weight: .semibold)
            $0.text = self.titleText
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.subtitleLabel.do {
            $0.textColor = .white1
            $0.font = .systemFont(ofSize: 14.0)
            $0.text = self.subtitleText
        }
    }

    private func setupTableView() {
        self.tableView.snp.makeConstraints {
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(24.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.tableView.do {
            $0.backgroundColor = .clear
            $0.separatorStyle = .none
            $0.rowHeight = 52.0
            $0.sectionHeaderHeight = .leastNonzeroMagnitude
            $0.sectionFooterHeight = .leastNonzeroMagnitude
            $0.showsVerticalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
            $0.register(cell: CommonSelectionTableViewCell.self)
        }
    }

    private func setupConfirmButton() {
        self.confirmButtonView.snp.makeConstraints {
            let margin: CGFloat = 18.0
            $0.top.equalTo(self.tableView.snp.bottom).offset(margin * 2)
            $0.bottom.equalTo(self.containerView.safeAreaLayoutGuide.snp.bottom).offset(-margin)
            $0.leading.equalTo(self.containerView.snp.leading).offset(margin)
            $0.trailing.equalTo(self.containerView.snp.trailing).offset(-margin)
        }

        self.confirmButtonView.do {
            $0.setup(title: "Confirm")
            $0.button.addTarget(self, action: #selector(self.didTapConfirmButton), for: .touchUpInside)
            $0.updateUI(enable: self.selectedIndex != nil)
        }
    }

    private func setupBackgroundView() {
        self.backgroundView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.containerView.snp.top).offset(20.0)
        }

        self.backgroundView.do {
            $0.alpha = 0.0
            $0.backgroundColor = .black2Opacity80

            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.didTapBackground))
            $0.addGestureRecognizer(tapGesture)
        }
    }

    private var height: CGFloat {
        self.view.bounds.height * 2.0 / 3.0
    }

    private var selectedIndex: Int?

    private let items: [String]
    private let titleText: String
    private let subtitleText: String

    private let backgroundView = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let tableView = UITableView.init(frame: .zero, style: .grouped)
    private let confirmButtonView = CommonBottomButtonView(frame: .zero)
}

extension CommonSelectionViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(CommonSelectionTableViewCell.self, for: indexPath) else {
            return UITableViewCell(frame: .zero)
        }

        if let item = self.items[safe: indexPath.row] {
            cell.update(title: item, isSelected: indexPath.row == self.selectedIndex)
        }
        cell.selectionStyle = .none

        return cell
    }
}

extension CommonSelectionViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedIndex = indexPath.row
        self.tableView.reloadData()
        self.confirmButtonView.updateUI(enable: true)
    }
}
