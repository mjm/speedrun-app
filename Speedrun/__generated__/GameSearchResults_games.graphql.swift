// Auto-generated by relay-compiler. Do not edit.

import Relay

struct GameSearchResults_games {
    var fragmentPointer: FragmentPointer

    init(key: GameSearchResults_games_Key) {
        fragmentPointer = key.fragment_GameSearchResults_games
    }

    static var node: ReaderFragment {
        ReaderFragment(
            name: "GameSearchResults_games",
            type: "Viewer",
            selections: [
                .field(ReaderLinkedField(
                    name: "__GameSearchResults_games_connection",
                    alias: "games",
                    args: [
                        ObjectValueArgument(name: "filter", fields: [
                            VariableArgument(name: "name", variableName: "query")
                        ])
                    ],
                    concreteType: "GameConnection",
                    plural: false,
                    selections: [
                        .field(ReaderLinkedField(
                            name: "edges",
                            concreteType: "GameEdge",
                            plural: true,
                            selections: [
                                .field(ReaderLinkedField(
                                    name: "node",
                                    concreteType: "Game",
                                    plural: false,
                                    selections: [
                                        .field(ReaderScalarField(
                                            name: "id"
                                        )),
                                        .field(ReaderScalarField(
                                            name: "__typename"
                                        )),
                                        .fragmentSpread(ReaderFragmentSpread(
                                            name: "GameSearchResultRow_game"
                                        ))
                                    ]
                                )),
                                .field(ReaderScalarField(
                                    name: "cursor"
                                ))
                            ]
                        )),
                        .field(ReaderLinkedField(
                            name: "pageInfo",
                            concreteType: "PageInfo",
                            plural: false,
                            selections: [
                                .field(ReaderScalarField(
                                    name: "endCursor"
                                )),
                                .field(ReaderScalarField(
                                    name: "hasNextPage"
                                ))
                            ]
                        ))
                    ]
                ))
            ])
    }
}


extension GameSearchResults_games {
    struct Data: Decodable {
        var games: GameConnection_games

        struct GameConnection_games: Decodable {
            var edges: [GameEdge_edges]

            struct GameEdge_edges: Decodable {
                var node: Game_node

                struct Game_node: Decodable, Identifiable, GameSearchResultRow_game_Key {
                    var id: String
                    var fragment_GameSearchResultRow_game: FragmentPointer
                }
            }
        }
    }
}

protocol GameSearchResults_games_Key {
    var fragment_GameSearchResults_games: FragmentPointer { get }
}

extension GameSearchResults_games: Relay.Fragment {}

extension GameSearchResults_games: Relay.PaginationFragment {
    typealias Operation = GameSearchResultsPaginationQuery

    static var metadata: Metadata {
        RefetchMetadata(
            path: ["viewer"],
            operation: Operation.self,
            connection: ConnectionMetadata(
                path: ["games"],
                forward: ConnectionVariableConfig(count: "count", cursor: "cursor")))
    }
}

#if canImport(RelaySwiftUI)

import RelaySwiftUI

extension GameSearchResults_games_Key {
    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    func asFragment() -> RelaySwiftUI.FragmentNext<GameSearchResults_games> {
        RelaySwiftUI.FragmentNext<GameSearchResults_games>(self)
    }

    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    func asFragment() -> RelaySwiftUI.PaginationFragmentNext<GameSearchResults_games> {
        RelaySwiftUI.PaginationFragmentNext<GameSearchResults_games>(self)
    }
}

#endif
