//
//  CommonPopupViewController.swift
//  PODO
//
//  Created by Yun on 2023/03/17.
//

import UIKit
import SnapKit
import Then

protocol CommonPopupViewControllerDelegate: AnyObject {
    func commonPopupViewControllerDidTapConfirm(viewController: CommonPopupViewController)
}

final class CommonPopupViewController: UIViewController {

    weak var delegate: CommonPopupViewControllerDelegate?

    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overFullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()

        self.update(image: UIImage(named: "buyContent"),
                    title: "View all articles after payment",
                    subtitle: "Once payment is processed, it cannot be cancelled. Are you sure you want to proceed?",
                    confirmText: "Yes",
                    cancelTitle: "NO")
    }

    func update(image: UIImage?, title: String, subtitle: String, confirmText: String, cancelTitle: String) {
        self.iconImageView.image = image
        self.titleLabel.text = title
        self.subtitleLabel.text = subtitle
        self.confirmButton.setTitle(confirmText, for: .normal)
        self.cancelButton.setTitle(cancelTitle, for: .normal)
    }

    @objc private func didTapCancelButton(_ sender: UIButton) {
        self.dismiss(animated: false)
    }

    @objc private func didTapConfirmButton(_ sender: UIButton) {
        self.delegate?.commonPopupViewControllerDidTapConfirm(viewController: self)
        self.dismiss(animated: false)
    }

    private let dimView = UIView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private let iconImageView = UIImageView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let buttonStackView = UIStackView(frame: .zero)
    private let cancelButton = UIButton(frame: .zero)
    private let confirmButton = UIButton(frame: .zero)
}

extension CommonPopupViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupDimView()
        self.setupContainerView()
        self.setupIconImageView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupButtonStackView()
    }

    private func setupProperties() {
        self.do {
            $0.view.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.dimView)
            $0.addSubview(self.containerView)
        }

        self.containerView.do {
            $0.addSubview(self.iconImageView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.buttonStackView)
        }

        self.buttonStackView.do {
            $0.addArrangedSubview(self.cancelButton)
            $0.addArrangedSubview(self.confirmButton)
        }
    }

    private func setupDimView() {
        self.dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.dimView.do {
            $0.backgroundColor = .black2Opacity80
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.0)
        }

        self.containerView.do {
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = 10.0
        }
    }

    private func setupIconImageView() {
        self.iconImageView.snp.makeConstraints {
            $0.height.equalTo(121.0)
            $0.width.equalTo(134.0)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(9.0)
        }

        self.iconImageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.iconImageView.snp.bottom).offset(14.0)
            $0.leading.trailing.equalToSuperview().inset(14.0)
        }

        self.titleLabel.do {
            $0.numberOfLines = .zero
            $0.font = .systemFont(ofSize: 18.0, weight: .semibold)
            $0.textColor = .orange
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(12.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.subtitleLabel.do {
            $0.numberOfLines = .zero
            $0.font = .systemFont(ofSize: 14.0)
            $0.textColor = .white1
        }
    }

    private func setupButtonStackView() {
        self.buttonStackView.snp.makeConstraints {
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(24.0)
            $0.bottom.equalToSuperview().inset(20.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.buttonStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.spacing = 8.0
        }

        self.cancelButton.snp.makeConstraints {
            $0.height.equalTo(50.0)
        }

        self.cancelButton.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .gray2
            $0.layer.cornerRadius = 4.0
            $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
            $0.setTitleColor(.white1, for: .normal)
            $0.addTarget(self, action: #selector(self.didTapCancelButton), for: .touchUpInside)
        }

        self.confirmButton.snp.makeConstraints {
            $0.height.equalTo(50.0)
        }

        self.confirmButton.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .orange
            $0.layer.cornerRadius = 4.0
            $0.titleLabel?.font = .systemFont(ofSize: 16.0, weight: .semibold)
            $0.setTitleColor(.white1, for: .normal)
            $0.addTarget(self, action: #selector(self.didTapConfirmButton), for: .touchUpInside)
        }
    }
}
