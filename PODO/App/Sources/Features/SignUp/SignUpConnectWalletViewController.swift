//
//  SignUpConnectWalletViewController.swift
//  PODO
//
//  Created by Ethan on 2023/03/11.
//

import UIKit
import SnapKit
import Then

final class SignUpConnectWalletViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.addObserver()
        self.setupUI()
    }

    @objc private func didTapConnectButton(_ sender: UIButton) {
        let viewController = SignUpFinishViewController()
        self.navigationController?.pushViewController(viewController, animated: true)
    }

    @objc private func didBecomeActiveNotification() {
        //let viewController = SignUpFinishViewController()
        //self.navigationController?.pushViewController(viewController, animated: true)
    }

    private func openAppstore() {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/1607656232") else { return }
        guard UIApplication.shared.canOpenURL(url)                                 else { return }
        UIApplication.shared.open(url)
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.didBecomeActiveNotification),
                                               name: UIApplication.didBecomeActiveNotification, object: nil)
    }

    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let stepStackView = UIStackView(frame: .zero)
    private let firstStepView = UIView(frame: .zero)
    private let secondStepView = UIView(frame: .zero)
    private let imageView = UIImageView(image: UIImage(named: "SignUpConnect"))
    private let connectButtonView = CommonBottomButtonView(frame: .zero)
}

// MARK: - Setup
extension SignUpConnectWalletViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupStepStackView()
        self.setupImageView()
        self.setupConnectButton()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.stepStackView)
            $0.addSubview(self.imageView)
            $0.addSubview(self.connectButtonView)
        }

        self.stepStackView.do {
            $0.addArrangedSubview(self.firstStepView)
            $0.addArrangedSubview(self.secondStepView)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(46.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.textColor = .orange
            $0.font = .systemFont(ofSize: 20.0, weight: .semibold)
            $0.text = "Sign up - Connect Wallet"
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.titleLabel.snp.trailing)
        }

        self.subtitleLabel.do {
            $0.textColor = .white2
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.text = "Proverty or Develop Onwards"
        }
    }

    private func setupStepStackView() {
        self.stepStackView.snp.makeConstraints {
            $0.height.equalTo(3.0)
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(22.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.stepStackView.do {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
        }

        self.firstStepView.do {
            $0.backgroundColor = .gray2
        }

        self.secondStepView.do {
            $0.backgroundColor = .orange
        }
    }

    private func setupImageView() {
        self.imageView.snp.makeConstraints {
            $0.centerY.equalToSuperview().offset(40.0)
            $0.leading.equalToSuperview().inset(40.0)
            $0.trailing.equalToSuperview().inset(60.0)
        }

        self.imageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }

    private func setupConnectButton() {
        self.connectButtonView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(18.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-18.0)
        }

        self.connectButtonView.do {
            $0.setup(title: "Connect")
            $0.button.addTarget(self, action: #selector(self.didTapConnectButton), for: .touchUpInside)

            //
            $0.updateUI(enable: true)
        }
    }
}
