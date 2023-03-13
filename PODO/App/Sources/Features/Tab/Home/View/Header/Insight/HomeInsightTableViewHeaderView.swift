//
//  HomeInsightTableViewHeaderView.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

protocol HomeInsightTableViewHeaderViewDelegate: AnyObject {

    func homeInsightTableViewHeaderView(_ view: HomeInsightTableViewHeaderView, didTapCategory tag: Int)
}

final class HomeInsightTableViewHeaderView: UITableViewHeaderFooterView {

    weak var delegate: HomeInsightTableViewHeaderViewDelegate?

    deinit {
        self.resetStackView()
    }

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        self.resetStackView()
    }

    func updateCategories(_ categories: [String], selectedCategory: Int) {
        self.categories = categories
        self.selectedCategory = selectedCategory

        /*
        let allCategoryView = self.makeCategoryButtonView(withTitle: "All")
        allCategoryView.tag = .zero
        allCategoryView.updateUI(isSelected: true)
        self.categoryStackView.addArrangedSubview(allCategoryView)
        self.categoryButtons.append(allCategoryView)
         */

        categories.enumerated().forEach { index, category in
            let view = self.makeCategoryButtonView(withTitle: category)
            view.tag = index //+ 1

            let isSelected = selectedCategory == index
            view.updateUI(isSelected: isSelected)
            self.categoryStackView.addArrangedSubview(view)
            self.categoryButtons.append(view)
        }

        self.categoryStackView.addArrangedSubview(UIView(frame: .zero))
    }

    private func makeCategoryButtonView(withTitle title: String) -> CatergoryButtonView {
        let buttonView = CatergoryButtonView(frame: .zero)
        buttonView.updateTitle(title)
        buttonView.delegate = self
        return buttonView
    }

    private func resetStackView() {
        self.categoryButtons.forEach {
            self.categoryStackView.removeArrangedSubview($0)
            $0.removeFromSuperview()
        }
        self.categoryButtons = []
    }

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupCategoryStackView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .clear
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.categoryStackView)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 18.0, weight: .bold)
            $0.textColor = .white2
            $0.text = "Your insight"
        }
    }

    private func setupCategoryStackView() {
        self.categoryStackView.snp.makeConstraints {
            $0.height.equalTo(28.0)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(18.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.greaterThanOrEqualToSuperview().inset(20.0)
        }

        self.categoryStackView.do {
            $0.axis = .horizontal
            $0.spacing = 8.0
        }
    }

    private var selectedCategory: Int = .zero
    private var categories: [String] = []
    private var categoryButtons: [CatergoryButtonView] = []

    private let titleLabel = UILabel(frame: .zero)
    private let categoryStackView = UIStackView(frame: .zero)
}

extension HomeInsightTableViewHeaderView: HomeInsightCatergoryButtonViewDelegate {

    fileprivate func catergoryButtonView(_ view: HomeInsightTableViewHeaderView.CatergoryButtonView, didTapCategory tag: Int) {
        self.delegate?.homeInsightTableViewHeaderView(self, didTapCategory: tag)

        self.categoryButtons[safe: self.selectedCategory]?.updateUI(isSelected: false)
        self.selectedCategory = tag
        self.categoryButtons[safe: self.selectedCategory]?.updateUI(isSelected: true)
    }
}

/*
extension HomeInsightTableViewHeaderView: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.categories.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(HomeInsightTableViewHeaderViewCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell(frame: .zero) }
        if let data = self.categories[safe: indexPath.item] {
            //cell.updateData(data)
        }
        return cell
    }
}

extension HomeInsightTableViewHeaderView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CollectionViewLayout.default.itemSize
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        CollectionViewLayout.default.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CollectionViewLayout.default.lineSpacing
    }

}

private extension HomeInsightTableViewHeaderView {

    struct CollectionViewLayout {

        static let `default` = CollectionViewLayout(insets: .init(top: .zero,
                                                                  left: 20.0,
                                                                  bottom: .zero,
                                                                  right: 20.0),
                                                    lineSpacing: 8.0,
                                                    itemSize: .init(width: 60.0,
                                                                    height: 28.0))

        let insets: UIEdgeInsets
        let lineSpacing: CGFloat
        let itemSize: CGSize
    }
}
*/

private extension HomeInsightTableViewHeaderView {

    class CatergoryButtonView: UIView {

        weak var delegate: HomeInsightCatergoryButtonViewDelegate?

        override init(frame: CGRect) {
            super.init(frame: frame)
            self.setupUI()
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }

        func updateTitle(_ title: String) {
            self.titleLabel.text = title
        }

        func updateUI(isSelected: Bool) {
            self.borderView.isHidden = isSelected == false
            self.checkIconImageView.isHidden = isSelected == false
            self.titleLabel.textColor = isSelected ? .blue : .white2
            self.titleLabel.font = isSelected ?
                .systemFont(ofSize: 14.0, weight: .semibold) :
                .systemFont(ofSize: 14.0)
        }

        @objc private func didTapButton(_ sender: UIButton) {
            self.delegate?.catergoryButtonView(self, didTapCategory: self.tag)
        }

        private func setupUI() {
            self.setupProperties()
            self.setupViewHierarchy()
            self.setupBorderView()
            self.setupContainerView()
            self.setupStackView()
            self.setupTitleLabel()
            self.setupCheckIconImageView()
            self.setupButton()
        }

        private func setupProperties() {
            self.snp.makeConstraints {
                $0.height.equalTo(self.height)
            }

            self.do {
                $0.backgroundColor = .clear
                $0.backgroundColor = .clear
            }
        }

        private func setupViewHierarchy() {
            self.addSubview(self.borderView)
            self.addSubview(self.containerView)

            self.containerView.do {
                $0.addSubview(self.stackView)
                $0.addSubview(self.button)
            }

            self.stackView.do {
                $0.addArrangedSubview(self.titleLabel)
                $0.addArrangedSubview(self.checkIconImageView)
            }
        }

        private func setupBorderView() {
            self.borderView.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }

            self.borderView.do {
                $0.isHidden = true
                $0.clipsToBounds = true
                $0.backgroundColor = .blue
                $0.layer.cornerRadius = self.height / 2.0
            }
        }

        private func setupContainerView() {
            self.containerView.snp.makeConstraints {
                let margin: CGFloat = 1.0
                $0.top.leading.equalTo(self.borderView).offset(margin)
                $0.bottom.trailing.equalTo(self.borderView).offset(-margin)
            }

            self.containerView.do {
                $0.clipsToBounds = true
                $0.backgroundColor = .black1
                $0.layer.cornerRadius = (self.height - 2.0) / 2.0
            }
        }

        private func setupStackView() {
            self.stackView.snp.makeConstraints {
                $0.centerY.equalToSuperview()
                $0.leading.trailing.equalToSuperview().inset(8.0)
            }

            self.stackView.do {
                $0.axis = .horizontal
                $0.spacing = 1.0
            }
        }

        private func setupTitleLabel() {
            self.titleLabel.snp.makeConstraints {
                $0.height.equalTo(18.0)
            }

            self.titleLabel.do {
                $0.font = .systemFont(ofSize: 14.0)
                $0.textColor = .white1
            }
        }

        private func setupCheckIconImageView() {
            self.checkIconImageView.snp.makeConstraints {
                $0.size.equalTo(12.0)
            }

            self.checkIconImageView.do {
                $0.isHidden = true
            }
        }

        private func setupButton() {
            self.button.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }

            self.button.do {
                $0.isExclusiveTouch = true
                $0.addTarget(self, action: #selector(self.didTapButton), for: .touchUpInside)
            }
        }

        private let height: CGFloat = 28.0

        private let borderView = UIView(frame: .zero)
        private let containerView = UIView(frame: .zero)
        private let stackView = UIStackView(frame: .zero)
        private let titleLabel = UILabel(frame: .zero)
        private let checkIconImageView = UIImageView(image: UIImage(named: "Check_Big"))
        private let button = UIButton(frame: .zero)
    }
}

private protocol HomeInsightCatergoryButtonViewDelegate: AnyObject {
    func catergoryButtonView(_ view: HomeInsightTableViewHeaderView.CatergoryButtonView, didTapCategory tag: Int)
}
