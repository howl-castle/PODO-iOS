//
//  RevenueListTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class RevenueListTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(_ data: RevenueArticleData) {
        let total = [data.writing, data.translate, data.contribute]
            .compactMap { $0 }
            .reduce(0, +)
        self.doraLabel.text = "\(total) DORA"
        self.tonLabel.text = "\(total / 10.0) TON"

        self.buttonViews[safe: 0]?.updateData(data.writing ?? .zero)
        self.buttonViews[safe: 1]?.updateData(data.translate ?? .zero)
        self.buttonViews[safe: 2]?.updateData(data.contribute ?? .zero)

        self.updateChartView(data: data)
    }

    private func updateChartView(data: RevenueArticleData) {
        let writing = data.writing ?? .zero
        let translate = data.translate ?? .zero
        let contribute = data.contribute ?? .zero
        let total = writing + translate + contribute

        self.chartWritingView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(writing/total).inset(4.0 / 3.0)
            $0.width.equalTo(writing)
        }

        self.chartWritingView.do {
            $0.backgroundColor = ButtonType.writing.color
        }

        self.chartTranslateView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(translate/total).inset(4.0 / 3.0)
        }

        self.chartTranslateView.do {
            $0.backgroundColor = ButtonType.translate.color
        }

        self.chartContributeView.snp.makeConstraints {
            $0.width.equalToSuperview().multipliedBy(contribute/total).inset(4.0 / 3.0)
        }

        self.chartContributeView.do {
            $0.backgroundColor = ButtonType.contribute.color
        }
    }

    private var buttonViews: [ButtonView] = []

    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)

    private let monthStackView = UIStackView(frame: .zero)
    private let preButton = UIButton(frame: .zero)
    private let monthLabel = UILabel(frame: .zero)
    private let nextButton = UIButton(frame: .zero)

    private let doraLabel = UILabel(frame: .zero)
    private let tonLabel = UILabel(frame: .zero)

    private let chartStackView = UIStackView(frame: .zero)
    private let chartWritingView = UIView(frame: .zero)
    private let chartTranslateView = UIView(frame: .zero)
    private let chartContributeView = UIView(frame: .zero)

    private let buttonStackView = UIStackView(frame: .zero)
}

// MARK: - Setup
extension RevenueListTableViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupMonthStackView()
        self.setupPreButton()
        self.setupMonthLabel()
        self.setupNextButton()
        self.setupDoraLabel()
        self.setupTonLabel()
        self.setupChartStackView()
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
            $0.addSubview(self.monthStackView)
            $0.addSubview(self.doraLabel)
            $0.addSubview(self.tonLabel)
            $0.addSubview(self.chartStackView)
            $0.addSubview(self.buttonStackView)
        }

        self.monthStackView.do {
            $0.addArrangedSubview(self.preButton)
            $0.addArrangedSubview(self.monthLabel)
            $0.addArrangedSubview(self.nextButton)
        }

        self.chartStackView.do {
            $0.addArrangedSubview(self.chartWritingView)
            $0.addArrangedSubview(self.chartTranslateView)
            $0.addArrangedSubview(self.chartContributeView)
        }

        let buttonViews = ButtonType.allCases.map {
            let button = ButtonView(frame: .zero)
            button.setupType($0)
            return button
        }

        self.buttonViews = buttonViews

        buttonViews.forEach {
            self.buttonStackView.addArrangedSubview($0)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.height.equalTo(316.0)
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
            $0.top.equalToSuperview().inset(23.0)
            $0.leading.equalTo(16.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.textColor = .gray1
            $0.text = "Article Revenue"
        }
    }

    private func setupMonthStackView() {
        self.monthStackView.snp.makeConstraints {
            $0.centerY.equalTo(self.titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16.0)
            $0.leading.greaterThanOrEqualTo(self.titleLabel.snp.trailing).offset(8.0)
        }

        self.monthStackView.do {
            $0.axis = .horizontal
            $0.alignment = .center
            $0.spacing = 6.0
        }
    }

    private func setupPreButton() {
        self.preButton.snp.makeConstraints {
            $0.size.equalTo(32.0)
        }

        self.preButton.do {
            $0.setImage(UIImage(named: "Chevron_Left_M"), for: .normal)
        }
    }

    private func setupMonthLabel() {
        self.monthLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
        }

        self.monthLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .white1

            // test
            $0.text = "3월"
        }
    }

    private func setupNextButton() {
        self.nextButton.snp.makeConstraints {
            $0.size.equalTo(32.0)
        }

        self.nextButton.do {
            $0.setImage(UIImage(named: "Chevron_Right_M"), for: .normal)
        }
    }

    private func setupDoraLabel() {
        self.doraLabel.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.top.equalTo(self.monthStackView.snp.bottom).offset(15.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
        }

        self.doraLabel.do {
            $0.font = .systemFont(ofSize: 18.0, weight: .semibold)
            $0.textColor = .white1
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
        }
    }

    private func setupChartStackView() {
        self.chartStackView.snp.makeConstraints {
            $0.height.equalTo(23.0)
            $0.top.equalTo(self.doraLabel.snp.bottom).offset(23.0)
            $0.leading.trailing.equalToSuperview().inset(18.0)
        }

        self.chartStackView.do {
            $0.clipsToBounds = true
            $0.axis = .horizontal
            $0.spacing = 4.0
            $0.distribution = .fillProportionally
            $0.layer.cornerRadius = 4.0
        }
    }

    private func setupButtonStackView() {
        self.buttonStackView.snp.makeConstraints {
            $0.top.equalTo(self.chartStackView.snp.bottom).offset(22.0)
            $0.leading.trailing.equalToSuperview().inset(18.0)
        }

        self.buttonStackView.do {
            $0.axis = .vertical
            $0.spacing = .zero
        }
    }
}

// MARK: - ButtonView
private extension RevenueListTableViewCell {

    enum ButtonType: Int, CaseIterable {
        case writing
        case translate
        case contribute
    }

    final class ButtonView: UIView {

        weak var delegate: RevenueListTableViewCellButtonViewDelegate?

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func setupType(_ type: RevenueListTableViewCell.ButtonType) {
            self.tag = type.rawValue
            self.titleLabel.text = type.title
            self.iconImageView.backgroundColor = type.color
            self.iconImageView.image = type.iconImage
        }

        func updateData(_ data: Double) {
            self.doraLabel.text = "\(data) DORA"
            self.tonLabel.text = "(\(data / 10.0) TON)"
        }

        @objc private func didTapButton(_ sender: UIButton) {
            self.delegate?.revenueListTableViewCellButtonView(self, didTapButtonTag: self.tag)
        }

        private func setupUI() {
            self.setupProperties()
            self.setupViewHierarchy()
            self.setupSeperatorView()
            self.setupIconImageView()
            self.setupTitleLabel()
            self.setupTonLabel()
            self.setupDoraLabel()
            self.setupButton()
        }

        private func setupProperties() {
            self.snp.makeConstraints {
                $0.height.equalTo(52.0)
            }

            self.do {
                $0.backgroundColor = .clear
            }
        }

        private func setupViewHierarchy() {
            self.do {
                $0.addSubview(self.seperatorView)
                $0.addSubview(self.iconImageView)
                $0.addSubview(self.titleLabel)
                $0.addSubview(self.tonLabel)
                $0.addSubview(self.doraLabel)
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

        private func setupIconImageView() {
            let size: CGFloat = 28.0
            self.iconImageView.snp.makeConstraints {
                $0.size.equalTo(size)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview()
            }

            self.iconImageView.do {
                $0.clipsToBounds = true
                $0.contentMode = .center
                $0.layer.cornerRadius = size / 2.0
            }
        }

        private func setupTitleLabel() {
            self.titleLabel.snp.makeConstraints {
                $0.width.equalTo(90.0)
                $0.height.equalTo(17.0)
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(self.iconImageView.snp.trailing).offset(8.0)
            }

            self.titleLabel.do {
                $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
                $0.textColor = .white1
            }
        }

        private func setupTonLabel() {
            self.tonLabel.snp.makeConstraints {
                $0.height.equalTo(14.0)
                $0.centerY.trailing.equalToSuperview()
            }

            self.tonLabel.do {
                $0.font = .systemFont(ofSize: 12.0)
                $0.textColor = .gray2
            }
        }

        private func setupDoraLabel() {
            self.doraLabel.snp.makeConstraints {
                $0.height.equalTo(14.0)
                $0.centerY.equalToSuperview()
                $0.trailing.equalTo(self.tonLabel.snp.leading).offset(-2.0)
                $0.leading.greaterThanOrEqualTo(self.titleLabel.snp.trailing).offset(10.0)
            }

            self.doraLabel.do {
                $0.font = .systemFont(ofSize: 12.0, weight: .medium)
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
        private let iconImageView = UIImageView(frame: .zero)
        private let titleLabel = UILabel(frame: .zero)
        private let tonLabel = UILabel(frame: .zero)
        private let doraLabel = UILabel(frame: .zero)
        private let button = UIButton(frame: .zero)
    }
}

private extension RevenueListTableViewCell.ButtonType {

    var title: String {
        switch self {
        case .writing:      return "Writing"
        case .translate:    return "Translate"
        case .contribute:   return "Contribute"
        }
    }

    var iconImage: UIImage? {
        switch self {
        case .writing:      return UIImage(named: "Edit_Line")
        case .translate:    return UIImage(named: "Font")
        case .contribute:   return UIImage(named: "Users")
        }
    }

    var color: UIColor? {
        switch self {
        case .writing:      return .red
        case .translate:    return .purple
        case .contribute:   return .brown
        }
    }
}

// MARK: - ButtonView Delegate
private protocol RevenueListTableViewCellButtonViewDelegate: AnyObject {

    func revenueListTableViewCellButtonView(_ view: RevenueListTableViewCell.ButtonView, didTapButtonTag tag: Int)
}
