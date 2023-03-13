//
//  CommonBottomButtonView.swift
//  PODO
//
//  Created by Ethan on 2023/03/10.
//

import UIKit
import SnapKit
import Then

final class CommonBottomButtonView: UIView {

    let button = UIButton(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateUI(enable: Bool) {
        self.button.isEnabled = enable
        self.backgroundColor = enable ? self.enabledColor : self.disabledColor
    }

    func setup(title: String, backgroundColor: UIColor? = .orange) {
        self.enabledColor = backgroundColor
        self.titleLabel.text = title
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupButton()
    }

    private func setupProperties() {
        self.snp.makeConstraints {
            $0.height.equalTo(54.0)
        }

        self.do {
            $0.clipsToBounds = true
            $0.backgroundColor = self.disabledColor
            $0.layer.cornerRadius = 4.0
        }
    }

    private func setupViewHierarchy() {
        self.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.button)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .white1
            $0.textAlignment = .center
        }
    }

    private func setupButton() {
        self.button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.button.do {
            $0.isEnabled = false
        }
    }

    private var enabledColor: UIColor? = .orange
    private let disabledColor: UIColor? = .gray1

    private let titleLabel = UILabel(frame: .zero)
}
