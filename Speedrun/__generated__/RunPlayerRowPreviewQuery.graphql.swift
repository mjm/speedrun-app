// Auto-generated by relay-compiler. Do not edit.

import Relay

public struct RunPlayerRowPreviewQuery {
    public var variables: Variables

    public init(variables: Variables) {
        self.variables = variables
    }

    public static var node: ConcreteRequest {
        ConcreteRequest(
            fragment: ReaderFragment(
                name: "RunPlayerRowPreviewQuery",
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
                                    .field(ReaderLinkedField(
                                        name: "players",
                                        plural: true,
                                        selections: [
                                            .fragmentSpread(ReaderFragmentSpread(
                                                name: "RunPlayerRow_player"
                                            ))
                                        ]
                                    ))
                                ]
                            ))
                        ]
                    ))
                ]
            ),
            operation: NormalizationOperation(
                name: "RunPlayerRowPreviewQuery",
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
                ]
            ),
            params: RequestParameters(
                name: "RunPlayerRowPreviewQuery",
                operationKind: .query,
                text: """
query RunPlayerRowPreviewQuery(
  $id: ID!
) {
  node(id: $id) {
    __typename
    ... on Run {
      players {
        __typename
        ...RunPlayerRow_player
      }
    }
    id
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
"""
            )
        )
    }
}

extension RunPlayerRowPreviewQuery {
    public struct Variables: VariableDataConvertible {
        public var id: String

        public init(id: String) {
            self.id = id
        }

        public var variableData: VariableData {
            [
                "id": id
            ]
        }
    }

    public init(id: String) {
        self.init(variables: .init(id: id))
    }
}

#if swift(>=5.3) && canImport(RelaySwiftUI)
import RelaySwiftUI

@available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)extension RelaySwiftUI.QueryNext.WrappedValue where O == RunPlayerRowPreviewQuery {
    public func get(id: String, fetchKey: Any? = nil) -> RelaySwiftUI.QueryNext<RunPlayerRowPreviewQuery>.Result {
        self.get(.init(id: id), fetchKey: fetchKey)
    }
}
#endif
extension RunPlayerRowPreviewQuery {
    public struct Data: Decodable {
        public var node: Node_node?

        public enum Node_node: Decodable {
            case run(Run)
            case node(Node)

            private enum TypeKeys: String, CodingKey {
                case __typename
            }

            public init(from decoder: Decoder) throws {
                let container = try decoder.container(keyedBy: TypeKeys.self)
                let typeName = try container.decode(String.self, forKey: .__typename)
                switch typeName {
                case "Run":
                    self = .run(try Run(from: decoder))
                default:
                    self = .node(try Node(from: decoder))
                }
            }

            public var asRun: Run? {
                if case .run(let val) = self {
                    return val
                }
                return nil
            }

            public var asNode: Node? {
                if case .node(let val) = self {
                    return val
                }
                return nil
            }

            public struct Run: Decodable {
                public var players: [RunPlayer_players]

                public struct RunPlayer_players: Decodable, RunPlayerRow_player_Key {
                    public var fragment_RunPlayerRow_player: FragmentPointer
                }
            }

            public struct Node: Decodable {
            }
        }
    }
}
extension RunPlayerRowPreviewQuery: Relay.Operation {}