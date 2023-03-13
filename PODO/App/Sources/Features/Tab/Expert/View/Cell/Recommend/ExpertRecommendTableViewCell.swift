//
//  ExpertRecommendTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class ExpertRecommendTableViewCell: UITableViewCell {

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

    func updateData(_ data: QuestionData) {
        self.profileImageView.kf.setImage(with: URL(string: data.user?.profileImagePath ?? ""))
        self.titleLabel.text = data.title
        self.nameLabel.text = data.user?.name
        self.jobLabel.text = data.user?.job
        self.answerLabel.text = data.answers?.first?.content
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupProfileImageView()
        self.setupNameLabel()
        self.setupJobLabel()
        self.setupDoraContainerView()
        self.setupTitleLabel()
        self.setupAnswerLabel()
        self.setupButtonContainerView()
        self.setupSeparatorView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.contentView.addSubview(self.containerView)

        self.containerView.do {
            $0.addSubview(self.profileImageView)
            $0.addSubview(self.nameLabel)
            $0.addSubview(self.jobLabel)
            $0.addSubview(self.doraBorderView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.answerLabel)
            $0.addSubview(self.buttonContainerView)
            $0.addSubview(self.separatorView)
        }

        self.doraBorderView.do {
            $0.addSubview(self.doraContainerView)
        }

        self.doraContainerView.do {
            $0.addSubview(self.doraLabel)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalToSuperview().inset(22.0)
            $0.leading.trailing.equalToSuperview().inset(24.0)
        }

        self.containerView.do {
            $0.clipsToBounds = true
        }
    }

    private func setupProfileImageView() {
        let size: CGFloat = 36.0
        self.profileImageView.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.equalToSuperview().inset(10.0)
            $0.leading.equalToSuperview().inset(2.0)
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
            $0.height.equalTo(12.0)
            $0.bottom.equalTo(self.profileImageView.snp.bottom)
            $0.leading.equalTo(self.nameLabel.snp.leading)
            $0.trailing.equalTo(self.nameLabel.snp.trailing)
        }

        self.jobLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .white2
        }
    }

    private func setupDoraContainerView() {
        let height: CGFloat = 23.0
        self.doraBorderView.snp.makeConstraints {
            $0.height.equalTo(23.0)
            $0.top.equalToSuperview().inset(10.0)
            $0.trailing.equalToSuperview().inset(2.0)
        }

        self.doraBorderView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .orange
            $0.layer.cornerRadius = height / 2.0
        }

        self.doraContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(1.0)
        }

        self.doraContainerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = height / 2.0
        }

        self.doraLabel.snp.makeConstraints {
            $0.height.equalTo(18.0)
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(13.0)
        }

        self.doraLabel.do {
            $0.clipsToBounds = true
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .orange
            $0.textAlignment = .center
            $0.layer.cornerRadius = height / 2.0

            // test
            $0.text = "500 DORA"
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(19.0)
            $0.top.equalTo(self.profileImageView.snp.bottom).offset(14.0)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 16.0, weight: .semibold)
            $0.textColor = .gray1
        }
    }

    private func setupAnswerLabel() {
        self.answerLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(6.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.answerLabel.do {
            $0.numberOfLines = 2
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.textColor = .gray1
        }
    }

    private func setupButtonContainerView() {
        self.buttonContainerView.snp.makeConstraints {
            $0.top.equalTo(self.answerLabel.snp.bottom).offset(13.0)
            $0.leading.equalToSuperview().inset(2.0)
        }

        self.buttonContainerView.do {
            // test
            $0.update(commentCount: 13, viewCount: 20)
        }
    }


    private func setupSeparatorView() {
        self.separatorView.snp.makeConstraints {
            $0.height.equalTo(1.0)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        self.separatorView.do {
            $0.backgroundColor = .gray2Opacity40
        }
    }

    private let containerView = UIView(frame: .zero)
    private let doraBorderView = UIView(frame: .zero)
    private let doraContainerView = UIView(frame: .zero)
    private let doraLabel = UILabel(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let profileImageView = UIImageView(frame: .zero)
    private let nameLabel = UILabel(frame: .zero)
    private let jobLabel = UILabel(frame: .zero)
    private let answerLabel = UILabel(frame: .zero)
    private let separatorView = UILabel(frame: .zero)
    private let buttonContainerView = ExpertRecommendButtonContainerView(frame: .zero)
}

final class ExpertRecommendButtonContainerView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func update(commentCount: Int, viewCount: Int) {
        self.commentCountLabel.text = "+\(commentCount)"
        self.viewCountLabel.text = "+\(viewCount)"
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupCommentIconImageView()
        self.setupCommentCountLabel()
        self.setupViewIconImageView()
        self.setupViewCountLabel()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.do {
            $0.addSubview(self.commentIconImageView)
            $0.addSubview(self.commentCountLabel)
            $0.addSubview(self.viewIconImageView)
            $0.addSubview(self.viewCountLabel)
        }
    }

    private func setupCommentIconImageView() {
        self.commentIconImageView.snp.makeConstraints {
            $0.size.equalTo(self.size)
            $0.top.bottom.leading.equalToSuperview()
        }
    }

    private func setupCommentCountLabel() {
        self.commentCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.commentIconImageView.snp.trailing).offset(8.0)
        }

        self.commentCountLabel.do {
            $0.font = .systemFont(ofSize: 12.0, weight: .semibold)
            $0.textColor = .orange
        }
    }

    private func setupViewIconImageView() {
        self.viewIconImageView.snp.makeConstraints {
            $0.size.equalTo(self.size)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.commentCountLabel.snp.trailing).offset(16.0)
        }
    }

    private func setupViewCountLabel() {
        self.viewCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.viewIconImageView.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview()
        }

        self.viewCountLabel.do {
            $0.font = .systemFont(ofSize: 12.0, weight: .semibold)
            $0.textColor = .purple
        }
    }

    private let size: CGFloat = 28.0

    private let commentIconImageView = UIImageView(image: UIImage(named: "Chat_Circle_Chats"))
    private let commentCountLabel = UILabel(frame: .zero)
    private let viewIconImageView = UIImageView(image: UIImage(named: "Eye"))
    private let viewCountLabel = UILabel(frame: .zero)
}