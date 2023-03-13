//
//  SettingViewModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/13.
//

import UIKit

final class SettingViewModel {

    init() {
        // api call
    }

    private func setupSections() {
        // 데이터 확인 후, 섹션 설정
        //self.sections = SectionType.allCases
    }

    private var rows: [RowType] = RowType.allCases
}

// MARK: UI Setting Data
extension SettingViewModel {

    var headerType: SettingTableViewHeaderView.Type {
        SettingTableViewHeaderView.self
    }

    var cellType: SettingTableViewCell.Type {
        SettingTableViewCell.self
    }

    var cellHeight: CGFloat {
        SettingTableViewCell.height
    }

    var headerHeight: CGFloat {
        SettingTableViewHeaderView.height
    }

    var numberOfRows: Int {  self.rows.count }

    func titleForRow(_ row: Int) -> String? {
        guard let type = self.rows[safe: row] else { return nil }
        return type.title
    }

}

// MARK: API Request
extension SettingViewModel {
}

extension SettingViewModel {

    enum RowType: Int, CaseIterable {
        case language
        case notice
        case logout
    }
}

private extension SettingViewModel.RowType {

    var title: String {
        switch self {
        case .language: return "Language Setting"
        case .notice:   return "Notice"
        case .logout:   return "Log out"
        }
    }
}