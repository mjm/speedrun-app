// Auto-generated by relay-compiler. Do not edit.

import Relay

struct GameDetailLeaderboardList_game {
    var fragmentPointer: FragmentPointer

    init(key: GameDetailLeaderboardList_game_Key) {
        fragmentPointer = key.fragment_GameDetailLeaderboardList_game
    }

    static var node: ReaderFragment {
        ReaderFragment(
            name: "GameDetailLeaderboardList_game",
            type: "Game",
            selections: [
                .field(ReaderScalarField(
                    name: "id"
                )),
                .field(ReaderLinkedField(
                    name: "categories",
                    concreteType: "Category",
                    plural: true,
                    selections: [
                        .field(ReaderScalarField(
                            name: "id"
                        )),
                        .field(ReaderScalarField(
                            name: "name"
                        ))
                    ]
                ))
            ])
    }
}


extension GameDetailLeaderboardList_game {
    struct Data: Decodable {
        var id: String
        var categories: [Category_categories]

        struct Category_categories: Decodable {
            var id: String
            var name: String
        }
    }
}

protocol GameDetailLeaderboardList_game_Key {
    var fragment_GameDetailLeaderboardList_game: FragmentPointer { get }
}

extension GameDetailLeaderboardList_game: Relay.Fragment {}
