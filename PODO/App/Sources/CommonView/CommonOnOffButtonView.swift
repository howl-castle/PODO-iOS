//
//  CommonOnOffButtonView.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import UIKit
import SnapKit
import Then

final class CommonOnOffButtonView: UIView {

    let button = UIButton(frame: .zero)

    var isSelected: Bool = false {
        didSet {
            self.backgroundColor = self.isSelected ? self.enabledColor : self.disabledColor
            self.titleLabel.text = self.isSelected ? "on" : "off"

            let color: UIColor? = self.isSelected ? .white1 : .gray2
            self.titleLabel.textColor = color
            self.iconImageView.updateImageTintColor(color)

            self.updateLayout(isSelected: self.isSelected)
        }
    }

    private func updateLayout(isSelected: Bool) {
        if isSelected {
            self.iconImageView.snp.remakeConstraints {
                $0.size.equalTo(21.0)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(self.iconImageViewInset)
            }

            self.titleLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview().offset(-2.0)
                $0.trailing.equalToSuperview().inset(self.titleLabelInset + 3.0)
            }
        } else {
            self.iconImageView.snp.remakeConstraints {
                $0.size.equalTo(21.0)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(self.iconImageViewInset)
            }

            self.titleLabel.snp.remakeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(self.titleLabelInset)
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateEnabledColor(_ color: UIColor?) {
        self.enabledColor = color
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupIconImageView()
        self.setupTitleLabel()
        self.setupButton()
    }

    private func setupProperties() {
        let height: CGFloat = 30.0
        self.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.width.equalTo(62.0)
        }

        self.do {
            $0.backgroundColor = self.disabledColor
            $0.clipsToBounds = true
            $0.layer.cornerRadius = height / 2.0
        }
    }

    private func setupViewHierarchy() {
        self.do {
            $0.addSubview(self.iconImageView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.button)
        }
    }

    private func setupIconImageView() {
        self.iconImageView.snp.remakeConstraints {
            $0.size.equalTo(21.0)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(self.iconImageViewInset)
        }

        self.iconImageView.do {
            $0.contentMode = .center
            $0.updateImageTintColor(.gray2)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.remakeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(self.titleLabelInset)
        }

        self.titleLabel.do {
            $0.text = "off"
            $0.textColor = .gray2
        }
    }

    private func setupButton() {
        self.button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.button.do {
            $0.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
        }
    }

    // TODO: 없애기
    @objc private func didTapButton(_ sender: UIButton) {
        self.isSelected.toggle()
    }

    private var enabledColor: UIColor? = .blue
    private let disabledColor: UIColor? = .black2

    private let iconImageViewInset: CGFloat = 7.0
    private let titleLabelInset: CGFloat = 9.0

    private let iconImageView = UIImageView(image: UIImage(named: "Octagon_Check"))
    private let titleLabel = UILabel(frame: .zero)
}
