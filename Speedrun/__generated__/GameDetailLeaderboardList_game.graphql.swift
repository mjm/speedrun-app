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
    struct Data: Readable {
        var id: String
        var categories: [Category_categories]

        init(from data: SelectorData) {
            id = data.get(String.self, "id")
            categories = data.get([Category_categories].self, "categories")
        }

        struct Category_categories: Readable {
            var id: String
            var name: String

            init(from data: SelectorData) {
                id = data.get(String.self, "id")
                name = data.get(String.self, "name")
            }
        }
    }
}

protocol GameDetailLeaderboardList_game_Key {
    var fragment_GameDetailLeaderboardList_game: FragmentPointer { get }
}

extension GameDetailLeaderboardList_game: Relay.Fragment {}
