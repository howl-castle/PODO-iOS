//
//  ContentTableViewHeaderView.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import UIKit
import SnapKit
import Then

final class ContentTableViewHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.profileImageView.prepareForReuse()
    }

    func updateData(_ data: ContentViewModel.ContentHeaderData) {
        self.profileImageView.update(imagePath: data.user?.profileImagePath, name: data.user?.name, imageIcon: data.user?.profileImage)
        self.nameLabel.text = data.user?.name
        self.jobLabel.text = data.user?.job
        self.titleLabel.text = data.title
        self.summaryLabel.text = data.summary
        self.dateLabel.text = data.date
        self.bookmarkButton.isSelected = data.isBookmarked ?? false
    }

    private let containerView = UIView(frame: .zero)
    private let profileImageView = CommonUserProfileView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let jobLabel = UILabel(frame: .zero)
    private let bookmarkButton = CommonOnOffButtonView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let summaryLabel = UILabel(frame: .zero)
    private let dateLabel = UILabel(frame: .zero)
    private let separatorView = UIView(frame: .zero)
}

// MARK: - Setup
extension ContentTableViewHeaderView {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupProfileImageView()
        self.setupNameLabel()
        self.setupJobLabel()
        self.setupBookmarkButton()
        self.setupTitleLabel()
        self.setupSummaryLabel()
        self.setupDateLabel()
        self.setupSeparatorView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.containerView)
        }

        self.containerView.do {
            $0.addSubview(self.profileImageView)
            $0.addSubview(self.nameLabel)
            $0.addSubview(self.jobLabel)
            $0.addSubview(self.bookmarkButton)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.summaryLabel)
            $0.addSubview(self.dateLabel)
            $0.addSubview(self.separatorView)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }

    private func setupProfileImageView() {
        let size: CGFloat = 36.0
        self.profileImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.leading.equalToSuperview()
        }

        self.profileImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = (size / 2.0)
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
            $0.textColor = .white1
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
            $0.textColor = .white2
        }
    }

    private func setupBookmarkButton() {
        self.bookmarkButton.snp.makeConstraints {
            let margin: CGFloat = 16.0
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
            $0.leading.equalTo(self.nameLabel.snp.trailing).offset(margin)
            $0.leading.equalTo(self.jobLabel.snp.trailing).offset(margin)
        }

        self.bookmarkButton.do {
            $0.isUserInteractionEnabled = true
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.titleLabel.do {
            $0.numberOfLines = .zero
            $0.font = .systemFont(ofSize: 22.0, weight: .bold)
            $0.textColor = .white1
        }
    }

    private func setupSummaryLabel() {
        self.summaryLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.summaryLabel.do {
            $0.numberOfLines = .zero
            $0.font = .systemFont(ofSize: 16.0)
            $0.textColor = .white2
        }
    }

    private func setupDateLabel() {
        self.dateLabel.snp.makeConstraints {
            $0.top.equalTo(self.summaryLabel.snp.bottom).offset(12.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.dateLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .white2
        }
    }

    private func setupSeparatorView() {
        self.separatorView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.top.equalTo(self.dateLabel.snp.bottom).offset(16.0)
            $0.bottom.equalToSuperview().inset(16.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.separatorView.do {
            $0.backgroundColor = .gray2
        }
    }
}
