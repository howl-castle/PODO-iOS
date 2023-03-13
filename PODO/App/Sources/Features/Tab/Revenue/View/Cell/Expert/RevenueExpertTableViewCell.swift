//
//  RevenueExpertTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then 

final class RevenueExpertTableViewCell: UITableViewCell {

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
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupDoraLabel()
        self.setupTonLabel()
        self.setupContentContainerView()
        self.setupSeperatorLabel()
        self.setupAnswerLabel()
        self.setupAnswerCountLabel()
        self.setupAdoptLabel()
        self.setupAdoptCountLabel()
        self.setupButtonStackView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.containerView)
        }

        self.containerView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.doraLabel)
            $0.addSubview(self.tonLabel)
            $0.addSubview(self.contentContainerView)
            $0.addSubview(self.buttonStackView)
        }

        self.contentContainerView.do {
            $0.addSubview(self.seperatorLabel)
            $0.addSubview(self.answerLabel)
            $0.addSubview(self.answerCountLabel)
            $0.addSubview(self.adoptLabel)
            $0.addSubview(self.adoptCountLabel)
        }

        self.buttonStackView.do { view in
            ButtonType.allCases.forEach {
                let button = ButtonView(frame: .zero)
                button.setupType($0)
                view.addArrangedSubview(button)
            }
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.height.equalTo(286.0)
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        self.containerView.do {
            $0.backgroundColor = .black2
            $0.layer.cornerRadius = 8.0
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalToSuperview().inset(19.0)
            $0.leading.trailing.equalTo(16.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.textColor = .gray1
            $0.text = "Article Revenue"
        }
    }

    private func setupDoraLabel() {
        self.doraLabel.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(13.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
        }

        self.doraLabel.do {
            $0.font = .systemFont(ofSize: 18.0, weight: .semibold)
            $0.textColor = .white1

            // test
            $0.text = "12 DORA"
        }
    }

    private func setupTonLabel() {
        self.tonLabel.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.centerY.equalTo(self.doraLabel.snp.centerY)
            $0.leading.equalTo(self.doraLabel.snp.trailing).offset(8.0)
        }

        self.tonLabel.do {
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .gray1

            // test
            $0.text = "(2.1TON)"
        }
    }

    private func setupContentContainerView() {
        self.contentContainerView.snp.makeConstraints {
            $0.height.equalTo(50.0)
            $0.top.equalTo(self.doraLabel.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }

        self.contentContainerView.do {
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = 4.0
        }
    }

    private func setupSeperatorLabel() {
        self.seperatorLabel.snp.makeConstraints {
            $0.width.equalTo(1.0)
            $0.centerX.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(15.0)
        }

        self.seperatorLabel.do {
            $0.backgroundColor = .gray2
        }
    }

    private func setupAnswerLabel() {
        self.answerLabel.snp.makeConstraints {
            $0.width.equalTo(80.0)
            $0.height.equalTo(17.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(17.0)
        }

        self.answerLabel.do {
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .white1
            $0.text = "My answer"
        }
    }

    private func setupAnswerCountLabel() {
        self.answerCountLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(self.answerLabel.snp.trailing).offset(8.0)
            $0.trailing.equalTo(self.seperatorLabel.snp.leading).offset(-13.0)
        }

        self.answerCountLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .brown

            // test
            $0.text = "123"
        }
    }

    private func setupAdoptLabel() {
        self.adoptLabel.snp.makeConstraints {
            $0.width.equalTo(80.0)
            $0.height.equalTo(17.0)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.seperatorLabel.snp.trailing).offset(13.0)
        }

        self.adoptLabel.do {
            $0.font = .systemFont(ofSize: 12.0, weight: .medium)
            $0.textColor = .white1
            $0.text = "Adopted"
        }
    }

    private func setupAdoptCountLabel() {
        self.adoptCountLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.centerY.equalToSuperview()
            $0.leading.greaterThanOrEqualTo(self.adoptLabel.snp.trailing).offset(8.0)
            $0.trailing.equalToSuperview().inset(17.0)
        }

        self.adoptCountLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .orange

            // test
            $0.text = "12"
        }
    }

    private func setupButtonStackView() {
        self.buttonStackView.snp.makeConstraints {
            $0.top.equalTo(self.contentContainerView.snp.bottom).offset(20.0)
            $0.leading.trailing.equalToSuperview().inset(16.0)
        }

        self.buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = .zero
        }
    }

    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)

    private let doraLabel = UILabel(frame: .zero)
    private let tonLabel = UILabel(frame: .zero)

    private let contentContainerView = UIView(frame: .zero)
    private let seperatorLabel = UILabel(frame: .zero)
    private let answerLabel = UILabel(frame: .zero)
    private let answerCountLabel = UILabel(frame: .zero)
    private let adoptLabel = UILabel(frame: .zero)
    private let adoptCountLabel = UILabel(frame: .zero)

    private let buttonStackView = UIStackView(frame: .zero)
}

private extension RevenueExpertTableViewCell {

    enum ButtonType: Int, CaseIterable {
        case question
        case answer
    }

    final class ButtonView: UIView {

        weak var delegate: RevenueExpertTableViewCellButtonViewDelegate?

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupType(_ type: RevenueExpertTableViewCell.ButtonType) {
            self.tag = type.rawValue
            self.titleLabel.text = type.title

            // test
            self.countLabel.text = "10 개"
        }

        func updateData(_ data: String) {

        }

        @objc private func didTapButton(_ sender: UIButton) {
            self.delegate?.revenueExpertTableViewCellButtonView(self, didTapButtonTag: self.tag)
        }

        private func setupUI() {
            self.setupProperties()
            self.setupViewHierarchy()
            self.setupSeperatorView()
            self.setupTitleLabel()
            self.setupArrowImageView()
            self.setupCountLabel()
            self.setupButton()
        }

        private func setupProperties() {
            self.snp.makeConstraints {
                $0.height.equalTo(57.0)
            }

            self.do {
                $0.backgroundColor = .clear
            }
        }

        private func setupViewHierarchy() {
            self.do {
                $0.addSubview(self.seperatorView)
                $0.addSubview(self.titleLabel)
                $0.addSubview(self.countLabel)
                $0.addSubview(self.arrowImageView)
                $0.addSubview(self.button)
            }
        }

        private func setupSeperatorView() {
            self.seperatorView.snp.makeConstraints {
                $0.height.equalTo(1.0)
                $0.top.leading.trailing.equalToSuperview()
            }

            self.seperatorView.do {
                $0.backgroundColor = .gray2Opacity40
            }
        }

        private func setupTitleLabel() {
            self.titleLabel.snp.makeConstraints {
                $0.width.equalTo(100.0)
                $0.height.equalTo(17.0)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(6.0)
            }

            self.titleLabel.do {
                $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
                $0.textColor = .gray1
            }
        }

        private func setupArrowImageView() {
            let size: CGFloat = 20.0
            self.arrowImageView.snp.makeConstraints {
                $0.size.equalTo(size)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview()
            }

            self.arrowImageView.do {
                $0.clipsToBounds = true
                $0.contentMode = .center
            }
        }

        private func setupCountLabel() {
            self.countLabel.snp.makeConstraints {
                $0.height.equalTo(17.0)
                $0.centerY.equalToSuperview()
                $0.leading.greaterThanOrEqualTo(self.titleLabel.snp.trailing).offset(8.0)
                $0.trailing.equalTo(self.arrowImageView.snp.leading)
            }

            self.countLabel.do {
                $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
                $0.textColor = .white1
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

        private let seperatorView = UIView(frame: .zero)
        private let titleLabel = UILabel(frame: .zero)
        private let countLabel = UILabel(frame: .zero)
        private let arrowImageView = UIImageView(image: UIImage(named: "right-s"))
        private let button = UIButton(frame: .zero)
    }
}

private extension RevenueExpertTableViewCell.ButtonType {

    var title: String {
        switch self {
        case .question:     return "My Question"
        case .answer:       return "My Answer"
        }
    }
}

private protocol RevenueExpertTableViewCellButtonViewDelegate: AnyObject {

    func revenueExpertTableViewCellButtonView(_ view: RevenueExpertTableViewCell.ButtonView, didTapButtonTag tag: Int)
}
