// Auto-generated by relay-compiler. Do not edit.

import Relay

public struct GameSearchResultRow_game {
    public var fragmentPointer: FragmentPointer

    public init(key: GameSearchResultRow_game_Key) {
        fragmentPointer = key.fragment_GameSearchResultRow_game
    }

    public static var node: ReaderFragment {
        ReaderFragment(
            name: "GameSearchResultRow_game",
            type: "Game",
            selections: [
                .field(ReaderScalarField(
                    name: "name"
                )),
                .field(ReaderLinkedField(
                    name: "asset",
                    alias: "cover",
                    storageKey: "asset(kind:\"COVER_MEDIUM\")",
                    args: [
                        LiteralArgument(name: "kind", value: "COVER_MEDIUM")
                    ],
                    concreteType: "GameAsset",
                    plural: false,
                    selections: [
                        .field(ReaderScalarField(
                            name: "uri"
                        ))
                    ]
                ))
            ]
        )
    }
}

extension GameSearchResultRow_game {
    public struct Data: Decodable {
        public var name: String?
        public var cover: GameAsset_cover?

        public struct GameAsset_cover: Decodable {
            public var uri: String
        }
    }
}

public protocol GameSearchResultRow_game_Key {
    var fragment_GameSearchResultRow_game: FragmentPointer { get }
}

extension GameSearchResultRow_game: Relay.Fragment {}

#if canImport(RelaySwiftUI)
import RelaySwiftUI

extension GameSearchResultRow_game_Key {
    public func asFragment() -> RelaySwiftUI.Fragment<GameSearchResultRow_game> {
        RelaySwiftUI.Fragment<GameSearchResultRow_game>(self)
    }
}
#endif