// Auto-generated by relay-compiler. Do not edit.

import Relay

public struct GameDetailLeaderboardListRefetchQuery {
    public var variables: Variables

    public init(variables: Variables) {
        self.variables = variables
    }

    public static var node: ConcreteRequest {
        ConcreteRequest(
            fragment: ReaderFragment(
                name: "GameDetailLeaderboardListRefetchQuery",
                type: "Query",
                selections: [
                    .field(ReaderLinkedField(
                        name: "node",
                        args: [
                            VariableArgument(name: "id", variableName: "id")
                        ],
                        plural: false,
                        selections: [
                            .fragmentSpread(ReaderFragmentSpread(
                                name: "GameDetailLeaderboardList_game"
                            ))
                        ]
                    ))
                ]
            ),
            operation: NormalizationOperation(
                name: "GameDetailLeaderboardListRefetchQuery",
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
                                type: "Game",
                                selections: [
                                    .field(NormalizationLinkedField(
                                        name: "categories",
                                        concreteType: "Category",
                                        plural: true,
                                        selections: [
                                            .field(NormalizationScalarField(
                                                name: "id"
                                            )),
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
            ),
            params: RequestParameters(
                name: "GameDetailLeaderboardListRefetchQuery",
                operationKind: .query,
                text: """
query GameDetailLeaderboardListRefetchQuery(
  $id: ID!
) {
  node(id: $id) {
    __typename
    ...GameDetailLeaderboardList_game
    id
  }
}

fragment GameDetailLeaderboardList_game on Game {
  id
  categories {
    id
    name
  }
}
"""
            )
        )
    }
}

extension GameDetailLeaderboardListRefetchQuery {
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

#if canImport(RelaySwiftUI)
import RelaySwiftUI

extension RelaySwiftUI.Query.WrappedValue where O == GameDetailLeaderboardListRefetchQuery {
    public func get(id: String, fetchKey: Any? = nil) -> RelaySwiftUI.Query<GameDetailLeaderboardListRefetchQuery>.Result {
        self.get(.init(id: id), fetchKey: fetchKey)
    }
}
#endif

#if canImport(RelaySwiftUI)
import RelaySwiftUI

extension RelaySwiftUI.RefetchableFragment.Wrapper where F.Operation == GameDetailLeaderboardListRefetchQuery {
    public func refetch(id: String) {
        self.refetch(.init(id: id))
    }
}
#endif

extension GameDetailLeaderboardListRefetchQuery {
    public struct Data: Decodable {
        public var node: Node_node?

        public struct Node_node: Decodable, GameDetailLeaderboardList_game_Key {
            public var fragment_GameDetailLeaderboardList_game: FragmentPointer
        }
    }
}

extension GameDetailLeaderboardListRefetchQuery: Relay.Operation {}