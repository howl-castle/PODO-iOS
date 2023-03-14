//
//  SignUpFinishViewController.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import UIKit
import SnapKit
import Then

final class SignUpFinishViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupUI()
    }

    @objc private func didTapConnectButton(_ sender: UIButton) {
        // API
        self.dismiss(animated: true)
    }

    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let imageView = UIImageView(image: UIImage(named: "SignUpFinish"))
    private let finishButtonView = CommonBottomButtonView(frame: .zero)
}

// MARK: - Setup
extension SignUpFinishViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupImageView()
        self.setupFinishButton()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.imageView)
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.finishButtonView)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(120.0)
            $0.centerX.equalToSuperview()
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.textColor = .orange
            $0.font = .systemFont(ofSize: 30.0, weight: .semibold)
            $0.text = "Welcome!"
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(14.0)
            $0.leading.greaterThanOrEqualToSuperview().inset(20.0)
        }

        self.subtitleLabel.do {
            $0.textColor = .white2
            $0.font = .systemFont(ofSize: 18.0, weight: .medium)
            $0.text = "Proverty or Develop Onwards"
        }
    }

    private func setupImageView() {
        self.imageView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.3)
            $0.centerY.equalToSuperview().offset(40.0)
            $0.leading.equalToSuperview().inset(40.0)
            $0.trailing.equalToSuperview().inset(60.0)
        }

        self.imageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }

    private func setupFinishButton() {
        self.finishButtonView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-18.0)
        }

        self.finishButtonView.do {
            $0.setup(title: "Go to Main")
            $0.button.addTarget(self, action: #selector(self.didTapConnectButton), for: .touchUpInside)
            $0.updateUI(enable: true)
        }
    }
}
