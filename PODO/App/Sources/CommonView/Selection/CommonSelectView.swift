//
//  CommonSelectView.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import UIKit
import SnapKit
import Then

final class CommonSelectView: UIView {

    private(set) var text: String?

    let button = UIButton(frame: .zero)

    var isSelected: Bool = false {
        didSet {
            let color: UIColor? = self.text != nil ? self.selectedLabelColor : self.disabledColor
            self.selectLabel.textColor = self.isSelected ? self.selectedLabelColor : color
            self.backgroundColor = self.isSelected ? self.selectedBorderColor : self.disabledColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateSelected(text: String) {
        self.text = text
        self.selectLabel.text = text
    }

    func setup(title: String, placeholder: String, borderColor: UIColor? = .mint) {
        self.selectedBorderColor = borderColor

        self.selectLabel.text = placeholder
        self.titleLabel.text = title
    }

    @objc private func didTapButton(_ sender: UIButton) {
        self.isSelected = true
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupSelectIconImageView()
        self.setupSelectLabel()
        self.setupButton()
    }

    private func setupProperties() {
        self.snp.makeConstraints {
            $0.height.equalTo(63.0)
        }

        self.do {
            $0.backgroundColor = self.disabledColor
            $0.clipsToBounds = true
            $0.layer.cornerRadius = 4.0
        }
    }

    private func setupViewHierarchy() {
        self.do {
            $0.addSubview(self.containerView)
            $0.addSubview(self.button)
        }

        self.containerView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.selectIconImageView)
            $0.addSubview(self.selectLabel)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(1.0)
        }

        self.containerView.do {
            $0.backgroundColor = .black2
            $0.layer.cornerRadius = 4.0
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(13.0)
            $0.top.equalToSuperview().inset(12.0)
            $0.leading.trailing.equalToSuperview().inset(13.0)
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 10.0)
            $0.textColor = .gray1
            $0.textAlignment = .left
        }
    }

    private func setupSelectIconImageView() {
        self.selectIconImageView.snp.makeConstraints {
            $0.size.equalTo(22.0)
            $0.bottom.trailing.equalToSuperview().inset(12.0)
        }

        self.selectIconImageView.do {
            $0.contentMode = .center
        }
    }

    private func setupSelectLabel() {
        self.selectLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
            $0.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.selectIconImageView.snp.leading).offset(6.0)
        }

        self.selectLabel.do {
            $0.numberOfLines = 1
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = self.disabledColor
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

    private var selectedBorderColor: UIColor? = .mint
    private let selectedLabelColor: UIColor? = .white2
    private let selectedHolderColor: UIColor? = .gray1
    private let disabledColor: UIColor? = .gray2Opacity40

    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let selectIconImageView = UIImageView(image: UIImage(named: "DownArrow"))
    private let selectLabel = UILabel(frame: .zero)
}
