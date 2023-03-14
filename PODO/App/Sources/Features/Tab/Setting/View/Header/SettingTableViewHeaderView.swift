//
//  SettingTableViewHeaderView.swift
//  PODO
//
//  Created by Ethan on 2023/02/24.
//

import UIKit
import Kingfisher
import SnapKit
import Then

final class SettingTableViewHeaderView: UITableViewHeaderFooterView {

    static let height: CGFloat = 320.0

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTapWalletCopyButton(_ sender: UIButton) {

    }

    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let profileImageView = UIImageView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let jobLabel = UILabel(frame: .zero)

    private let contentButtonStackView = UIStackView(frame: .zero)
    private let writingButton = CommonIconWithCountButtonView(frame: .zero)
    private let firstSeparatorView = UIView(frame: .zero)
    private let subscribeButton = CommonIconWithCountButtonView(frame: .zero)
    private let secondSeparatorView = UIView(frame: .zero)
    private let saveButton = CommonIconWithCountButtonView(frame: .zero)

    private let walletContainerView = UIView(frame: .zero)
    private let walletIconImageView = UIImageView(image: UIImage(named: "icon"))
    private let walletAccountLabel = UILabel(frame: .zero)
    private let walletCopyIcon = UIImageView(image: UIImage(named: "copy"))
    private let walletCopyButton = UIButton(frame: .zero)
}

// MARK: - Setup
extension SettingTableViewHeaderView {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupProfileImageView()
        self.setupNameLabel()
        self.setupJobLabel()
        self.setupContentButtonStackView()
        self.setupWritingButton()
        self.setupFirstSeparatorView()
        self.setupSubscribeButton()
        self.setupSecondSeparatorView()
        self.setupSaveButton()
        self.setupWalletContainerView()
        self.setupWalletIconImageView()
        self.setupWalletAccountLabel()
        self.setupWalletCopyIcon()
        self.setupWalletCopyButton()
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
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.profileImageView)
            $0.addSubview(self.nameLabel)
            $0.addSubview(self.jobLabel)
            $0.addSubview(self.contentButtonStackView)
            $0.addSubview(self.walletContainerView)
        }

        self.contentButtonStackView.do {
            $0.addArrangedSubview(self.writingButton)
            $0.addArrangedSubview(self.firstSeparatorView)
            $0.addArrangedSubview(self.subscribeButton)
            $0.addArrangedSubview(self.secondSeparatorView)
            $0.addArrangedSubview(self.saveButton)
        }

        self.walletContainerView.do {
            $0.addSubview(self.walletIconImageView)
            $0.addSubview(self.walletAccountLabel)
            $0.addSubview(self.walletCopyIcon)
            $0.addSubview(self.walletCopyButton)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(20.0)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(24.0)
            $0.top.leading.trailing.equalToSuperview()
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 20.0, weight: .semibold)
            $0.textColor = .white1
            $0.text = "Setting"
        }
    }

    private func setupProfileImageView() {
        let size: CGFloat = 50.0
        self.profileImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(30.0)
            $0.leading.equalToSuperview()
        }

        self.profileImageView.do {
            $0.clipsToBounds = true
            $0.contentMode = .scaleAspectFill
            $0.layer.cornerRadius = size / 2.0

            //test
            $0.kf.setImage(with: URL(string: "https://img.hankyung.com/photo/201912/01.21183801.1.jpg"))
        }
    }

    private func setupNameLabel() {
        self.nameLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalTo(self.profileImageView.snp.top).offset(5.0)
            $0.leading.equalTo(self.profileImageView.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview()
        }

        self.nameLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .white1

            // test
            $0.text = "Lee"
        }
    }

    private func setupJobLabel() {
        self.jobLabel.snp.makeConstraints {
            $0.height.equalTo(15.0)
            $0.top.equalTo(self.nameLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(self.nameLabel.snp.leading)
            $0.trailing.equalToSuperview()
        }

        self.jobLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .gray1

            // test
            $0.text = "Designer"
        }
    }

    private func setupContentButtonStackView() {
        self.contentButtonStackView.snp.makeConstraints {
            $0.height.equalTo(65.0)
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.contentButtonStackView.do {
            $0.axis = .horizontal
            $0.distribution = .equalSpacing
            $0.alignment = .center
        }
    }

    private func setupWritingButton() {
        self.writingButton.do {
            let type = ContentType.writing
            $0.update(iconImage: type.iconImage, title: type.title)
        }
    }

    private func setupFirstSeparatorView() {
        self.firstSeparatorView.snp.makeConstraints {
            $0.height.equalTo(20.0)
            $0.width.equalTo(1.0)
        }

        self.firstSeparatorView.do {
            $0.backgroundColor = .gray2
        }
    }

    private func setupSubscribeButton() {
        self.subscribeButton.do {
            let type = ContentType.subscribe
            $0.update(iconImage: type.iconImage, title: type.title)
        }
    }

    private func setupSecondSeparatorView() {
        self.secondSeparatorView.snp.makeConstraints {
            $0.height.equalTo(20.0)
            $0.width.equalTo(1.0)
        }

        self.secondSeparatorView.do {
            $0.backgroundColor = .gray2
        }
    }

    private func setupSaveButton() {
        self.saveButton.do {
            let type = ContentType.save
            $0.update(iconImage: type.iconImage, title: type.title)
        }
    }

    private func setupWalletContainerView() {
        self.walletContainerView.snp.makeConstraints {
            $0.height.equalTo(50.0)
            $0.top.equalTo(self.contentButtonStackView.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.walletContainerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .gray2
            $0.layer.cornerRadius = 4.0
        }
    }

    private func setupWalletIconImageView() {
        self.walletIconImageView.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10.0)
        }

        self.walletIconImageView.do {
            $0.contentMode = .center
        }
    }

    private func setupWalletAccountLabel() {
        self.walletAccountLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.walletIconImageView.snp.trailing).offset(6.0)
        }

        self.walletAccountLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 14)
            $0.textColor = .white1

            // test
            $0.text = "0x880d5d5cfeqwekwnniiwaaw1"
        }
    }

    private func setupWalletCopyIcon() {
        self.walletCopyIcon.snp.makeConstraints {
            $0.size.equalTo(28.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.walletAccountLabel.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview().inset(10.0)
        }
    }

    private func setupWalletCopyButton() {
        self.walletCopyButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.walletCopyButton.do {
            $0.addTarget(self, action: #selector(self.didTapWalletCopyButton), for: .touchUpInside)
        }
    }
}

// MARK: - ContentType
private extension SettingTableViewHeaderView {

    enum ContentType {
        case writing
        case subscribe
        case save
    }
}

private extension SettingTableViewHeaderView.ContentType {

    var iconImage: UIImage? {
        switch self {
        case .writing:      return UIImage(named: "Edit_Line")
        case .subscribe:    return UIImage(named: "Octagon_Check")
        case .save:         return UIImage(named: "Bookmark")
        }
    }

    var title: String {
        switch self {
        case .writing:      return "Writing"
        case .subscribe:    return "Subscribe"
        case .save:         return "Save"
        }
    }
}
