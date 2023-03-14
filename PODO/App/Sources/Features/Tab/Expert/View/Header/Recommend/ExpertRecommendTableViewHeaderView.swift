//
//  ExpertRecommendTableViewHeaderView.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class ExpertRecommendTableViewHeaderView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
}

// MARK: - Setup
extension ExpertRecommendTableViewHeaderView {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(24.0)
            $0.top.equalToSuperview().inset(32.0)
            $0.leading.equalToSuperview().inset(23.0)
            $0.trailing.equalToSuperview().inset(23.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 20.0, weight: .semibold)
            $0.textColor = .white1
            $0.text = "I think you can answer!"
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.subtitleLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.textColor = .gray1
            $0.text = "Answer the Question to receive DORA"
        }
    }
}
