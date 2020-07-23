// Auto-generated by relay-compiler. Do not edit.

import Relay

public struct GameSearchResultsPaginationQuery {
    public var variables: Variables

    public init(variables: Variables) {
        self.variables = variables
    }

    public static var node: ConcreteRequest {
        ConcreteRequest(
            fragment: ReaderFragment(
                name: "GameSearchResultsPaginationQuery",
                type: "Query",
                selections: [
                    .field(ReaderLinkedField(
                        name: "viewer",
                        concreteType: "Viewer",
                        plural: false,
                        selections: [
                            .fragmentSpread(ReaderFragmentSpread(
                                name: "GameSearchResults_games",
                                args: [
                                    VariableArgument(name: "count", variableName: "count"),
                                    VariableArgument(name: "cursor", variableName: "cursor"),
                                    VariableArgument(name: "query", variableName: "query")
                                ]
                            ))
                        ]
                    ))
                ]
            ),
            operation: NormalizationOperation(
                name: "GameSearchResultsPaginationQuery",
                selections: [
                    .field(NormalizationLinkedField(
                        name: "viewer",
                        concreteType: "Viewer",
                        plural: false,
                        selections: [
                            .field(NormalizationLinkedField(
                                name: "games",
                                args: [
                                    VariableArgument(name: "after", variableName: "cursor"),
                                    ObjectValueArgument(name: "filter", fields: [
                                        VariableArgument(name: "name", variableName: "query")
                                    ]),
                                    VariableArgument(name: "first", variableName: "count")
                                ],
                                concreteType: "GameConnection",
                                plural: false,
                                selections: [
                                    .field(NormalizationLinkedField(
                                        name: "edges",
                                        concreteType: "GameEdge",
                                        plural: true,
                                        selections: [
                                            .field(NormalizationLinkedField(
                                                name: "node",
                                                concreteType: "Game",
                                                plural: false,
                                                selections: [
                                                    .field(NormalizationScalarField(
                                                        name: "id"
                                                    )),
                                                    .field(NormalizationScalarField(
                                                        name: "name"
                                                    )),
                                                    .field(NormalizationLinkedField(
                                                        name: "asset",
                                                        alias: "cover",
                                                        args: [
                                                            LiteralArgument(name: "kind", value: "COVER_MEDIUM")
                                                        ],
                                                        storageKey: "asset(kind:\"COVER_MEDIUM\")",
                                                        concreteType: "GameAsset",
                                                        plural: false,
                                                        selections: [
                                                            .field(NormalizationScalarField(
                                                                name: "uri"
                                                            ))
                                                        ]
                                                    )),
                                                    .field(NormalizationScalarField(
                                                        name: "__typename"
                                                    ))
                                                ]
                                            )),
                                            .field(NormalizationScalarField(
                                                name: "cursor"
                                            ))
                                        ]
                                    )),
                                    .field(NormalizationLinkedField(
                                        name: "pageInfo",
                                        concreteType: "PageInfo",
                                        plural: false,
                                        selections: [
                                            .field(NormalizationScalarField(
                                                name: "endCursor"
                                            )),
                                            .field(NormalizationScalarField(
                                                name: "hasNextPage"
                                            ))
                                        ]
                                    ))
                                ]
                            )),
                            .handle(NormalizationHandle(
                                kind: .linked,
                                name: "games",
                                args: [
                                    VariableArgument(name: "after", variableName: "cursor"),
                                    ObjectValueArgument(name: "filter", fields: [
                                        VariableArgument(name: "name", variableName: "query")
                                    ]),
                                    VariableArgument(name: "first", variableName: "count")
                                ],
                                handle: "connection",
                                key: "GameSearchResults_games",
                                filters: ["filter"]
                            ))
                        ]
                    ))
                ]
            ),
            params: RequestParameters(
                name: "GameSearchResultsPaginationQuery",
                operationKind: .query,
                text: """
query GameSearchResultsPaginationQuery(
  $query: String!
  $count: Int = 10
  $cursor: Cursor
) {
  viewer {
    ...GameSearchResults_games_1jWD3d
  }
}

fragment GameSearchResultRow_game on Game {
  name
  cover: asset(kind: COVER_MEDIUM) {
    uri
  }
}

fragment GameSearchResults_games_1jWD3d on Viewer {
  games(filter: {name: $query}, first: $count, after: $cursor) {
    edges {
      node {
        id
        ...GameSearchResultRow_game
        __typename
      }
      cursor
    }
    pageInfo {
      endCursor
      hasNextPage
    }
  }
}
"""
            )
        )
    }
}

extension GameSearchResultsPaginationQuery {
    public struct Variables: VariableDataConvertible {
        public var query: String
        public var count: Int?
        public var cursor: String?

        public init(query: String, count: Int? = nil, cursor: String? = nil) {
            self.query = query
            self.count = count
            self.cursor = cursor
        }

        public var variableData: VariableData {
            [
                "query": query,
                "count": count,
                "cursor": cursor
            ]
        }
    }

    public init(query: String, count: Int? = nil, cursor: String? = nil) {
        self.init(variables: .init(query: query, count: count, cursor: cursor))
    }
}

#if swift(>=5.3) && canImport(RelaySwiftUI)
import RelaySwiftUI

@available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
extension RelaySwiftUI.QueryNext.WrappedValue where O == GameSearchResultsPaginationQuery {
    public func get(query: String, count: Int? = nil, cursor: String? = nil, fetchKey: Any? = nil) -> RelaySwiftUI.QueryNext<GameSearchResultsPaginationQuery>.Result {
        self.get(.init(query: query, count: count, cursor: cursor), fetchKey: fetchKey)
    }
}
#endif

#if swift(>=5.3) && canImport(RelaySwiftUI)
import RelaySwiftUI

@available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
extension RelaySwiftUI.RefetchableFragment.Wrapper where F.Operation == GameSearchResultsPaginationQuery {
    public func refetch(query: String, count: Int? = nil, cursor: String? = nil) {
        self.refetch(.init(query: query, count: count, cursor: cursor))
    }
}
#endif

extension GameSearchResultsPaginationQuery {
    public struct Data: Decodable {
        public var viewer: Viewer_viewer?

        public struct Viewer_viewer: Decodable, GameSearchResults_games_Key {
            public var fragment_GameSearchResults_games: FragmentPointer
        }
    }
}

extension GameSearchResultsPaginationQuery: Relay.Operation {}