//
//  ExpertDetailViewModel.swift
//  PODO
//
//  Created by Yun on 2023/03/17.
//

import UIKit

final class ExpertDetailViewModel {

    init(data: QuestionData) {
        self.model = ExpertDetailDataModel(data: data)
        self.sections = self.makeSections()
    }

    private func makeSections() -> [SectionType] {
        var sections: [SectionType] = [.question]

        if let answers = self.model.data.answers,
           answers.isEmpty == false {
            sections.append(.answer)
        }

        return sections
    }

    private var sections: [SectionType] = []
    private let model: ExpertDetailDataModel
}

// MARK: - API Request
extension ExpertDetailViewModel {
}

// MARK: - UI Setting Data
extension ExpertDetailViewModel {

    static var cellTypes: [UITableViewCell.Type] {
        SectionType.allCases.map { $0.cellType }
    }

    var numberOfSections: Int { self.sections.count }

    func numberOfRowsInSection(_ section: Int) -> Int {
        guard let type = self.sections[safe: section] else { return .zero }

        switch type {
        case .question: return 1
        case .answer:   return self.model.data.answers?.count ?? .zero
        }
    }

    func cellTypeForSection(_ section: Int) -> UITableViewCell.Type? {
        guard let type = self.sections[safe: section] else { return nil }
        return type.cellType
    }
}

// MARK: - SectionType
extension ExpertDetailViewModel {

    enum SectionType: Int, CaseIterable {
        case question
        case answer
    }
}

private extension ExpertDetailViewModel.SectionType {

    var cellType: UITableViewCell.Type {
        switch self {
        case .question: return ExpertDetailQuestionTableViewCell.self
        case .answer:   return ExpertDetailAnswerTableViewCell.self
        }
    }
}
