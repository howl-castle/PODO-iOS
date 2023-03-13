//
//  ContentUserInfoTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class ContentUserInfoTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImageView.kf.cancelDownloadTask()
    }

    func updateData(_ data: UserData) {
        self.profileImageView.kf.setImage(with: URL(string: data.profileImagePath ?? ""))
        self.nameLabel.text = data.name
        self.jobLabel.text = data.job
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupProfileImageView()
        self.setupNameLabel()
        self.setupJobLabel()
        self.setupIconImageContainerView()
        self.setupIconImageView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .gray3
        }
    }

    private func setupViewHierarchy() {
        self.contentView.addSubview(self.containerView)

        self.containerView.do {
            $0.addSubview(self.profileImageView)
            $0.addSubview(self.nameLabel)
            $0.addSubview(self.jobLabel)
            $0.addSubview(self.iconImageContainerView)
        }

        self.iconImageContainerView.do {
            $0.addSubview(self.iconImageView)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        self.containerView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 5.0
        }
    }

    private func setupProfileImageView() {
        let size: CGFloat = 36.0
        self.profileImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.equalToSuperview().inset(6.0)
            $0.leading.equalToSuperview()
        }

        self.profileImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = size / 2.0

            // test
            $0.kf.setImage(with: URL(string: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg"))
        }
    }

    private func setupNameLabel() {
        self.nameLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalTo(self.profileImageView.snp.top)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(8.0)
        }

        self.nameLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .white2

            // test
            $0.text = "Lee"
        }
    }

    private func setupJobLabel() {
        self.jobLabel.snp.makeConstraints {
            $0.height.equalTo(14.0)
            $0.bottom.equalTo(self.profileImageView.snp.bottom)
            $0.leading.equalTo(self.nameLabel.snp.leading)
        }

        self.jobLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .gray1

            // test
            $0.text = "Designer"
        }
    }

    private func setupIconImageContainerView() {
        let size: CGFloat = 28.0
        self.iconImageContainerView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.bottom.equalToSuperview().inset(25.0)
            $0.trailing.equalToSuperview()
        }

        self.iconImageContainerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .gray2
            $0.layer.cornerRadius = size / 2.0
        }
    }

    private func setupIconImageView() {
        let size: CGFloat = 18.0
        self.iconImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.center.equalToSuperview()
        }

        self.iconImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFit
        }
    }

    private let containerView = UIView(frame: .zero)
    private let profileImageView = UIImageView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let jobLabel = UILabel(frame: .zero)
    private let iconImageContainerView = UIView(frame: .zero)
    private let iconImageView = UIImageView(image: UIImage(named: "Cursor_Right"))
}
