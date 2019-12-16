//  This file was automatically generated and should not be edited.

import Apollo
import Foundation

public final class GetSubjectQuery: GraphQLQuery {
  /// The raw GraphQL definition of this operation.
  public let operationDefinition =
    """
    query GetSubject {
      subjects {
        __typename
        id
        name
        timeRequired
        questions {
          __typename
          id
          title
          choices {
            __typename
            id
            title
            correct
          }
        }
      }
    }
    """

  public let operationName = "GetSubject"

  public init() {
  }

  public struct Data: GraphQLSelectionSet {
    public static let possibleTypes = ["Query"]

    public static let selections: [GraphQLSelection] = [
      GraphQLField("subjects", type: .list(.object(Subject.selections))),
    ]

    public private(set) var resultMap: ResultMap

    public init(unsafeResultMap: ResultMap) {
      self.resultMap = unsafeResultMap
    }

    public init(subjects: [Subject?]? = nil) {
      self.init(unsafeResultMap: ["__typename": "Query", "subjects": subjects.flatMap { (value: [Subject?]) -> [ResultMap?] in value.map { (value: Subject?) -> ResultMap? in value.flatMap { (value: Subject) -> ResultMap in value.resultMap } } }])
    }

    public var subjects: [Subject?]? {
      get {
        return (resultMap["subjects"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Subject?] in value.map { (value: ResultMap?) -> Subject? in value.flatMap { (value: ResultMap) -> Subject in Subject(unsafeResultMap: value) } } }
      }
      set {
        resultMap.updateValue(newValue.flatMap { (value: [Subject?]) -> [ResultMap?] in value.map { (value: Subject?) -> ResultMap? in value.flatMap { (value: Subject) -> ResultMap in value.resultMap } } }, forKey: "subjects")
      }
    }

    public struct Subject: GraphQLSelectionSet {
      public static let possibleTypes = ["Subject"]

      public static let selections: [GraphQLSelection] = [
        GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
        GraphQLField("id", type: .scalar(GraphQLID.self)),
        GraphQLField("name", type: .scalar(String.self)),
        GraphQLField("timeRequired", type: .scalar(Int.self)),
        GraphQLField("questions", type: .list(.object(Question.selections))),
      ]

      public private(set) var resultMap: ResultMap

      public init(unsafeResultMap: ResultMap) {
        self.resultMap = unsafeResultMap
      }

      public init(id: GraphQLID? = nil, name: String? = nil, timeRequired: Int? = nil, questions: [Question?]? = nil) {
        self.init(unsafeResultMap: ["__typename": "Subject", "id": id, "name": name, "timeRequired": timeRequired, "questions": questions.flatMap { (value: [Question?]) -> [ResultMap?] in value.map { (value: Question?) -> ResultMap? in value.flatMap { (value: Question) -> ResultMap in value.resultMap } } }])
      }

      public var __typename: String {
        get {
          return resultMap["__typename"]! as! String
        }
        set {
          resultMap.updateValue(newValue, forKey: "__typename")
        }
      }

      public var id: GraphQLID? {
        get {
          return resultMap["id"] as? GraphQLID
        }
        set {
          resultMap.updateValue(newValue, forKey: "id")
        }
      }

      public var name: String? {
        get {
          return resultMap["name"] as? String
        }
        set {
          resultMap.updateValue(newValue, forKey: "name")
        }
      }

      public var timeRequired: Int? {
        get {
          return resultMap["timeRequired"] as? Int
        }
        set {
          resultMap.updateValue(newValue, forKey: "timeRequired")
        }
      }

      public var questions: [Question?]? {
        get {
          return (resultMap["questions"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Question?] in value.map { (value: ResultMap?) -> Question? in value.flatMap { (value: ResultMap) -> Question in Question(unsafeResultMap: value) } } }
        }
        set {
          resultMap.updateValue(newValue.flatMap { (value: [Question?]) -> [ResultMap?] in value.map { (value: Question?) -> ResultMap? in value.flatMap { (value: Question) -> ResultMap in value.resultMap } } }, forKey: "questions")
        }
      }

      public struct Question: GraphQLSelectionSet {
        public static let possibleTypes = ["Question"]

        public static let selections: [GraphQLSelection] = [
          GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
          GraphQLField("id", type: .scalar(GraphQLID.self)),
          GraphQLField("title", type: .scalar(String.self)),
          GraphQLField("choices", type: .list(.object(Choice.selections))),
        ]

        public private(set) var resultMap: ResultMap

        public init(unsafeResultMap: ResultMap) {
          self.resultMap = unsafeResultMap
        }

        public init(id: GraphQLID? = nil, title: String? = nil, choices: [Choice?]? = nil) {
          self.init(unsafeResultMap: ["__typename": "Question", "id": id, "title": title, "choices": choices.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }])
        }

        public var __typename: String {
          get {
            return resultMap["__typename"]! as! String
          }
          set {
            resultMap.updateValue(newValue, forKey: "__typename")
          }
        }

        public var id: GraphQLID? {
          get {
            return resultMap["id"] as? GraphQLID
          }
          set {
            resultMap.updateValue(newValue, forKey: "id")
          }
        }

        public var title: String? {
          get {
            return resultMap["title"] as? String
          }
          set {
            resultMap.updateValue(newValue, forKey: "title")
          }
        }

        public var choices: [Choice?]? {
          get {
            return (resultMap["choices"] as? [ResultMap?]).flatMap { (value: [ResultMap?]) -> [Choice?] in value.map { (value: ResultMap?) -> Choice? in value.flatMap { (value: ResultMap) -> Choice in Choice(unsafeResultMap: value) } } }
          }
          set {
            resultMap.updateValue(newValue.flatMap { (value: [Choice?]) -> [ResultMap?] in value.map { (value: Choice?) -> ResultMap? in value.flatMap { (value: Choice) -> ResultMap in value.resultMap } } }, forKey: "choices")
          }
        }

        public struct Choice: GraphQLSelectionSet {
          public static let possibleTypes = ["Choice"]

          public static let selections: [GraphQLSelection] = [
            GraphQLField("__typename", type: .nonNull(.scalar(String.self))),
            GraphQLField("id", type: .scalar(GraphQLID.self)),
            GraphQLField("title", type: .scalar(String.self)),
            GraphQLField("correct", type: .scalar(Bool.self)),
          ]

          public private(set) var resultMap: ResultMap

          public init(unsafeResultMap: ResultMap) {
            self.resultMap = unsafeResultMap
          }

          public init(id: GraphQLID? = nil, title: String? = nil, correct: Bool? = nil) {
            self.init(unsafeResultMap: ["__typename": "Choice", "id": id, "title": title, "correct": correct])
          }

          public var __typename: String {
            get {
              return resultMap["__typename"]! as! String
            }
            set {
              resultMap.updateValue(newValue, forKey: "__typename")
            }
          }

          public var id: GraphQLID? {
            get {
              return resultMap["id"] as? GraphQLID
            }
            set {
              resultMap.updateValue(newValue, forKey: "id")
            }
          }

          public var title: String? {
            get {
              return resultMap["title"] as? String
            }
            set {
              resultMap.updateValue(newValue, forKey: "title")
            }
          }

          public var correct: Bool? {
            get {
              return resultMap["correct"] as? Bool
            }
            set {
              resultMap.updateValue(newValue, forKey: "correct")
            }
          }
        }
      }
    }
  }
}
