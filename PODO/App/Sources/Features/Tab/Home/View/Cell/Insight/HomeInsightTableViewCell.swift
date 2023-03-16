//
//  HomeInsightTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class HomeInsightTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.thumbnailImageView.kf.cancelDownloadTask()
        self.profileImageView.prepareForReuse()
    }

    func updateData(_ data: ArticleData) {
        if let thumbnailPath = data.thumbnailPath {
            self.thumbnailImageView.kf.setImage(with: URL(string: thumbnailPath))
        } else if let thumbail = data.thumbail {
            self.thumbnailImageView.image = UIImage(named: thumbail)
        }

        self.profileImageView.update(imagePath: data.author?.profileImagePath, name: data.author?.name, imageIcon: data.author?.profileImage)
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.summary
        self.nameLabel.text = data.author?.name
    }

    private let containerView = UIView(frame: .zero)
    private let thumbnailImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let profileImageView = CommonUserProfileView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
}

// MARK: - Setup
extension HomeInsightTableViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupThumbnailImageView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupProfileImageView()
        self.setupNameLabel()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .black2
        }
    }

    private func setupViewHierarchy() {
        self.contentView.addSubview(self.containerView)

        self.containerView.do {
            $0.addSubview(self.thumbnailImageView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.profileImageView)
            $0.addSubview(self.nameLabel)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.containerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .clear
        }
    }

    private func setupThumbnailImageView() {
        self.thumbnailImageView.snp.makeConstraints {
            $0.size.equalTo(114.0)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.0)
        }

        self.thumbnailImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = 6.0
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            let margin: CGFloat = 8.0
            $0.top.equalToSuperview()
            $0.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(margin)
            $0.trailing.equalToSuperview().inset(36.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .bold)
            $0.textColor = .white1
            $0.numberOfLines = 2
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(8.0)
            $0.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(36.0)
        }

        self.subtitleLabel.do {
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .gray1
            $0.numberOfLines = 2
        }
    }

    private func setupProfileImageView() {
        let size: CGFloat = 21.0
        self.profileImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.greaterThanOrEqualTo(self.subtitleLabel.snp.bottom).offset(10.0)
            $0.leading.equalTo(self.thumbnailImageView.snp.trailing).offset(8.0)
            $0.bottom.equalToSuperview().inset(20.0)
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
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(28.0)
        }

        self.nameLabel.do {
            $0.font = .systemFont(ofSize: 12.0)
            $0.textColor = .white2
        }
    }
}
