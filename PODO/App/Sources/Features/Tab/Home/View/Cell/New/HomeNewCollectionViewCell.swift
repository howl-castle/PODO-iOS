//
//  HomeNewCollectionViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class HomeNewCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.imageView.kf.cancelDownloadTask()
        self.profileImageView.prepareForReuse()
    }

    func updateData(_ data: ArticleData) {
        //
        if let thumbnailPath = data.image {
            self.imageView.kf.setImage(with: URL(string: thumbnailPath))
        } else if let thumbail = data.thumbail {
            self.imageView.image = UIImage(named: thumbail)
        }
        self.profileImageView.update(imagePath: data.author?.profileImage, name: data.author?.name, imageIcon: data.author?.profileImageIcon)
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.summary
        self.nameLabel.text = data.author?.name
    }

    private let containerView = UIView(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let profileImageView = CommonUserProfileView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let headSetIconImageVIew = UIImageView(image: UIImage(named: "headset"))
}

// MARK: - Setup
extension HomeNewCollectionViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupImageView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupProfileImageView()
        self.setupNameLabel()
        self.setupHeadSetIconImageVIew()
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
            $0.addSubview(self.imageView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.profileImageView)
            $0.addSubview(self.nameLabel)
            $0.addSubview(self.headSetIconImageVIew)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.containerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = 8.0
        }
    }

    private func setupImageView() {
        self.imageView.snp.makeConstraints {
            $0.height.equalTo(100.0)
            $0.top.leading.trailing.equalToSuperview()
        }

        self.imageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(19.0)
            $0.top.equalTo(self.imageView.snp.bottom).offset(12.0)
            $0.leading.equalToSuperview().inset(14.0)
            $0.trailing.equalToSuperview().inset(14.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 16.0, weight: .bold)
            $0.textColor = .white1
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            let margin: CGFloat = 14.0
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(margin)
            $0.leading.equalToSuperview().inset(margin)
            $0.trailing.equalToSuperview().inset(margin)
        }

        self.subtitleLabel.do {
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .white2
            $0.numberOfLines = 2
        }
    }

    private func setupProfileImageView() {
        let size: CGFloat = 28.0
        self.profileImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.greaterThanOrEqualTo(self.subtitleLabel.snp.bottom).offset(16.0)
            $0.leading.equalToSuperview().inset(14.0)
            $0.bottom.equalToSuperview().inset(16.0)
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
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(6.0)
        }

        self.nameLabel.do {
            $0.font = .systemFont(ofSize: 12.0)
            $0.textColor = .gray1
        }
    }

    private func setupHeadSetIconImageVIew() {
        let height: CGFloat = 36.0
        self.headSetIconImageVIew.snp.makeConstraints {
            $0.size.equalTo(height)
            $0.centerY.equalTo(self.profileImageView.snp.centerY)
            $0.leading.equalTo(self.nameLabel.snp.trailing).offset(6.0)
            $0.trailing.equalToSuperview().inset(14.0)
        }

        self.headSetIconImageVIew.do {
            $0.backgroundColor = .orange
            $0.layer.cornerRadius = height / 2.0
        }
    }
}
