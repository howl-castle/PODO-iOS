//
//  SettingViewModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/13.
//

import Combine
import UIKit

final class SettingViewModel {

    var fetchCompletionPublihser: AnyPublisher<Void, Never> {
        self.fetchCompletionSubject.eraseToAnyPublisher()
    }

    init() {
        Task {
            await self.requestAPI()

            await MainActor.run {
                self.fetchCompletionSubject.send(())
            }
        }
    }

    private func requestAPI() async {
        let data = await self.repository.fetchSetting()
        self.model = SettingDataModel(data: data ?? .mock)
    }

    private func setupSections() {
        // 데이터 확인 후, 섹션 설정
        //self.sections = SectionType.allCases
    }

    private var rows: [RowType] = RowType.allCases
    private var model: SettingDataModel?

    private let repository = TabRepository()
    private let fetchCompletionSubject = PassthroughSubject<Void, Never>()
}

// MARK: - API Request
extension SettingViewModel {
}

// MARK: - UI Setting Data
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

// MARK: - RowType
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
