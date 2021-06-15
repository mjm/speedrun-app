// Auto-generated by relay-compiler. Do not edit.

import Relay

public struct GameDetailHeader_game {
    public var fragmentPointer: FragmentPointer

    public init(key: GameDetailHeader_game_Key) {
        fragmentPointer = key.fragment_GameDetailHeader_game
    }

    public static var node: ReaderFragment {
        ReaderFragment(
            name: "GameDetailHeader_game",
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

extension GameDetailHeader_game {
    public struct Data: Decodable {
        public var name: String?
        public var cover: GameAsset_cover?

        public struct GameAsset_cover: Decodable {
            public var uri: String
        }
    }
}

public protocol GameDetailHeader_game_Key {
    var fragment_GameDetailHeader_game: FragmentPointer { get }
}

extension GameDetailHeader_game: Relay.Fragment {}

#if canImport(RelaySwiftUI)
import RelaySwiftUI

extension GameDetailHeader_game_Key {
    public func asFragment() -> RelaySwiftUI.Fragment<GameDetailHeader_game> {
        RelaySwiftUI.Fragment<GameDetailHeader_game>(self)
    }
}
#endif