//
//  CommonInputView.swift
//  PODO
//
//  Created by Ethan on 2023/03/10.
//

import UIKit
import SnapKit
import Then

protocol CommonInputViewDelegate: AnyObject {

    func commonInputViewBeginEditing(view: CommonInputView)
    func commonInputViewEndEditing(view: CommonInputView)
    func commonInputViewDidTapNextButton(view: CommonInputView)
}

final class CommonInputView: UIView {

    weak var delegate: CommonInputViewDelegate?

    var text: String? { self.textField.text }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setup(title: String, placeholder: String, borderColor: UIColor? = .mint, isSecureTextEntry: Bool = false, isLastInptView: Bool = false, needAccessoryView: Bool = true) {
        self.placeholder = placeholder
        self.selectedBorderColor = borderColor
        self.isLastInptView = isLastInptView

        self.accessoryView.rightButton.isEnabled = isLastInptView == false
        self.titleLabel.text = title
        self.textField.tintColor = borderColor
        self.textField.placeholder = placeholder
        self.textField.isSecureTextEntry = isSecureTextEntry

        if let color = self.disabledColor {
            self.textField.attributedPlaceholder = NSAttributedString(
                string: self.placeholder,
                attributes: [.foregroundColor: color,
                             .font: UIFont.systemFont(ofSize: 14.0)]
            )
        }

        if needAccessoryView {
            self.textField.inputAccessoryView = self.accessoryView
        }
    }

    @objc private func didTapAccessoryLeftButton(_ sender: UIButton) {
        self.textField.resignFirstResponder()
    }

    @objc private func didTapAccessoryRightButton(_ sender: UIButton) {
        self.delegate?.commonInputViewDidTapNextButton(view: self)
    }

    @objc private func didChangeTextField(_ textField: UITextField) {
        self.closeButton.isHidden = textField.text?.count == .zero
    }

    @objc private func didTapCloseButton(_ sender: UIButton) {
        sender.isHidden = true
        self.textField.text = ""
    }

    private var isLastInptView: Bool = true
    private var placeholder: String = ""
    private var selectedBorderColor: UIColor? = .mint
    private let selectedLabelColor: UIColor? = .white1
    private let selectedHolderColor: UIColor? = .gray1
    private let disabledColor: UIColor? = .gray2Opacity40

    private let accessoryView = CommonAccessoryView(frame: .zero)
    private let containerView = UIView(frame: .zero)
    private let titleLabel = UILabel(frame: .zero)
    private let textField = UITextField(frame: .zero)
    private let closeButton = UIButton(frame: .zero)
}

// MARK: - TextField Delegate
extension CommonInputView: UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.commonInputViewBeginEditing(view: self)
        let isHiddenCloseButton = textField.text?.isEmpty == true || textField.text == nil
        self.closeButton.isHidden = isHiddenCloseButton
        self.backgroundColor = self.selectedBorderColor

        if let color = self.selectedHolderColor {
            textField.attributedPlaceholder = NSAttributedString(
                string: self.placeholder,
                attributes: [.foregroundColor: color,
                             .font: UIFont.systemFont(ofSize: 14.0)]
            )
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.commonInputViewEndEditing(view: self)
        self.closeButton.isHidden = true
        self.backgroundColor = self.disabledColor

        if let color = self.disabledColor {
            textField.attributedPlaceholder = NSAttributedString(
                string: self.placeholder,
                attributes: [.foregroundColor: color,
                             .font: UIFont.systemFont(ofSize: 14.0)]
            )
        }
    }
}

// MARK: - Setup
extension CommonInputView {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupContainerView()
        self.setupTitleLabel()
        self.setupCloseButton()
        self.setupTextField()
        self.setupAccessoryView()
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
        }

        self.containerView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.closeButton)
            $0.addSubview(self.textField)
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

    private func setupCloseButton() {
        self.closeButton.snp.makeConstraints {
            $0.size.equalTo(22.0)
            $0.bottom.trailing.equalToSuperview().inset(12.0)
        }

        self.closeButton.do {
            $0.isHidden = true
            $0.contentMode = .center
            $0.setImage(UIImage(named: "close"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        }
    }

    private func setupTextField() {
        self.textField.snp.makeConstraints {
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(10.0)
            $0.bottom.equalToSuperview().inset(12.0)
            $0.leading.equalTo(self.titleLabel.snp.leading)
            $0.trailing.equalTo(self.closeButton.snp.leading).offset(6.0)
        }

        self.textField.do {
            $0.delegate = self
            $0.font = .systemFont(ofSize: 14.0)
            $0.autocorrectionType = .no
            $0.autocapitalizationType = .none
            $0.enablesReturnKeyAutomatically = true
            $0.textColor = self.selectedLabelColor
            $0.tintColor = self.selectedBorderColor
            $0.addTarget(self, action: #selector(self.didChangeTextField), for: .editingChanged)
        }
    }

    private func setupAccessoryView() {
        self.accessoryView.snp.makeConstraints {
            $0.height.equalTo(55.0)
            $0.width.equalTo(self.bounds.width)
        }

        self.accessoryView.do {
            $0.leftButton.addTarget(self, action: #selector(self.didTapAccessoryLeftButton), for: .touchUpInside)
            $0.rightButton.addTarget(self, action: #selector(self.didTapAccessoryRightButton), for: .touchUpInside)
        }
    }
}
