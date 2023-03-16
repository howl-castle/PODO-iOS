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

    @objc private func didTapConfirmButton(_ sender: UIButton) {
        let viewController = SignUpConnectWalletViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
    }

    @objc private func didTapInterestSelectButton(_ sender: UIButton) {
        self.showInterestSelectView()
    }

    @objc private func keyboardWillShowNotification(_ notification: Notification) {
        guard let userInfo = notification.userInfo                                      else { return }
        guard let value = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }

        let keyboardFrame = value.cgRectValue
        self.keyboardHeight = keyboardFrame.size.height

        if let view = self.findFirstResponderView() {
            self.changLayoutIfNeeded(view: view)
        }
    }

    @objc private func keyboardWillHideNotification(_ notification: Notification) {
        self.containerView.snp.updateConstraints {
            $0.bottom.equalToSuperview()
        }
    }

    private func addObserver() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillShowNotification),
                                               name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.keyboardWillHideNotification),
                                               name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    private func findFirstResponderView() -> UIView? {
        self.inputViews.first(where: { $0.isTextFieldFirstResponder })
    }

    private func changLayoutIfNeeded(view: UIView) {
        let position = view.convert(view.bounds.origin, to: self.containerView)
        let height = view.bounds.height
        let margin = self.containerView.bounds.height - position.y - height

        guard let keyboardHeight = self.keyboardHeight else { return }

        let diff: CGFloat
        if margin < keyboardHeight {
            diff = keyboardHeight - margin
        } else {
            diff = .zero
        }
        self.containerView.snp.updateConstraints {
            $0.bottom.equalToSuperview().inset(diff)
        }

    }

    private func showInterestSelectView() {
        let viewController = CommonSelectionViewController(items: InterestData.mocks.compactMap({ $0.title }),
                                                           title: "Interest",
                                                           subtitle: "Choose your preferred field of interest.")
        viewController.delegate = self
        self.present(viewController, animated: false)
    }

    private var keyboardHeight: CGFloat?

    private lazy var inputViews: [CommonInputView] = {
        [self.idInputView, self.passwordInputView, self.passwordVerifyInputView,
         self.nicknameInputView, self.specialtyInputView]
    }()

    private let containerView = UIView(frame: .zero)
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
            view.resignTextFieldFirstResponder()
            self.showInterestSelectView()
        } else {
            guard let index = self.inputViews.firstIndex(of: view) else { return }
            let nextView = self.inputViews[safe: index + 1]
            nextView?.becomeTextFieldFirstResponder()
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

// MARK: - Setup
extension SignUpInputViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupStepStackView()
        self.setupInputStackView()
        self.setupConfirmButton()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.containerView)
        }

        self.containerView.do {
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

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.containerView.safeAreaLayoutGuide.snp.top).offset(46.0)
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
            $0.bottom.equalTo(self.containerView.safeAreaLayoutGuide.snp.bottom).offset(-18.0)
        }

        self.confirmButtonView.do {
            $0.setup(title: "Confirm")
            $0.button.addTarget(self, action: #selector(self.didTapConfirmButton), for: .touchUpInside)

            //
            $0.updateUI(enable: true)
        }
    }
}
