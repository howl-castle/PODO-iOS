//
//  RevenueHeaderTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/03/05.
//

import UIKit
import SnapKit
import Then

final class RevenueHeaderTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(_ data: Double) {
        self.balanceCountLabel.text = "\(data)"
    }

    private let titleLabel = UILabel(frame: .zero)
    private let balanceLabel = UILabel(frame: .zero)
    private let balanceCountLabel = UILabel(frame: .zero)
    private let doraLabel = UILabel(frame: .zero)
    private let detailButtonContainerView = UIView(frame: .zero)
    private let detailButton = UIButton(frame: .zero)
    private let detailButtonLabel = UILabel(frame: .zero)
}

// MARK: - Setup
extension RevenueHeaderTableViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupBalanceLabel()
        self.setupBalanceCountLabel()
        self.setupDoraLabel()
        self.setupDetailButtonContainerView()
        self.setupDetailButton()
        self.setupDetailButtonLabel()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.balanceLabel)
            $0.addSubview(self.balanceCountLabel)
            $0.addSubview(self.doraLabel)
            $0.addSubview(self.detailButtonContainerView)
        }

        self.detailButtonContainerView.do {
            $0.addSubview(self.detailButton)
            $0.addSubview(self.detailButtonLabel)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.top.equalToSuperview().inset(35.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(-20.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 20.0, weight: .bold)
            $0.textColor = .white1
            $0.text = "My Revenue"
        }
    }

    private func setupBalanceLabel() {
        self.balanceLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(-20.0)
        }

        self.balanceLabel.do {
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .gray1
            $0.text = "Total Balance"
        }
    }

    private func setupBalanceCountLabel() {
        self.balanceCountLabel.snp.makeConstraints {
            $0.height.equalTo(31.0)
            $0.top.equalTo(self.balanceLabel.snp.bottom).offset(13.0)
            $0.leading.equalToSuperview().inset(20.0)
        }

        self.balanceCountLabel.do {
            $0.font = .systemFont(ofSize: 26.0, weight: .semibold)
            $0.textColor = .white1
        }
    }

    private func setupDoraLabel() {
        self.doraLabel.snp.makeConstraints {
            $0.height.equalTo(18.0)
            $0.centerY.equalTo(self.balanceCountLabel.snp.centerY)
            $0.leading.equalTo(self.balanceCountLabel.snp.trailing).inset(-6.0)
        }

        self.doraLabel.do {
            $0.font = .systemFont(ofSize: 15.0, weight: .medium)
            $0.textColor = .white1
            $0.text = "DORA"
        }
    }

    private func setupDetailButtonContainerView() {
        self.detailButtonContainerView.snp.makeConstraints {
            $0.height.equalTo(30.0)
            $0.centerY.equalTo(self.doraLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.detailButtonContainerView.do {
            $0.backgroundColor = .gray2
            $0.layer.cornerRadius = 4.0
        }
    }

    private func setupDetailButton() {
        self.detailButton.snp.makeConstraints {
            let margin: CGFloat = 1.0
            $0.top.bottom.leading.trailing.equalToSuperview().inset(margin)
        }

        self.detailButton.do {
            $0.backgroundColor = .black2
            $0.layer.cornerRadius = 4.0
        }
    }

    private func setupDetailButtonLabel() {
        self.detailButtonLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(5.0)
            $0.leading.trailing.equalToSuperview().inset(13.0)
        }

        self.detailButtonLabel.do {
            $0.text = "Details"
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        }
    }
}
