//
//  CommonAccessoryView.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import UIKit
import SnapKit
import Then

final class CommonAccessoryView: UIView {

    let leftButton = UIButton(frame: .zero)
    let rightButton = UIButton(frame: .zero)

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(leftTitle: String, rightTitle: String) {
        self.leftButton.setTitle(leftTitle, for: .normal)
        self.rightButton.setTitle(rightTitle, for: .normal)
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupLeftButton()
        self.setupRightButton()
    }

    private func setupProperties() {
        self.snp.makeConstraints {
            $0.height.equalTo(55.0)
        }

        self.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.do {
            $0.addSubview(self.leftButton)
            $0.addSubview(self.rightButton)
        }
    }

    private func setupLeftButton() {
        self.leftButton.snp.makeConstraints {
            $0.height.equalTo(self.buttonHeight)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(self.margin)
        }

        self.leftButton.do {
            $0.setTitleColor(.gray2Opacity40, for: .normal)
        }
    }

    private func setupRightButton() {
        self.rightButton.snp.makeConstraints {
            $0.height.equalTo(self.buttonHeight)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(self.margin)
        }

        self.rightButton.do {
            $0.setTitleColor(.mint, for: .normal)
        }
    }

    private let buttonHeight: CGFloat = 17.0
    private let margin: CGFloat = 20.0
}
