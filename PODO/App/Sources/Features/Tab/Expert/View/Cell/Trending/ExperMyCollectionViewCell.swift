//
//  ExperMyCollectionViewCell.swift
//  PODO
//
//  Created by Yun on 2023/03/10.
//

import UIKit
import SnapKit
import Then

final class ExperMyCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImageView.prepareForReuse()
    }

    func updateData(_ data: QuestionData) {
        self.profileImageView.update(imagePath: data.user?.profileImage, name: data.user?.name, imageIcon: data.user?.profileImageIcon)
        self.titleLabel.text = data.title
        self.nameLabel.text = data.user?.name
        self.jobLabel.text = data.user?.job
        self.answerLabel.text = data.answers?.first?.content
        self.dateLabel.text = data.createdAt
    }

    private let containerView = UIView(frame: .zero)
    private let myLabel = UILabel(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let profileImageView = CommonUserProfileView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let jobLabel = UILabel(frame: .zero)
    private let answerLabel = UILabel(frame: .zero)
    private let dateLabel = UILabel(frame: .zero)
}

// MARK: - Setup
extension ExperMyCollectionViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupMyLabel()
        self.setupTitleLabel()
        self.setupProfileImageView()
        self.setupNameLabel()
        self.setupJobLabel()
        self.setupAnswerLabel()
        self.setupDateLabel()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.contentView.addSubview(self.containerView)

        self.containerView.do {
            $0.addSubview(self.myLabel)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.profileImageView)
            $0.addSubview(self.nameLabel)
            $0.addSubview(self.jobLabel)
            $0.addSubview(self.answerLabel)
            $0.addSubview(self.dateLabel)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.containerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = 5.0
        }
    }

    private func setupMyLabel() {
        let height: CGFloat = 18.0
        self.myLabel.snp.makeConstraints {
            $0.width.equalTo(31.0)
            $0.height.equalTo(height)
            $0.top.equalToSuperview().inset(20.0)
            $0.leading.equalToSuperview().inset(14.0)
        }

        self.myLabel.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .brown
            $0.font = .systemFont(ofSize: 11.0, weight: .bold)
            $0.textColor = .white1
            $0.textAlignment = .center
            $0.text = "My"
            $0.layer.cornerRadius = height / 2.0
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(18.0)
            $0.centerY.equalTo(self.myLabel.snp.centerY)
            $0.leading.equalTo(self.myLabel.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(14.0)
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 13.0, weight: .medium)
            $0.textColor = .gray1
        }
    }

    private func setupProfileImageView() {
        let size: CGFloat = 26.0
        self.profileImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.equalTo(self.myLabel.snp.bottom).offset(16.0)
            $0.leading.equalTo(self.myLabel.snp.leading)
        }

        self.profileImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = size / 2.0
        }
    }

    private func setupNameLabel() {
        self.nameLabel.snp.makeConstraints {
            $0.height.equalTo(14.0)
            $0.top.equalTo(self.profileImageView.snp.top)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(6.0)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.nameLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 12.0, weight: .semibold)
            $0.textColor = .white1
        }
    }

    private func setupJobLabel() {
        self.jobLabel.snp.makeConstraints {
            $0.height.equalTo(12.0)
            $0.bottom.equalTo(self.profileImageView.snp.bottom)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(6.0)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.jobLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 10.0, weight: .medium)
            $0.textColor = .white2
        }
    }

    private func setupAnswerLabel() {
        self.answerLabel.snp.makeConstraints {
            $0.leading.equalTo(self.profileImageView.snp.leading)
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(8.0)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.answerLabel.do {
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.textColor = .white1
        }
    }

    private func setupDateLabel() {
        self.dateLabel.snp.makeConstraints {
            $0.height.equalTo(18.0)
            $0.bottom.equalToSuperview().inset(12.0)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.dateLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .gray1
        }
    }
}
