//
//  SignInViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class SignInViewController: UIViewController {

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
    
    @objc private func didTapLoginButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NotificationName.didFinishLogin, object: nil)
        self.dismiss(animated: true)
    }

    @objc private func didTapSignUpButton(_ sender: UIButton) {
        let viewController = SignUpInputViewController()
        self.navigationController?.pushViewController(viewController, animated: false)
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

    private var keyboardHeight: CGFloat?

    private lazy var inputViews: [CommonInputView] = { [self.idInputView, self.passwordInputView] }()

    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let imageView = UIImageView(image: UIImage(named: "LoginImage"))
    private let idInputView = CommonInputView(frame: .zero)
    private let passwordInputView = CommonInputView(frame: .zero)
    private let loginButtonView = CommonBottomButtonView(frame: .zero)
    private let signUpContainerView = UIView(frame: .zero)
    private let signUpLabel = UILabel(frame: .zero)
    private let signUpButton = UIButton(frame: .zero)
}

// MARK: - CommonInputView Delegate
extension SignInViewController: CommonInputViewDelegate {

    func commonInputViewBeginEditing(view: CommonInputView) {
    }

    func commonInputViewEndEditing(view: CommonInputView) {
        let enable = self.idInputView.text.isEmpty == false && self.passwordInputView.text.isEmpty == false
        self.loginButtonView.updateUI(enable: enable)
    }

    func commonInputViewDidTapNextButton(view: CommonInputView) {
        if view == self.passwordInputView {
            view.resignTextFieldFirstResponder()
        } else {
            guard let index = self.inputViews.firstIndex(of: view) else { return }
            let nextView = self.inputViews[safe: index + 1]
            nextView?.becomeTextFieldFirstResponder()
        }
    }
}

// MARK: - Setup
extension SignInViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupImageView()
        self.setupIDInputView()
        self.setupPasswordInputView()
        self.setupLoginButton()
        self.setupSignUpContainerView()
        self.setupSignUpLabel()
        self.setupSignUpButton()
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
            $0.addSubview(self.imageView)
            $0.addSubview(self.idInputView)
            $0.addSubview(self.passwordInputView)
            $0.addSubview(self.loginButtonView)
            $0.addSubview(self.signUpContainerView)
        }

        self.signUpContainerView.do {
            $0.addSubview(self.signUpLabel)
            $0.addSubview(self.signUpButton)
        }
    }

    private func setupContainerView() {
        self.containerView.snp.makeConstraints {
            $0.height.equalToSuperview()
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.containerView.safeAreaLayoutGuide.snp.top).offset(66.0)
        }

        self.titleLabel.do {
            $0.numberOfLines = 1
            $0.textColor = .orange
            $0.font = .systemFont(ofSize: 28.0, weight: .bold)
            $0.text = "Log in"
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
        }

        self.subtitleLabel.do {
            $0.textColor = .white2
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.text = "Proverty or Develop Onwards"
        }
    }

    private func setupImageView() {
        self.imageView.snp.makeConstraints {
            //$0.height.equalTo(100)//self.view.bounds.height / 3.0)
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(52.0)
        }

        self.imageView.do {
            $0.contentMode = .scaleAspectFit
        }
    }

    private func setupIDInputView() {
        self.idInputView.snp.makeConstraints {
            $0.top.equalTo(self.imageView.snp.bottom).offset(40.0)
            $0.leading.trailing.equalToSuperview().inset(20.0)
        }

        self.idInputView.do {
            $0.setup(title: "ID", placeholder: "Please enter the ID")
            $0.delegate = self
        }
    }

    private func setupPasswordInputView() {
        self.passwordInputView.snp.makeConstraints {
            $0.top.equalTo(self.idInputView.snp.bottom).offset(12.0)
            $0.leading.equalTo(self.idInputView.snp.leading)
            $0.trailing.equalTo(self.idInputView.snp.trailing)
        }

        self.passwordInputView.do {
            $0.setup(title: "Password", placeholder: "Please enter the Password", isSecureTextEntry: true)
            $0.delegate = self
        }
    }

    private func setupLoginButton() {
        self.loginButtonView.snp.makeConstraints {
            $0.top.equalTo(self.passwordInputView.snp.bottom).offset(24.0)
            $0.leading.trailing.equalToSuperview().inset(18.0)
        }

        self.loginButtonView.do {
            $0.setup(title: "Log in")
            $0.button.addTarget(self, action: #selector(self.didTapLoginButton), for: .touchUpInside)

            //
            $0.updateUI(enable: true)
        }
    }

    private func setupSignUpContainerView() {
        self.signUpContainerView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(self.loginButtonView.snp.bottom).offset(32.0)
            $0.bottom.equalTo(self.containerView.safeAreaLayoutGuide.snp.bottom).offset(-40.0)
        }
    }

    private func setupSignUpLabel() {
        self.signUpLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.bottom.leading.equalToSuperview()
        }

        self.signUpLabel.do {
            $0.textColor = .gray1
            $0.font = .systemFont(ofSize: 14.0)
            $0.text = "Do you have no account yet?"
        }
    }

    private func setupSignUpButton() {
        self.signUpButton.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.bottom.trailing.equalToSuperview()
            $0.leading.equalTo(self.signUpLabel.snp.trailing).offset(8.0)
        }

        self.signUpButton.do {
            $0.setTitle("Sign up", for: .normal)
            $0.setTitleColor(.orange, for: .normal)
            $0.titleLabel?.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.addTarget(self, action: #selector(self.didTapSignUpButton), for: .touchUpInside)
        }
    }
}
