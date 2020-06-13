// Auto-generated by relay-compiler. Do not edit.

import Relay

struct GameSearchScreenQuery {
    var variables: Variables

    init(variables: Variables) {
        self.variables = variables
    }

    static var node: ConcreteRequest {
        ConcreteRequest(
            fragment: ReaderFragment(
                name: "GameSearchScreenQuery",
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
                                    VariableArgument(name: "query", variableName: "query")
                                ]
                            ))
                        ]
                    ))
                ]),
            operation: NormalizationOperation(
                name: "GameSearchScreenQuery",
                selections: [
                    .field(NormalizationLinkedField(
                        name: "viewer",
                        concreteType: "Viewer",
                        plural: false,
                        selections: [
                            .field(NormalizationLinkedField(
                                name: "games",
                                args: [
                                    ObjectValueArgument(name: "filter", fields: [
                                        VariableArgument(name: "name", variableName: "query")
                                    ]),
                                    LiteralArgument(name: "first", value: 10)
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
                                    ObjectValueArgument(name: "filter", fields: [
                                        VariableArgument(name: "name", variableName: "query")
                                    ]),
                                    LiteralArgument(name: "first", value: 10)
                                ],
                                handle: "connection",
                                key: "GameSearchResults_games",
                                filters: ["filter"]
                            ))
                        ]
                    ))
                ]),
            params: RequestParameters(
                name: "GameSearchScreenQuery",
                operationKind: .query,
                text: """
query GameSearchScreenQuery(
  $query: String!
) {
  viewer {
    ...GameSearchResults_games_1Qr5xf
  }
}

fragment GameSearchResultRow_game on Game {
  name
  cover: asset(kind: COVER_MEDIUM) {
    uri
  }
}

fragment GameSearchResults_games_1Qr5xf on Viewer {
  games(filter: {name: $query}, first: 10) {
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
"""))
    }
}


extension GameSearchScreenQuery {
    struct Variables: VariableDataConvertible {
        var query: String

        var variableData: VariableData {
            [
                "query": query,
            ]
        }
    }
}

extension GameSearchScreenQuery {
    struct Data: Readable {
        var viewer: Viewer_viewer?

        init(from data: SelectorData) {
            viewer = data.get(Viewer_viewer?.self, "viewer")
        }

        struct Viewer_viewer: Readable, GameSearchResults_games_Key {
            var fragment_GameSearchResults_games: FragmentPointer

            init(from data: SelectorData) {
                fragment_GameSearchResults_games = data.get(fragment: "GameSearchResults_games")
            }
        }
    }
}

extension GameSearchScreenQuery: Relay.Operation {}
