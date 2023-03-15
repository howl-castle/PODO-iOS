//
//  HomeNewNoticeCollectionViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/03/15.
//

import UIKit
import SnapKit
import Then

typealias HomeNewNoticeCellData = HomeNewNoticeCollectionViewCell.CellData

final class HomeNewNoticeCollectionViewCell: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
        self.updateData()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(_ data: CellData = .mock) {
        self.imageView.image = data.sampleImage
        self.titleLabel.text = data.title
        self.subtitleLabel.text = data.subtitle

        self.titleLabel.textColor = data.titleColor
        self.subtitleLabel.textColor = data.subtitleColor
        self.moreButtonContainerView.backgroundColor = data.buttonColor
        self.moreLabel.textColor = data.buttonTitleColor
        self.containerView.backgroundColor = data.backgroundColor
        self.moreArrowIconImageView.updateImageTintColor(data.buttonTitleColor)
    }

    @objc private func didTapMoreButton(_ sender: UIButton) {

    }

    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let moreButtonContainerView = UIView(frame: .zero)
    private let moreStackView = UIStackView(frame: .zero)
    private let moreLabel = UILabel(frame: .zero)
    private let moreArrowIconImageView = UIImageView(image: UIImage(named: "RightArrow"))
    private let moreButton = UIButton(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
}

// MARK: - Setup
extension HomeNewNoticeCollectionViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupMoreButtonContainerView()
        self.setupMoreStackView()
        self.setupMoreLabel()
        self.setupMoreArrowIconImageView()
        self.setupMoreButton()
        self.setupImageView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.containerView)
        }

        self.containerView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.moreButtonContainerView)
            $0.addSubview(self.imageView)
        }

        self.moreButtonContainerView.do {
            $0.addSubview(self.moreStackView)
            $0.addSubview(self.moreButton)
        }

        self.moreStackView.do {
            $0.addArrangedSubview(self.moreLabel)
            $0.addArrangedSubview(self.moreArrowIconImageView)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.containerView.do {
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 8.0
        }
    }


    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(22.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.greaterThanOrEqualToSuperview().inset(20.0)
        }

        self.titleLabel.do {
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 18.0, weight: .bold)
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(18.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.greaterThanOrEqualToSuperview().inset(20.0)
        }

        self.subtitleLabel.do {
            $0.numberOfLines = 4
            $0.font = .systemFont(ofSize: 13.0)
        }
    }

    private func setupMoreButtonContainerView() {
        let height: CGFloat = 26.0
        self.moreButtonContainerView.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.width.equalTo(72.0)
            $0.top.greaterThanOrEqualTo(self.subtitleLabel.snp.bottom).offset(30.0)
            $0.bottom.equalToSuperview().inset(24.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
        }

        self.moreButtonContainerView.do {
            $0.backgroundColor = .white1
            $0.layer.cornerRadius = height / 2.0
        }
    }

    private func setupMoreStackView() {
        self.moreStackView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(7.0)
        }

        self.moreStackView.do {
            $0.alignment = .center
            $0.axis = .horizontal
            $0.spacing = 2.0
        }
    }

    private func setupMoreLabel() {
        self.moreLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.text = "more"
        }
    }

    private func setupMoreArrowIconImageView() {
        self.moreArrowIconImageView.snp.makeConstraints {
            $0.width.equalTo(17.0)
        }

        self.moreArrowIconImageView.do {
            $0.contentMode = .scaleToFill
        }
    }

    private func setupMoreButton() {
        self.moreButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.moreButton.do {
            $0.addTarget(self, action: #selector(self.didTapMoreButton), for: .touchUpInside)
        }
    }

    private func setupImageView() {
        self.imageView.snp.makeConstraints {
            $0.height.equalTo(156.0)
            $0.width.equalTo(165.0)
            $0.bottom.trailing.equalToSuperview()
        }
    }
}

// MARK: - Cell Data
extension HomeNewNoticeCollectionViewCell {

    struct CellData {
        let title: String?
        let subtitle: String?
        let backgroundImagePath: String?
        // TODO: hex code 로 변경 하고, 데이터 서버에서 받을 것
        let backgroundColor: UIColor?
        let titleColor: UIColor?
        let subtitleColor: UIColor?
        let buttonColor: UIColor?
        let buttonTitleColor: UIColor?

        //
        var sampleImage: UIImage? {
            UIImage(named: "Home_new_notice")
        }
    }
}

extension HomeNewNoticeCellData {

    static let mock = HomeNewNoticeCellData(
        title: "Develop Onward\nWith PODO",
        subtitle: "Explore the blockchain world\n through PODO for a better\ntomorrow",
        backgroundImagePath: nil,
        backgroundColor: .blue,
        titleColor: .white1,
        subtitleColor: .white2,
        buttonColor: .white1,
        buttonTitleColor: .blue
    )
}
