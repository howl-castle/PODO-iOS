//
//  ContentTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import UIKit
import SnapKit
import Then

final class ContentTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateContent(_ content: String) {
        self.contentLabel.text = content
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContentLabel()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.contentLabel)
        }
    }

    private func setupContentLabel() {
        self.contentLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        self.contentLabel.do {
            $0.numberOfLines = .zero
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .white2
        }
    }

    private let contentLabel = UILabel(frame: .zero)
}
