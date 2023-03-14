//
//  ExpertRecommendButtonContainerView.swift
//  PODO
//
//  Created by Yun on 2023/03/14.
//

import UIKit
import SnapKit
import Then

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

    private let size: CGFloat = 28.0

    private let commentIconImageView = UIImageView(image: UIImage(named: "Chat_Circle_Chats"))
    private let commentCountLabel = UILabel(frame: .zero)
    private let viewIconImageView = UIImageView(image: UIImage(named: "Eye"))
    private let viewCountLabel = UILabel(frame: .zero)
}

// MARK: - Setup
extension ExpertRecommendButtonContainerView {

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
}
