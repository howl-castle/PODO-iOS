//
//  ContentUserInfoTableViewFooterView.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class ContentUserInfoTableViewFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(iconImage: UIImage?, title: String, name: String? = nil) {
        self.iconImageView.image = iconImage
        self.titleLabel.text = title
        self.nameLabel.text = name
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupIconImageView()
        self.setupTitleLabel()
        self.setupNameLabel()
        self.setupRightIconImageView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .gray3
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.containerView)
        }

        self.containerView.do {
            $0.addSubview(self.iconImageView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.nameLabel)
            $0.addSubview(self.rightIconImageView)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(8.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        self.containerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .gray2
            $0.layer.cornerRadius = 8.0
        }
    }

    private func setupIconImageView() {
        let size: CGFloat = 28.0
        self.iconImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10.0)
        }

        self.iconImageView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = size / 2.0
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.iconImageView.snp.trailing).offset(6.0)
        }

        self.titleLabel.do {
            $0.setContentHuggingPriority(.required, for: .horizontal)
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .white1
        }
    }

    private func setupNameLabel() {
        self.nameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(2.0)
        }

        self.nameLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .orange
        }
    }

    private func setupRightIconImageView() {
        self.rightIconImageView.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.nameLabel.snp.trailing).offset(4.0)
            $0.trailing.equalToSuperview().inset(10.0)
        }
    }

    private let containerView = UIView(frame: .zero)
    private let iconImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let rightIconImageView = UIImageView(image: UIImage(named: "RightArrow"))

}
