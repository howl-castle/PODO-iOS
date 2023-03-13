//
//  SignUpInputViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class SignUpInputViewController: UIViewController {

    private func setupAccessoryView() {
        self.accessoryView.snp.makeConstraints {
            $0.height.equalTo(55.0)
            $0.width.equalTo(self.view.bounds.width)
        }

//        self.accessoryView.do {
//            $0.leftButton.addTarget(self, action: #selector(self.didTapAccessoryLeftButton), for: .touchUpInside)
//            $0.rightButton.addTarget(self, action: #selector(self.didTapAccessoryRightButton), for: .touchUpInside)
//        }
    }

    private let accessoryView = CommonAccessoryView(frame: .zero)

    override var inputAccessoryView: UIView? {
        self.accessoryView
    }

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

    @objc private func didTapConfirmButton(_ sender: UIButton) {
        let viewController = SignUpConnectWalletViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
    }

    @objc private func didTapInterestSelectButton(_ sender: UIButton) {
        let viewController = CommonSelectionViewController(items: InterestData.mocks.compactMap({ $0.title }),
                                                           title: "Interest",
                                                           subtitle: "Choose your preferred field of interest.")
        viewController.delegate = self
        self.present(viewController, animated: false)
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupStepStackView()
        self.setupInputStackView()
        self.setupConfirmButton()
        self.setupAccessoryView()
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
            $0.addSubview(self.inputStackView)
            $0.addSubview(self.confirmButtonView)
        }

        self.stepStackView.do {
            $0.addArrangedSubview(self.firstStepView)
            $0.addArrangedSubview(self.secondStepView)
        }

        self.inputStackView.do {
            $0.addArrangedSubview(self.idInputView)
            $0.addArrangedSubview(self.passwordInputView)
            $0.addArrangedSubview(self.passwordVerifyInputView)
            $0.addArrangedSubview(self.nicknameInputView)
            $0.addArrangedSubview(self.specialtyInputView)
            $0.addArrangedSubview(self.interestSelectView)
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
            $0.text = "Sign up - Input Your inform"
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
            $0.backgroundColor = .orange
        }

        self.secondStepView.do {
            $0.backgroundColor = .gray2
        }
    }

    private func setupInputStackView() {
        self.inputStackView.snp.makeConstraints {
            $0.height.lessThanOrEqualTo(438.0).priority(.required)
            $0.top.equalTo(self.stepStackView.snp.bottom).offset(35.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        self.inputStackView.do {
            $0.axis = .vertical
            $0.distribution = .equalSpacing
        }

        self.idInputView.do {
            $0.setup(title: "ID", placeholder: "Please enter the ID you want to use")
            $0.delegate = self
        }

        self.passwordInputView.do {
            $0.setup(title: "Password", placeholder: "Please enter the Password you want to use", isSecureTextEntry: true)
            $0.delegate = self
        }

        self.passwordVerifyInputView.do {
            $0.setup(title: "Verify Password", placeholder: "Please check the password you entered", isSecureTextEntry: true)
            $0.delegate = self
        }

        self.nicknameInputView.do {
            $0.setup(title: "Nickname", placeholder: "Set Display Name for PODO")
            $0.delegate = self
        }

        self.specialtyInputView.do {
            $0.setup(title: "Specialty", placeholder: "ex) Associate Manager for UX Design")
            $0.delegate = self
        }

        self.interestSelectView.do {
            $0.setup(title: "Interest", placeholder: "Please select your interest")
            $0.button.addTarget(self, action: #selector(self.didTapInterestSelectButton), for: .touchUpInside)
        }
    }

    private func setupConfirmButton() {
        self.confirmButtonView.snp.makeConstraints {
            $0.top.equalTo(self.inputStackView.snp.bottom).offset(20.0).priority(.low)
            $0.leading.trailing.equalToSuperview().inset(18.0)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom).offset(-18.0)
        }

        self.confirmButtonView.do {
            $0.setup(title: "Confirm")
            $0.button.addTarget(self, action: #selector(self.didTapConfirmButton), for: .touchUpInside)

            //
            $0.updateUI(enable: true)
        }
    }

    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let stepStackView = UIStackView(frame: .zero)
    private let firstStepView = UIView(frame: .zero)
    private let secondStepView = UIView(frame: .zero)
    private let inputStackView = UIStackView(frame: .zero)
    private let idInputView = CommonInputView(frame: .zero)
    private let passwordInputView = CommonInputView(frame: .zero)
    private let passwordVerifyInputView = CommonInputView(frame: .zero)
    private let nicknameInputView = CommonInputView(frame: .zero)
    private let specialtyInputView = CommonInputView(frame: .zero)
    private let interestSelectView = CommonSelectView(frame: .zero)
    private let confirmButtonView = CommonBottomButtonView(frame: .zero)
}

extension SignUpInputViewController: CommonInputViewDelegate {

    func commonInputViewBeginEditing(view: CommonInputView) {
    }

    func commonInputViewEndEditing(view: CommonInputView) {
    }

    func commonInputViewDidTapNextButton(view: CommonInputView) {
        if view == self.specialtyInputView {
            print("@@@@@@ aaaaa")
        }
    }
}

extension SignUpInputViewController: CommonSelectionViewControllerDelegate {

    func commonSelectionViewController(_ viewController: CommonSelectionViewController, didSelectItem item: String) {
        self.interestSelectView.updateSelected(text: item)
    }

    func commonSelectionViewControllerWillDisappear(viewController: CommonSelectionViewController) {
        self.interestSelectView.isSelected = false
    }
}
