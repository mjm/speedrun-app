// Auto-generated by relay-compiler. Do not edit.

import Relay

struct RunDetailInfoPreviewQuery {
    var variables: Variables

    init(variables: Variables) {
        self.variables = variables
    }

    static var node: ConcreteRequest {
        ConcreteRequest(
            fragment: ReaderFragment(
                name: "RunDetailInfoPreviewQuery",
                type: "Query",
                selections: [
                    .field(ReaderLinkedField(
                        name: "node",
                        args: [
                            VariableArgument(name: "id", variableName: "id")
                        ],
                        plural: false,
                        selections: [
                            .inlineFragment(ReaderInlineFragment(
                                type: "Run",
                                selections: [
                                    .fragmentSpread(ReaderFragmentSpread(
                                        name: "RunDetailInfo_run"
                                    ))
                                ]
                            ))
                        ]
                    ))
                ]),
            operation: NormalizationOperation(
                name: "RunDetailInfoPreviewQuery",
                selections: [
                    .field(NormalizationLinkedField(
                        name: "node",
                        args: [
                            VariableArgument(name: "id", variableName: "id")
                        ],
                        plural: false,
                        selections: [
                            .field(NormalizationScalarField(
                                name: "__typename"
                            )),
                            .field(NormalizationScalarField(
                                name: "id"
                            )),
                            .inlineFragment(NormalizationInlineFragment(
                                type: "Run",
                                selections: [
                                    .field(NormalizationLinkedField(
                                        name: "game",
                                        concreteType: "Game",
                                        plural: false,
                                        selections: [
                                            .field(NormalizationScalarField(
                                                name: "name"
                                            )),
                                            .field(NormalizationScalarField(
                                                name: "id"
                                            ))
                                        ]
                                    )),
                                    .field(NormalizationLinkedField(
                                        name: "category",
                                        concreteType: "Category",
                                        plural: false,
                                        selections: [
                                            .field(NormalizationScalarField(
                                                name: "name"
                                            )),
                                            .field(NormalizationScalarField(
                                                name: "id"
                                            ))
                                        ]
                                    )),
                                    .field(NormalizationLinkedField(
                                        name: "players",
                                        plural: true,
                                        selections: [
                                            .field(NormalizationScalarField(
                                                name: "__typename"
                                            )),
                                            .inlineFragment(NormalizationInlineFragment(
                                                type: "UserRunPlayer",
                                                selections: [
                                                    .field(NormalizationLinkedField(
                                                        name: "user",
                                                        concreteType: "User",
                                                        plural: false,
                                                        selections: [
                                                            .field(NormalizationScalarField(
                                                                name: "name"
                                                            )),
                                                            .field(NormalizationLinkedField(
                                                                name: "nameStyle",
                                                                plural: false,
                                                                selections: [
                                                                    .field(NormalizationScalarField(
                                                                        name: "__typename"
                                                                    )),
                                                                    .inlineFragment(NormalizationInlineFragment(
                                                                        type: "SolidUserNameStyle",
                                                                        selections: [
                                                                            .field(NormalizationLinkedField(
                                                                                name: "color",
                                                                                concreteType: "Color",
                                                                                plural: false,
                                                                                selections: [
                                                                                    .field(NormalizationScalarField(
                                                                                        name: "light"
                                                                                    ))
                                                                                ]
                                                                            ))
                                                                        ]
                                                                    )),
                                                                    .inlineFragment(NormalizationInlineFragment(
                                                                        type: "GradientUserNameStyle",
                                                                        selections: [
                                                                            .field(NormalizationLinkedField(
                                                                                name: "fromColor",
                                                                                concreteType: "Color",
                                                                                plural: false,
                                                                                selections: [
                                                                                    .field(NormalizationScalarField(
                                                                                        name: "light"
                                                                                    ))
                                                                                ]
                                                                            )),
                                                                            .field(NormalizationLinkedField(
                                                                                name: "toColor",
                                                                                concreteType: "Color",
                                                                                plural: false,
                                                                                selections: [
                                                                                    .field(NormalizationScalarField(
                                                                                        name: "light"
                                                                                    ))
                                                                                ]
                                                                            ))
                                                                        ]
                                                                    ))
                                                                ]
                                                            )),
                                                            .field(NormalizationScalarField(
                                                                name: "id"
                                                            ))
                                                        ]
                                                    ))
                                                ]
                                            )),
                                            .inlineFragment(NormalizationInlineFragment(
                                                type: "GuestRunPlayer",
                                                selections: [
                                                    .field(NormalizationScalarField(
                                                        name: "name"
                                                    ))
                                                ]
                                            ))
                                        ]
                                    ))
                                ]
                            ))
                        ]
                    ))
                ]),
            params: RequestParameters(
                name: "RunDetailInfoPreviewQuery",
                operationKind: .query,
                text: """
query RunDetailInfoPreviewQuery(
  $id: ID!
) {
  node(id: $id) {
    __typename
    ... on Run {
      ...RunDetailInfo_run
    }
    id
  }
}

fragment RunDetailInfo_run on Run {
  game {
    name
    id
  }
  category {
    name
    id
  }
  players {
    __typename
    ...RunPlayerRow_player
    ... on UserRunPlayer {
      user {
        name
        id
      }
    }
    ... on GuestRunPlayer {
      name
    }
  }
}

fragment RunPlayerRow_player on RunPlayer {
  ... on UserRunPlayer {
    user {
      name
      nameStyle {
        __typename
        ... on SolidUserNameStyle {
          color {
            light
          }
        }
        ... on GradientUserNameStyle {
          fromColor {
            light
          }
          toColor {
            light
          }
        }
      }
      id
    }
  }
  ... on GuestRunPlayer {
    name
  }
}
"""))
    }
}


extension RunDetailInfoPreviewQuery {
    struct Variables: VariableDataConvertible {
        var id: String

        var variableData: VariableData {
            [
                "id": id,
            ]
        }
    }
}

extension RunDetailInfoPreviewQuery {
    struct Data: Readable {
        var node: Node_node?

        init(from data: SelectorData) {
            node = data.get(Node_node?.self, "node")
        }

        enum Node_node: Readable {
            case run(Run)
            case node(Node)
  
            init(from data: SelectorData) {
                let typeName = data.get(String.self, "__typename")
                switch typeName {
                case "Run":
                    self = .run(Run(from: data))
                default:
                    self = .node(Node(from: data))
                }
            }

            var asRun: Run? {
                if case .run(let val) = self {
                    return val
                }
                return nil
            }

            var asNode: Node? {
                if case .node(let val) = self {
                    return val
                }
                return nil
            }

            struct Run: Readable, RunDetailInfo_run_Key {
                var fragment_RunDetailInfo_run: FragmentPointer

                init(from data: SelectorData) {
                    fragment_RunDetailInfo_run = data.get(fragment: "RunDetailInfo_run")
                }
            }

            struct Node: Readable {

                init(from data: SelectorData) {
                }
            }
        }
    }
}

extension RunDetailInfoPreviewQuery: Relay.Operation {}
