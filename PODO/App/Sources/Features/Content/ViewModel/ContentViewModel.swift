//
//  ContentViewModel.swift
//  PODO
//
//  Created by Yun on 2023/03/05.
//

import UIKit

final class ContentViewModel {

    init(data: ArticleData) {
        self.model = ContentDataModel(data: data)
        self.sections = self.model.sectionTypes
    }

    private var sections: [SectionType]
    private let model: ContentDataModel
}

// MARK: UI Setting Data
extension ContentViewModel {

    static var cellTypes: [UITableViewCell.Type] {
        SectionType.allCases.map { $0.cellType }
    }

    static var headerTypes: [UITableViewHeaderFooterView.Type] {
        SectionType.allCases.compactMap { $0.headerViewType }
    }

    static var footerTypes: [UITableViewHeaderFooterView.Type] {
        SectionType.allCases.compactMap { $0.footerViewType }
    }

    var contentHeaderData: ContentHeaderData {
        ContentHeaderData(user: self.model.data.author,
                          title: self.model.data.title,
                          summary: self.model.data.summary,
                          date: self.model.data.createdAt,
                          isBookmarked: self.model.data.isBookmarked)
    }

    var contentCount: Int { self.model.data.contents?.count ?? .zero }
    var imageCount: Int { self.model.data.imagePaths?.count ?? .zero }
    var numberOfSections: Int { self.sections.count }

    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let type = self.sections[safe: section] else { return .zero }

        switch type {
        case .content:          return self.model.data.contents?.count ?? .zero
        case .authorInfo:       return 1
        case .translatorInfo:   return self.model.data.translator != nil ? 1 : .zero
        case .contributorInfo:  return self.model.data.contributors?.count ?? .zero
        }
    }

    func heightForRowInSection(_ section: Int) -> CGFloat {
        guard let type = self.sections[safe: section] else { return .leastNonzeroMagnitude }
        return type.heightForRow
    }

    func heightForHeaderInSection(_ section: Int) -> CGFloat {
        guard let type = self.sections[safe: section] else { return .leastNonzeroMagnitude }
        return type.heightForHeader
    }

    func heightForFooterInSection(_ section: Int) -> CGFloat {
        guard let type = self.sections[safe: section] else { return .leastNonzeroMagnitude }

        if type == .translatorInfo && self.shouldShowTranslatorFooter {
            return SectionType.contributorInfo.heightForFooter
        }
        return type.heightForFooter
    }

    func cellTypeForSection(_ section: Int) -> UITableViewCell.Type? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.cellType
    }

    func headerViewTypeForSection(_ section: Int) -> UITableViewHeaderFooterView.Type? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.headerViewType
    }

    func footerViewTypeForSection(_ section: Int) -> UITableViewHeaderFooterView.Type? {
        guard let type = self.sections[safe: section] else { return nil }

        if type == .translatorInfo && self.shouldShowTranslatorFooter {
            return SectionType.contributorInfo.footerViewType
        }
        return type.footerViewType
    }

    func headerTitleForSection(_ section: Int) -> String? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.headerTitle
    }

    func footerTitleForSection(_ section: Int) -> String? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.footerTitle
    }

    func footerIconImageForSection(_ section: Int) -> UIImage? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.footerIconImage
    }

    func footerNameForSection(_ section: Int) -> String? {
        guard let type = self.sections[safe: section] else { return nil }

        switch type {
        case .content:
            return nil
        case .authorInfo:
            return self.model.data.author?.name
        case .translatorInfo:
            return nil
        case .contributorInfo:
            return nil
        }
    }

    func contentForIndex(_ index: Int) -> String? {
        self.model.data.contents?[safe: index]
    }

    func userInfoForIndexPath(_ indexPath: IndexPath) -> UserData? {
        guard let type = self.sections[safe: indexPath.section] else { return nil }

        switch type {
        case .content:
            return nil
        case .authorInfo:
            return self.model.data.author
        case .translatorInfo:
            return self.model.data.translator
        case .contributorInfo:
            return self.model.data.contributors?[safe: indexPath.row]
        }
    }

    func imagePathForIndex(_ index: Int) -> String? {
        self.model.data.imagePaths?[safe: index]
    }

    func canSelectForSection(_ section: Int) -> Bool {
        guard let type = self.sections[safe: section] else { return false }
        return type.canSelectTabelViewCell
    }

    private var shouldShowTranslatorFooter: Bool {
        self.model.data.contributors == nil || self.model.data.contributors?.isEmpty == true
    }
}

// MARK: API Request
extension ContentViewModel {
}

extension ContentViewModel {

    enum SectionType: Int, CaseIterable {
        case content
        case authorInfo
        case translatorInfo
        case contributorInfo
    }

    struct ContentHeaderData {
        let user: UserData?
        let title: String?
        let summary: String?
        let date: String?
        let isBookmarked: Bool?
    }
}

private extension ContentViewModel.SectionType {

    var headerTitle: String? {
        switch self {
        case .content:          return nil
        case .authorInfo:       return "Author"
        case .translatorInfo:   return "Translator"
        case .contributorInfo:  return "Contributor"
        }
    }

    var footerTitle: String? {
        switch self {
        case .content:          return "Your support is greatly appreciated!"
        case .authorInfo:       return "Get expert advice from "
        case .translatorInfo:   return nil
        case .contributorInfo:  return "Send my opinion to this article"
        }
    }

    var footerIconImage: UIImage? {
        switch self {
        case .content:          return nil
        case .authorInfo:       return UIImage(named: "Users")
        case .translatorInfo:   return nil
        case .contributorInfo:  return UIImage(named: "coffee on")
        }
    }

    var cellType: UITableViewCell.Type {
        switch self {
        case .content:          return ContentTableViewCell.self
        case .authorInfo:       fallthrough
        case .translatorInfo:   fallthrough
        case .contributorInfo:  return ContentUserInfoTableViewCell.self
        }
    }

    var headerViewType: UITableViewHeaderFooterView.Type? {
        switch self {
        case .content:          return ContentTableViewHeaderView.self
        case .authorInfo:       fallthrough
        case .translatorInfo:   fallthrough
        case .contributorInfo:  return ContentUserInfoTableViewHeaderView.self
        }
    }

    var footerViewType: UITableViewHeaderFooterView.Type? {
        switch self {
        case .content:          return ContentTableViewFooterView.self
        case .authorInfo:       return ContentUserInfoTableViewFooterView.self
        case .translatorInfo:   return nil
        case .contributorInfo:  return ContentUserInfoTableViewFooterView.self
        }
    }

    var heightForRow: CGFloat {
        switch self {
        case .content:          return UITableView.automaticDimension
        case .authorInfo:       fallthrough
        case .translatorInfo:   fallthrough
        case .contributorInfo:  return 70.0
        }
    }

    var heightForHeader: CGFloat {
        switch self {
        case .content:          return UITableView.automaticDimension
        case .authorInfo:       fallthrough
        case .translatorInfo:   fallthrough
        case .contributorInfo:  return 34.0
        }
    }

    var heightForFooter: CGFloat {
        switch self {
        case .content:          return 76.0
        case .authorInfo:       return 58.0
        case .translatorInfo:   return .leastNonzeroMagnitude
        case .contributorInfo:  return 58.0
        }
    }


    var canSelectTabelViewCell: Bool {
        switch self {
        case .content:          return false
        case .authorInfo:       fallthrough
        case .translatorInfo:   fallthrough
        case .contributorInfo:  return true
        }
    }
}
