//
//  ContentDataModel.swift
//  PODO
//
//  Created by Ethan on 2023/03/12.
//

import Foundation

struct ContentDataModel {

    private(set) var data: ArticleData

    var sectionTypes: [ContentViewModel.SectionType] {
        var sectionTypes: [ContentViewModel.SectionType] = [.content, .authorInfo]

        if self.data.translator != nil {
            sectionTypes.append(.translatorInfo)
        }
        if self.data.contributors?.isEmpty == false {
            sectionTypes.append(.contributorInfo)
        }

        return sectionTypes
    }

    init(data: ArticleData) {
        self.data = data
    }
}
