//
//  ExpertTrendingTableViewCell.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class ExpertTrendingTableViewCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func updateData(_ data: [QuestionData]) {
        self.questions = data
        self.collectionView.reloadData()
        self.collectionView.collectionViewLayout.invalidateLayout()
    }

    @objc private func didTapWriteButton(_ sender: UIButton) {

    }

    private var questions: [QuestionData] = []

    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let writeButton = UIButton(frame: .zero)
    private let collectionView = UICollectionView(frame: .zero,
                                                  collectionViewLayout: UICollectionViewFlowLayout())
}

// MARK: - CollectionView DataSource
extension ExpertTrendingTableViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.questions.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(ExperTrendingCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell(frame: .zero) }
        if let data = self.questions[safe: indexPath.item] {
            cell.updateData(data)
        }
        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension ExpertTrendingTableViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = CollectionViewLayout.default.calculateItemWidth(fromWidth: collectionView.bounds.width)
        return CGSize(width: width, height: collectionView.bounds.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        CollectionViewLayout.default.insets
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        CollectionViewLayout.default.lineSpacing
    }
}

// MARK: - CollectionView Layout
private extension ExpertTrendingTableViewCell {

    struct CollectionViewLayout {

        static let `default` = CollectionViewLayout(insets: .init(top: .zero,
                                                                  left: 20.0,
                                                                  bottom: .zero,
                                                                  right: 20.0),
                                                    lineSpacing: 10.0)

        let insets: UIEdgeInsets
        let lineSpacing: CGFloat
    }
}

private extension ExpertTrendingTableViewCell.CollectionViewLayout {

    func calculateItemWidth(fromWidth width: CGFloat) -> CGFloat {
        let margin = self.insets.left * 2
        let width = width - margin
        return width
    }
}

// MARK: - Setup
extension ExpertTrendingTableViewCell {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupTitleLabel()
        self.setupSubtitleLabel()
        self.setupWriteButton()
        self.setupCollectionView()
    }

    private func setupProperties() {
        self.do {
            $0.backgroundColor = .clear
            $0.contentView.backgroundColor = .blue
        }
    }

    private func setupViewHierarchy() {
        self.contentView.do {
            $0.addSubview(self.titleLabel)
            $0.addSubview(self.subtitleLabel)
            $0.addSubview(self.writeButton)
            $0.addSubview(self.collectionView)
        }
    }

    private func setupTitleLabel() {
        self.titleLabel.snp.makeConstraints {
            $0.height.equalTo(22.0)
            $0.top.equalToSuperview().inset(20.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalTo(self.writeButton.snp.leading).offset(34.0)
        }

        self.titleLabel.do {
            $0.font = .systemFont(ofSize: 20.0, weight: .bold)
            $0.textColor = .white1
            $0.text = "Expert"
        }
    }

    private func setupSubtitleLabel() {
        self.subtitleLabel.snp.makeConstraints {
            $0.height.equalTo(17.0)
            $0.top.equalTo(self.titleLabel.snp.bottom).offset(4.0)
            $0.leading.equalToSuperview().inset(20.0)
            $0.trailing.equalTo(self.writeButton.snp.leading).offset(34.0)
        }

        self.subtitleLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .medium)
            $0.textColor = .white2
            $0.text = "Check out the new answer!"
        }
    }

    private func setupWriteButton() {
        let size: CGFloat = 36.0
        self.writeButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.equalToSuperview().inset(20.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.writeButton.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .orange
            $0.layer.cornerRadius = size / 2.0
            $0.setImage(UIImage(named: "Edit_Line"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapWriteButton), for: .touchUpInside)
        }
    }

    private func setupCollectionView() {
        self.collectionView.snp.makeConstraints {
            $0.height.equalTo(158.0)
            $0.top.equalTo(self.subtitleLabel.snp.bottom).offset(18.0)
            $0.leading.trailing.equalToSuperview()
        }

        self.collectionView.do {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.dataSource = self
            $0.delegate = self
            $0.register(cell: ExperTrendingCollectionViewCell.self)

            let flowLayout = $0.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .horizontal
        }
    }
}
