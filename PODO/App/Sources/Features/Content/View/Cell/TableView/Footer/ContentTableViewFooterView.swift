//
//  ContentTableViewFooterView.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import UIKit
import SnapKit
import Then

final class ContentTableViewFooterView: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private let topBackGroundView = UIView(frame: .zero)
    private let contentLabel = UILabel(frame: .zero)
}

// MARK: - Setup
extension ContentTableViewFooterView {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTopBackGroundView()
        self.setupContentLabel()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .gray3
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.topBackGroundView)
            $0.addSubview(self.contentLabel)
        }
    }

    private func setupTopBackGroundView() {
        self.topBackGroundView.snp.makeConstraints {
            $0.height.equalTo(10.0)
            $0.top.leading.trailing.equalToSuperview()
        }

        self.topBackGroundView.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupContentLabel() {
        self.contentLabel.snp.makeConstraints {
            $0.top.equalTo(self.topBackGroundView.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        self.contentLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 16.0, weight: .bold)
            $0.textColor = .white1
            $0.text = "Your support is greatly appreciated!"
        }
    }
}
