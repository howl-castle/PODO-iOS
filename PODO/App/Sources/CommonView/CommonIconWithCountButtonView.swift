//
//  CommonIconWithCountButtonView.swift
//  PODO
//
//  Created by Ethan on 2023/03/13.
//

import UIKit
import SnapKit
import Then

final class CommonIconWithCountButtonView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(iconImage: UIImage?, title: String) {
        self.iconImageView.image = iconImage
        self.titleLabel.text = title
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupIconImageView()
        self.setupTitleLabel()
        self.setupCountLabel()
    }

    private func setupProperties() {
        self.snp.makeConstraints {
            $0.height.equalTo(65.0)
            $0.width.equalTo(67.0)
        }

        self.do {
            $0.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.do {
            $0.addSubview(self.iconImageView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.countLabel)
        }
    }

    private func setupIconImageView() {
        self.iconImageView.snp.makeConstraints {
            $0.height.equalTo(28.0)
            $0.top.centerX.equalToSuperview()
        }

        self.iconImageView.do {
            $0.contentMode = .center
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.iconImageView.snp.bottom).offset(2.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.textColor = .white1
        }
    }

    private func setupCountLabel() {
        self.countLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.countLabel.do {
            $0.numberOfLines = 1
            $0.textAlignment = .center
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .brown

            //test
            $0.text = "12"
        }
    }

    private let iconImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let countLabel = UILabel(frame: .zero)
}
