# PODO-iOS
------

## Projects Hierarchy

```
 App
  │── SupportingFiles
  │── Resources
  └── Sources
        │── Manager
        │── Util
        │── CommonView
        │       └── Selection
        │── Network
        │       │── Data
        │       │    └── Tab
        │       └── API
        │── Extensions
        │        └── UIKit
        │── Features
        │       │── WebView
        │       │── Tab
        │       │    │── Home
        │       │    │     └── Notice
        │       │    │── Expert
        │       │    │     └── Write
        │       │    │── Revenue
        │       │    │     │── DoraList
        │       │    │     └── ExpertList
        │       │    └── Setting
        │       │          │── MyContentList
        │       │          └── MySubscriptionList
        │       │── Content
        │       │── ExpertDetail
        │       │── SignIn
        │       └── SignUp
        └── AppDelegate
```
      
## Architecture
- MVVM (with Combine)
    - Data
        - API Response Model 
    - DataModel
        - Data <-> Data Model
        - Repository
    - Presentation
        - ViewModel
        - View
            - UIKit base
            - None StoryBoard
                - Code base UI
            - SnapKit
            - Kingfisher

## Data Model
- HomeDataModel
    - HomeData
        - AriticleData
            - UserData
- ExpertDataModel
    - ExpertData
        - QuestionData
            - UserData
            - AnswerData
                - UserData
- RevenueDataModel
    - RevenueData
        - ArticleRevenueData
            - AriticleData
                - UserData
        - AnswerRevenueData
            - QuestionData
                - UserData
                - AnswerData
                    - UserData
- SettingDataModel
    - SettingData
        - UserData
        - AriticleData
            - UserData

## Dependencies
- [Kingfisher](https://github.com/onevcat/Kingfisher)
- [MarkdownView](https://github.com/keitaoouchi/MarkdownView)
- [Snapkit](https://github.com/SnapKit/SnapKit)
- [Then](https://github.com/devxoul/Then)

## Coding Convention
- [Swift Coding Convention](https://www.swift.org/documentation/api-design-guidelines/)

## Target Version
- iOS 14.0

## Branch Strategy
- naming convention
    - Add [message]
    - Update [message]
    - Remove [message]
