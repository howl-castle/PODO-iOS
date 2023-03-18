//
//  ContentViewController.swift
//  PODO
//
//  Created by Ethan on 2023/02/22.
//

import UIKit
import SnapKit
import Then

final class ContentViewController: UIViewController {

    init(data: ArticleData) {
        self.viewModel = ContentViewModel(data: data)
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

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)

        coordinator.animate(alongsideTransition: { context in
            self.updateLayoutForTransition(isPortrait: size.height > size.width)
        }, completion: { _ in
        })
    }

    private func updateLayoutForTransition(isPortrait: Bool) {
        self.updateContentLayoutForTransition(isPortrait: isPortrait)
        self.updateContentOverlayLayoutForTransition(isPortrait: isPortrait)
        self.updateCollecionViewLayoutForTransition()
    }

    private func updateCollecionViewLayoutForTransition() {
        let contentOffset = self.imageCollectionView.contentOffset
        if contentOffset.x < self.imageCollectionView.bounds.width / 2.0 {
            self.imageCollectionView.contentOffset = .zero
        }
    }

    private func updateContentLayoutForTransition(isPortrait: Bool) {
        if isPortrait {
            self.contentContainerView.snp.remakeConstraints {
                $0.top.equalTo(self.imageContainerView.snp.bottom).offset(-44.0)
                $0.bottom.equalToSuperview()
                $0.leading.trailing.equalToSuperview()
            }

            self.contentContainerView.do {
                $0.layer.cornerRadius = 22.0
                $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
            }

            self.contentTableView.do {
                $0.insetsContentViewsToSafeArea = true
            }
        } else {
            self.contentContainerView.snp.remakeConstraints {
                $0.top.bottom.equalToSuperview()
                $0.leading.equalTo(self.imageContainerView.snp.trailing)
                $0.trailing.equalToSuperview()
            }

            self.contentContainerView.do {
                $0.layer.cornerRadius = .zero
            }

            self.contentTableView.do {
                $0.insetsContentViewsToSafeArea = false
            }
        }
    }

    private func updateContentOverlayLayoutForTransition(isPortrait: Bool) {
        if isPortrait {
            self.floatingButtonContainerView.snp.remakeConstraints {
                let size: CGFloat = 50.0
                $0.height.equalTo(size)
                $0.centerX.equalToSuperview()
                $0.bottom.equalTo(self.playerContainerView.snp.top).offset(-16.0)
            }

            self.floatingButtonSeperateView.snp.remakeConstraints {
                let margin: CGFloat = 8.0
                $0.width.equalTo(1.0)
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(margin)
                $0.bottom.equalToSuperview().inset(-margin)
            }

            self.bookmarkButton.snp.remakeConstraints {
                let size: CGFloat = 34.0
                $0.size.equalTo(size)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(8.0)
                $0.trailing.equalTo(self.floatingButtonSeperateView.snp.leading).offset(-12.0)
            }

            self.sendMessageButton.snp.remakeConstraints {
                let size: CGFloat = 34.0
                $0.size.equalTo(size)
                $0.centerY.equalToSuperview()
                $0.leading.equalTo(self.floatingButtonSeperateView.snp.trailing).offset(12.0)
                $0.trailing.equalToSuperview().inset(8.0)
            }
        } else {
            self.floatingButtonContainerView.snp.remakeConstraints {
                let size: CGFloat = 50.0
                $0.width.equalTo(size)
                $0.bottom.equalTo(self.playerContainerView.snp.top).offset(-24.0)
                $0.trailing.equalToSuperview().inset(20.0)
            }

            self.floatingButtonSeperateView.snp.remakeConstraints {
                let margin: CGFloat = 8.0
                $0.height.equalTo(1.0)
                $0.centerY.equalToSuperview()
                $0.leading.equalToSuperview().inset(margin)
                $0.trailing.equalToSuperview().inset(-margin)
            }

            self.bookmarkButton.snp.remakeConstraints {
                let size: CGFloat = 34.0
                $0.size.equalTo(size)
                $0.centerX.equalToSuperview()
                $0.top.equalToSuperview().inset(8.0)
                $0.bottom.equalTo(self.floatingButtonSeperateView.snp.top).offset(-12.0)
            }

            self.sendMessageButton.snp.remakeConstraints {
                let size: CGFloat = 34.0
                $0.size.equalTo(size)
                $0.centerX.equalToSuperview()
                $0.top.equalTo(self.floatingButtonSeperateView.snp.bottom).offset(12.0)
                $0.bottom.equalToSuperview().inset(8.0)
            }
        }
    }

    @objc private func didTapCloseButton(_ sender: UIButton) {
        self.dismiss(animated: true)
    }

    @objc private func didTapShowLeftImageButton(_ sender: UIButton) {
        guard self.currentImageIndex > 0 else { return }

        self.currentImageIndex = self.currentImageIndex - 1

        if self.currentImageIndex == .zero {
            self.leftButton.isEnabled = false
        } else if self.currentImageIndex == self.viewModel.imageCount - 2 {
            self.rightButton.isEnabled = true
        }
        self.updateImageIndex()
    }

    @objc private func didTapShowRightImageButton(_ sender: UIButton) {
        let count = self.viewModel.imageCount
        guard count - 1 > self.currentImageIndex else { return }

        self.currentImageIndex = self.currentImageIndex + 1

        if self.currentImageIndex == count - 1 {
            self.rightButton.isEnabled = false
        } else if self.currentImageIndex == 1 {
            self.leftButton.isEnabled = true
        }
        self.updateImageIndex()
    }

    @objc private func didTapPlayPauseButton(_ sender: UIButton) {
        if self.speechSynthesizer.isPaused {
            self.updatePlayerButtonEnableState()
            self.speechSynthesizer.resume()
            self.playPauseButton.isSelected = true
        } else if self.speechSynthesizer.isSpeaking {
            self.updatePlayerButtonEnableState()
            self.speechSynthesizer.pause()
            self.playPauseButton.isSelected = false
        } else {
            self.updatePlayerButtonEnableState()
            self.startSpeech()
            self.playPauseButton.isSelected = true
        }
    }

    @objc private func didTapRewindButton(_ sender: UIButton) {
        guard self.speechSynthesizer.isSpeaking else { return }
        guard self.currentPlayIndex > .zero     else { return }

        self.currentPlayIndex = self.currentPlayIndex - 1

        if self.currentPlayIndex == .zero {
            self.rewindButton.isEnabled = false
        } else if self.currentPlayIndex == self.viewModel.contentCount - 2 {
            self.fastForwardButton.isEnabled = true
        }
        self.startSpeech()
    }

    @objc private func didTapFastButton(_ sender: UIButton) {
        guard self.speechSynthesizer.isSpeaking else { return }

        let count = self.viewModel.contentCount
        guard count - 1 > self.currentPlayIndex else { return }

        self.currentPlayIndex = self.currentPlayIndex + 1

        if self.currentPlayIndex == count - 1 {
            self.fastForwardButton.isEnabled = false
        } else if self.currentPlayIndex == 1 {
            self.rewindButton.isEnabled = true
        }
        self.startSpeech()
    }

    @objc private func didTapLockButton(_ sender: UIButton) {
        let popup = CommonPopupViewController()
        popup.delegate = self
        self.present(popup, animated: false)
    }

    private func updatePlayerButtonEnableState() {
        let count = self.viewModel.contentCount

        if self.currentPlayIndex == count - 1 {
            self.fastForwardButton.isEnabled = false
            self.rewindButton.isEnabled = true
        } else if self.currentPlayIndex == .zero {
            self.rewindButton.isEnabled = false
            self.fastForwardButton.isEnabled = true
        } else {
            self.rewindButton.isEnabled = true
            self.fastForwardButton.isEnabled = true
        }
    }

    private func startSpeech() {
        guard let script = self.viewModel.contentForIndex(self.currentPlayIndex) else { return }
        self.speechSynthesizer.stop()
        self.speechSynthesizer.start(script: script)
        self.playPauseButton.isSelected = true
        self.contentTableView.scrollToRow(at: IndexPath(row: self.currentPlayIndex, section: .zero), at: .top, animated: true)
    }

    private func updateImageIndex() {
        let count = self.viewModel.imageCount
        self.pageCountLabel.text = "\(self.currentImageIndex + 1)/\(count)"

        self.imageCollectionView.scrollToItem(at: IndexPath(item: self.currentImageIndex, section: .zero),
                                              at: .centeredHorizontally, animated: true)
    }

    private lazy var speechSynthesizer: SpeechSynthesizer = {
        let synthesizer = SpeechSynthesizer()
        synthesizer.delegate = self
        return synthesizer
    }()

    private var tableViewContentInsets: UIEdgeInsets {
        let safeAreaBottom = self.view.safeAreaInsets.bottom
        let bottomInsets = self.playerContainerViewHeight + self.floatingButtonHeight + safeAreaBottom
        return UIEdgeInsets(top: .zero, left: .zero, bottom: bottomInsets, right: .zero)
    }

    private var currentImageIndex: Int = .zero
    private var currentPlayIndex: Int = .zero

    private let floatingButtonHeight: CGFloat = 50.0
    private let playerContainerViewHeight: CGFloat = 65.0
    private let viewModel: ContentViewModel

    // TODO: Optional 로 변경
    private let imageContainerView = UIView(frame: .zero)
    private let imageCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
    //
    private let imageOverlayView = UIView(frame: .zero)
    private let closeButton = UIButton(frame: .zero)
    private let leftButton = UIButton(frame: .zero)
    private let rightButton = UIButton(frame: .zero)
    private let pageCountContainerView = UIView(frame: .zero)
    private let pageCountLabel = UILabel(frame: .zero)

    private let contentContainerView = UIView(frame: .zero)
    private let contentTableView = UITableView(frame: .zero, style: .grouped)
    private let contentBottomBackgroundView = UIView(frame: .zero)
    //
    private let contentOverlayView = UIView(frame: .zero)
        //
    // TODO: View 분리 시키기
    private let playerContainerView = UIView(frame: .zero)
    private let playPauseButton = UIButton(frame: .zero)
    private let rewindButton = UIButton(frame: .zero)
    private let fastForwardButton = UIButton(frame: .zero)
        //
    // TODO: View 분리 시키기
    private let floatingButtonContainerView = UIView(frame: .zero)
    private let floatingButtonSeperateView = UIView(frame: .zero)
    private let bookmarkButton = UIButton(frame: .zero)
    private let sendMessageButton = UIButton(frame: .zero)
    private let contentOverlayBottomView = UIView(frame: .zero)

    private let lockContainerView = UIView(frame: .zero)
    private let lockImageView = UIImageView(image: UIImage(named: "lockIcon"))
    private let lockDimView = UIImageView(image: UIImage(named: "dimImage"))
    private let lockLabel = UILabel(frame: .zero)
    private let lockButton = UIButton(frame: .zero)
}

// MARK: - CollectionView DataSource
extension ContentViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.viewModel.imageCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(ContentCollectionViewCell.self, for: indexPath) else { return UICollectionViewCell(frame: .zero) }

        let imagePath = self.viewModel.imagePathForIndex(indexPath.item)
        let icon = self.viewModel.imagePathForIcon(indexPath.item)
        cell.updateImage(path: imagePath, icon: icon)

        return cell
    }
}

// MARK: - CollectionView DelegateFlowLayout
extension ContentViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        collectionView.bounds.size
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        .zero
    }
}

// MARK: - TableView DataSource
extension ContentViewController: UITableViewDataSource {

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.updateContentOverlayLayout(fromScrollView: scrollView)
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard scrollView == self.contentTableView else { return }
        UIView.animate(withDuration: 0.2) {
            self.contentOverlayView.snp.updateConstraints {
                let contentSize = scrollView.contentSize.height - scrollView.frame.size.height - self.tableViewContentInsets.bottom
                if scrollView.contentOffset.y >= contentSize || velocity.y < .zero {
                    $0.bottom.equalToSuperview()
                } else {
                    let height = self.contentOverlayView.bounds.height
                    $0.bottom.equalToSuperview().offset(height)
                }
            }
            self.view.layoutIfNeeded()
        }
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.updateContentOverlayLayout(fromScrollView: scrollView)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        self.viewModel.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.viewModel.numberOfRowsInSection(section)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cellType = self.viewModel.cellTypeForSection(indexPath.section) else {
            return UITableViewCell()
        }

        guard let cell = tableView.dequeueReusableCell(cellType, for: indexPath)  else {
            return UITableViewCell()
        }

        self.configureCell(cell, atIndexPath: indexPath)
        cell.selectionStyle = .none
        return cell
    }

    private func configureCell(_ cell: UITableViewCell, atIndexPath indexPath: IndexPath) {
        if let cell = cell as? ContentTableViewCell {
            guard let data = self.viewModel.contentForIndex(indexPath.row) else { return }
            cell.updateContent(data)
        } else if let cell = cell as? ContentUserInfoTableViewCell {
            guard let data = self.viewModel.userInfoForIndexPath(indexPath) else { return }
            cell.updateData(data)
        }
    }

    private func updateContentOverlayLayout(fromScrollView scrollView: UIScrollView) {
        guard scrollView == self.contentTableView else { return }
        let contentSize = scrollView.contentSize.height - scrollView.frame.size.height - self.tableViewContentInsets.bottom
        if scrollView.contentOffset.y >= contentSize {
            UIView.animate(withDuration: 0.2) {
                self.contentOverlayView.snp.updateConstraints {
                    $0.bottom.equalToSuperview()
                }
                self.view.layoutIfNeeded()
            }
        }
    }
}

// MARK: - TableView Delegate
extension ContentViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        guard self.viewModel.canSelectForSection(indexPath.section) else { return }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        self.viewModel.heightForRowInSection(indexPath.section)
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        self.viewModel.heightForHeaderInSection(section)
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        self.viewModel.heightForFooterInSection(section)
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let viewType = self.viewModel.headerViewTypeForSection(section) else { return nil }
        guard let view = tableView.dequeueReusableHeaderFooterView(viewType)  else { return nil }
        self.configureHeaderView(view, inSection: section)
        return view
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let viewType = self.viewModel.footerViewTypeForSection(section) else { return nil }
        guard let view = tableView.dequeueReusableHeaderFooterView(viewType)  else { return nil }
        self.configureFooterView(view, inSection: section)
        return view
    }

    private func configureHeaderView(_ view: UITableViewHeaderFooterView, inSection section: Int) {
        if let view = view as? ContentTableViewHeaderView {
            let data = self.viewModel.contentHeaderData
            view.updateData(data)
        } else if let view = view as? ContentUserInfoTableViewHeaderView {
            guard let title = self.viewModel.headerTitleForSection(section) else { return }
            view.updateContent(title)
        }
    }

    private func configureFooterView(_ view: UITableViewHeaderFooterView, inSection section: Int) {
        if let view = view as? ContentUserInfoTableViewFooterView {
            guard let iconImage = self.viewModel.footerIconImageForSection(section) else { return }
            guard let title = self.viewModel.footerTitleForSection(section)         else { return }
            let name = self.viewModel.footerNameForSection(section)
            view.update(iconImage: iconImage, title: title, name: name)
        }
    }
}

// MARK: - SpeechSynthesizer Delegate
extension ContentViewController: SpeechSynthesizerDelegate {

    func speechSynthesizerDidStart(synthesizer: SpeechSynthesizer) {
    }

    func speechSynthesizerDidFinish(synthesizer: SpeechSynthesizer) {
        if self.viewModel.contentCount > self.currentPlayIndex + 1 {
            self.rewindButton.isEnabled = true
            self.currentPlayIndex = self.currentPlayIndex + 1
            self.startSpeech()
        } else {
            self.fastForwardButton.isEnabled = false
            self.playPauseButton.isSelected = false
        }
    }

    func speechSynthesizerDidContinue(synthesizer: SpeechSynthesizer) {
    }

    func speechSynthesizerDidPause(synthesizer: SpeechSynthesizer) {
    }

    func speechSynthesizerDidCancel(synthesizer: SpeechSynthesizer) {
    }
}

// MARK: - PopupView Delegate
extension ContentViewController: CommonPopupViewControllerDelegate {

    func commonPopupViewControllerDidTapConfirm(viewController: CommonPopupViewController) {
    }
}

// MARK: - Setup
extension ContentViewController {

    private func setupUI() {
        self.setupProperties()
        self.setupViewHierarchy()
        self.setupImageContainerView()
        self.setupImageCollectionView()
        //self.setupImageOverlayView()
        self.setupCloseButton()
        self.setupLeftButton()
        self.setupRightButton()
        self.setupPageCountContainerView()
        self.setupPageCountLabel()
        self.setupImageOverlayHiddenState()
        self.setupContentContainerView()
        self.setupContentBottomBackgroundView()
        self.setupContentTableView()
        self.setupContentOverlayView()
        self.setupContentOverlayBottomView()
        self.setupPlayerContainerView()
        self.setupPlayPauseButton()
        self.setupRewindButton()
        self.setupFastForwardButton()
        self.setupPlayerHiddenState()
        self.setupFloatingButtonContainerView()
        self.setupFloatingButtonSeperateView()
        self.setupBookmarkButton()
        self.setupSendMessageButton()
        self.setupLockContainerView()
        self.setupLockDimView()
        self.setupLockImageView()
        self.setupLockLabel()
        self.setupLockButton()
    }

    private func setupProperties() {
        self.view.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupViewHierarchy() {
        self.view.do {
            $0.addSubview(self.imageContainerView)
            $0.addSubview(self.contentContainerView)
        }

        self.imageContainerView.do {
            $0.addSubview(self.imageCollectionView)
            //$0.addSubview(self.imageOverlayView)

            $0.addSubview(self.closeButton)
            $0.addSubview(self.leftButton)
            $0.addSubview(self.rightButton)
            $0.addSubview(self.pageCountContainerView)
        }

        /*
        self.imageOverlayView.do {
            $0.addSubview(self.closeButton)
            $0.addSubview(self.leftButton)
            $0.addSubview(self.rightButton)
            $0.addSubview(self.pageCountContainerView)
        }
        */

        self.pageCountContainerView.do {
            $0.addSubview(self.pageCountLabel)
        }

        self.contentContainerView.do {
            $0.addSubview(self.contentBottomBackgroundView)
            $0.addSubview(self.contentTableView)
            $0.addSubview(self.contentOverlayView)
            $0.addSubview(self.lockContainerView)
        }

        self.contentOverlayView.do {
            $0.addSubview(self.playerContainerView)
            $0.addSubview(self.floatingButtonContainerView)
            $0.addSubview(self.contentOverlayBottomView)
        }

        self.playerContainerView.do {
            $0.addSubview(self.playPauseButton)
            $0.addSubview(self.rewindButton)
            $0.addSubview(self.fastForwardButton)
        }

        self.floatingButtonContainerView.do {
            $0.addSubview(self.floatingButtonSeperateView)
            $0.addSubview(self.bookmarkButton)
            $0.addSubview(self.sendMessageButton)
        }

        self.lockContainerView.do {
            $0.addSubview(self.lockDimView)
            $0.addSubview(self.lockImageView)
            $0.addSubview(self.lockLabel)
            $0.addSubview(self.lockButton)
        }
    }

    private func setupImageContainerView() {
        self.imageContainerView.snp.makeConstraints {
            $0.size.equalTo(self.view.bounds.width)
            $0.top.leading.equalToSuperview()
        }

        self.imageContainerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .clear
        }
    }

    private func setupImageCollectionView() {
        self.imageCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.imageCollectionView.do {
            $0.backgroundColor = .clear
            $0.showsHorizontalScrollIndicator = false
            $0.insetsLayoutMarginsFromSafeArea = false
            $0.isPagingEnabled = true
            $0.dataSource = self
            $0.delegate = self
            $0.register(cell: ContentCollectionViewCell.self)

            let flowLayout = $0.collectionViewLayout as? UICollectionViewFlowLayout
            flowLayout?.scrollDirection = .horizontal
        }
    }

    private func setupImageOverlayView() {
        self.imageOverlayView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.imageOverlayView.do {
            $0.isUserInteractionEnabled = false
        }
    }

    private func setupCloseButton() {
        let height: CGFloat = 32.0
        self.closeButton.snp.makeConstraints {
            $0.size.equalTo(height)
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.closeButton.do {
            $0.backgroundColor = .black1Opacity20
            $0.setImage(UIImage(named: "close"), for: .normal)
            $0.layer.cornerRadius = height / 2.0
            $0.addTarget(self, action: #selector(self.didTapCloseButton), for: .touchUpInside)
        }
    }

    private func setupLeftButton() {
        let height: CGFloat = 32.0
        self.leftButton.snp.makeConstraints {
            $0.size.equalTo(height)
            $0.centerY.equalToSuperview().inset(30.0)
            $0.leading.equalToSuperview().inset(20.0)
        }

        self.leftButton.do {
            $0.backgroundColor = .black1Opacity20
            $0.setImage(UIImage(named: "Left"), for: .normal)
            $0.layer.cornerRadius = height / 2.0
            $0.addTarget(self, action: #selector(self.didTapShowLeftImageButton), for: .touchUpInside)
        }
    }

    private func setupRightButton() {
        let height: CGFloat = 32.0
        self.rightButton.snp.makeConstraints {
            $0.size.equalTo(height)
            $0.centerY.equalTo(self.leftButton.snp.centerY)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.rightButton.do {
            $0.backgroundColor = .black1Opacity20
            $0.setImage(UIImage(named: "Right"), for: .normal)
            $0.layer.cornerRadius = height / 2.0
            $0.addTarget(self, action: #selector(self.didTapShowRightImageButton), for: .touchUpInside)
        }
    }

    private func setupPageCountContainerView() {
        let height: CGFloat = 25.0
        self.pageCountContainerView.snp.makeConstraints {
            $0.height.equalTo(height)
            $0.bottom.equalToSuperview().inset(68.0)
            $0.trailing.equalToSuperview().inset(20.0)
        }

        self.pageCountContainerView.do {
            $0.backgroundColor = .black1Opacity20
            $0.layer.cornerRadius = height / 2.0
        }
    }

    private func setupPageCountLabel() {
        self.pageCountLabel.snp.makeConstraints {
            $0.top.equalTo(4.0)
            $0.bottom.equalTo(-4.0)
            $0.leading.equalTo(8.0)
            $0.trailing.equalTo(-8.0)
        }

        self.pageCountLabel.do {
            $0.font = .systemFont(ofSize: 14.0, weight: .semibold)
            $0.textColor = .white1
        }
    }

    private func setupImageOverlayHiddenState() {
        let count = self.viewModel.imageCount
        if count > 1 {
            self.pageCountLabel.text = "\(self.currentImageIndex + 1)/\(count)"
            self.pageCountContainerView.isHidden = false
            self.rightButton.isHidden = false
            self.leftButton.isHidden = false
            self.leftButton.isEnabled = false
        } else {
            self.pageCountContainerView.isHidden = true
            self.rightButton.isHidden = true
            self.leftButton.isHidden = true
        }
    }

    private func setupContentContainerView() {
        self.contentContainerView.snp.makeConstraints {
            $0.top.equalTo(self.imageContainerView.snp.bottom).offset(-44.0)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        self.contentContainerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = 22.0
            $0.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMinXMinYCorner]
        }
    }

    private func setupContentBottomBackgroundView() {
        self.contentBottomBackgroundView.snp.makeConstraints {
            $0.height.equalToSuperview().multipliedBy(0.5)
            $0.bottom.leading.trailing.equalToSuperview()
        }

        self.contentBottomBackgroundView.do {
            $0.backgroundColor = .gray3
        }
    }

    private func setupContentTableView() {
        self.contentTableView.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30.0)
            $0.bottom.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
        }

        self.contentTableView.do { view in
            view.contentInset = self.tableViewContentInsets
            view.backgroundColor = .clear
            view.separatorStyle = .none
            view.dataSource = self
            view.delegate = self

            ContentViewModel.cellTypes.forEach { view.register(cell: $0)             }
            ContentViewModel.headerTypes.forEach { view.register(headerFooterView: $0) }
            ContentViewModel.footerTypes.forEach { view.register(headerFooterView: $0) }
        }
    }

    private func setupContentOverlayView() {
        self.contentOverlayView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
        }
    }

    private func setupContentOverlayBottomView() {
        self.contentOverlayBottomView.snp.makeConstraints {
            $0.bottom.leading.trailing.equalToSuperview()
            $0.top.equalTo(self.contentOverlayView.safeAreaLayoutGuide.snp.bottom)
        }

        self.contentOverlayBottomView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .black2Opacity80
        }
    }

    private func setupPlayerContainerView() {
        self.playerContainerView.snp.makeConstraints {
            $0.height.equalTo(self.playerContainerViewHeight)
            $0.bottom.equalTo(self.contentOverlayView.safeAreaLayoutGuide.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }

        self.playerContainerView.do {
            $0.backgroundColor = .black2Opacity80
        }
    }

    private func setupPlayPauseButton() {
        let size: CGFloat = 38.0
        self.playPauseButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.top.equalToSuperview().inset(14.0)
            $0.centerX.equalToSuperview()
        }

        self.playPauseButton.do {
            $0.contentMode = .center
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = size / 2.0
            $0.setImage(UIImage(named: "Play"), for: .normal)
            $0.setImage(UIImage(named: "Pause"), for: .selected)
            $0.addTarget(self, action: #selector(self.didTapPlayPauseButton), for: .touchUpInside)
        }
    }

    private func setupRewindButton() {
        let size: CGFloat = 38.0
        self.rewindButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.centerY.equalTo(self.playPauseButton.snp.centerY)
            $0.trailing.equalTo(self.playPauseButton.snp.leading).offset(-58.0)
        }

        self.rewindButton.do {
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = size / 2.0
            $0.setImage(UIImage(named: "Rewind"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapRewindButton), for: .touchUpInside)
        }
    }

    private func setupFastForwardButton() {
        let size: CGFloat = 38.0
        self.fastForwardButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.centerY.equalTo(self.playPauseButton.snp.centerY)
            $0.leading.equalTo(self.playPauseButton.snp.trailing).offset(58.0)
        }

        self.fastForwardButton.do {
            $0.backgroundColor = .black1
            $0.layer.cornerRadius = size / 2.0
            $0.setImage(UIImage(named: "Forward"), for: .normal)
            $0.addTarget(self, action: #selector(self.didTapFastButton), for: .touchUpInside)
        }
    }

    private func setupPlayerHiddenState() {
        if self.viewModel.contentCount > 1 {
            self.rewindButton.isEnabled = false
            self.fastForwardButton.isEnabled = false

            self.rewindButton.isHidden = false
            self.fastForwardButton.isHidden = false
        } else {
            self.rewindButton.isHidden = true
            self.fastForwardButton.isHidden = true
        }
    }

    private func setupFloatingButtonContainerView() {
        let size: CGFloat = self.floatingButtonHeight
        self.floatingButtonContainerView.snp.makeConstraints {
            $0.height.equalTo(size)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()
            $0.bottom.equalTo(self.playerContainerView.snp.top).offset(-16.0)
        }

        self.floatingButtonContainerView.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .black2
            $0.layer.cornerRadius = size / 2.0
        }
    }

    private func setupFloatingButtonSeperateView() {
        self.floatingButtonSeperateView.snp.makeConstraints {
            let margin: CGFloat = 8.0
            $0.width.equalTo(1.0)
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview().inset(margin)
            $0.bottom.equalToSuperview().inset(-margin)
        }

        self.floatingButtonSeperateView.do {
            $0.backgroundColor = .black1
        }
    }

    private func setupBookmarkButton() {
        let size: CGFloat = 34.0
        self.bookmarkButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(8.0)
            $0.trailing.equalTo(self.floatingButtonSeperateView.snp.leading).offset(-12.0)
        }

        self.bookmarkButton.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .orange
            $0.setImage(UIImage(named: "Bookmark"), for: .normal)
            $0.layer.cornerRadius = size / 2.0
        }
    }

    private func setupSendMessageButton() {
        let size: CGFloat = 34.0
        self.sendMessageButton.snp.makeConstraints {
            $0.size.equalTo(size)
            $0.centerY.equalToSuperview()
            $0.leading.equalTo(self.floatingButtonSeperateView.snp.trailing).offset(12.0)
            $0.trailing.equalToSuperview().inset(8.0)
        }

        self.sendMessageButton.do {
            $0.clipsToBounds = true
            $0.backgroundColor = .mint
            $0.setImage(UIImage(named: "Cursor_Right"), for: .normal)
            $0.layer.cornerRadius = size / 2.0
        }
    }

    private func setupLockContainerView() {
        self.lockContainerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.lockContainerView.do {
            $0.isHidden = true
        }
    }

    private func setupLockDimView() {
        self.lockDimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.lockDimView.do {
            $0.contentMode = .scaleToFill
        }
    }

    private func setupLockImageView() {
        self.lockImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.lockLabel.snp.top).offset(-12.0)
        }
    }

    private func setupLockLabel() {
        self.lockLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.bottom.equalTo(self.lockContainerView.safeAreaLayoutGuide.snp.bottom).offset(-60.0)
        }

        self.lockLabel.do {
            $0.text = "View all articles after payment"
        }
    }

    private func setupLockButton() {
        self.lockButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

        self.lockButton.do {
            $0.addTarget(self, action: #selector(self.didTapLockButton), for: .touchUpInside)
        }
    }
}
