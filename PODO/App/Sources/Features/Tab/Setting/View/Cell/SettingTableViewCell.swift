//
//  SettingTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/24.
//

import UIKit
import SnapKit
import Then

final class SettingTableViewCell: UITableViewCell {

    static let height: CGFloat = 52.0

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateTitle(_ title: String) {
        self.titleLabel.text = title
    }

    private let titleLabel = UILabel(frame: .zero)
    private let rightIconImageView = UIImageView(image: UIImage(named: "Right"))
    private let seperatorView = UIView(frame: .zero)
}

// MARK: - Setup
extension SettingTableViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupRightIconImageView()
        self.setupSeperatorView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .black2
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.rightIconImageView)
            $0.addSubview(self.seperatorView)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(24.0)
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .white1
        }
    }

    private func setupRightIconImageView() {
        self.rightIconImageView.snp.makeConstraints {
            $0.size.equalTo(16.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(24.0)
        }

        self.rightIconImageView.do {
            $0.contentMode = .scaleAspectFill
        }
    }

    private func setupSeperatorView() {
        self.seperatorView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.rightIconImageView.snp.trailing)
        }

        self.seperatorView.do {
            $0.backgroundColor = .gray2Opacity40
        }
    }
}
