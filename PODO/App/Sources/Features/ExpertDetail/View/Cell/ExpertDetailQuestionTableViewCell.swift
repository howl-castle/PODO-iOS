//
//  ExpertDetailQuestionTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/24.
//

import UIKit

final class ExpertDetailQuestionTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .red
        }
    }

    private func setupViewHierarchy() {
    }
}
