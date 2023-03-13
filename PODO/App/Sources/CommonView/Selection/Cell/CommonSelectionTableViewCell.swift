//
//  CommonSelectionTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import UIKit
import SnapKit
import Then

final class CommonSelectionTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(title: String, isSelected: Bool) {
        self.titleLabel.text = title
        self.updateUI(isSelected: isSelected)

    }

    func updateUI(isSelected: Bool) {
        let imageTintColor: UIColor? = isSelected ? .mint : .gray2
        self.checkIconImageView.updateImageTintColor(imageTintColor)
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTopSeparatorView()
        self.setupBottomSeparatorView()
        self.setupTitleLabel()
        self.setupCheckIconImageView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.topSeparatorView)
            $0.addSubview(self.bottomSeparatorView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.checkIconImageView)
        }
    }

    private func setupTopSeparatorView() {
        self.topSeparatorView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.top.leading.trailing.equalToSuperview()
        }

        self.topSeparatorView.do {
            $0.backgroundColor = .gray2Opacity40
        }
    }

    private func setupBottomSeparatorView() {
        self.bottomSeparatorView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        self.bottomSeparatorView.do {
            $0.backgroundColor = .gray2Opacity40
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview()
        }

        self.titleLabel.do {
            $0.textColor = .white2
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
        }
    }

    private func setupCheckIconImageView() {
        self.checkIconImageView.snp.makeConstraints {
            $0.size.equalTo(24.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.titleLabel.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview()
        }

        self.checkIconImageView.do {
            $0.updateImageTintColor(.white1)            
        }
    }

    private let topSeparatorView = UIView(frame: .zero)
    private let bottomSeparatorView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let checkIconImageView = UIImageView(image: UIImage(named: "Check_Big"))
}
