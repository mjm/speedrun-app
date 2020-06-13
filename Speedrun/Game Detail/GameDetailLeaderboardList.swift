import SwiftUI
import class Relay.MockEnvironment
import RelaySwiftUI

private let gameFragment = graphql("""
fragment GameDetailLeaderboardList_game on Game {
  id
  categories {
    id
    name
  }
}
""")

struct GameDetailLeaderboardList: View {
    @Fragment(GameDetailLeaderboardList_game.self) var game

    init(game: GameDetailLeaderboardList_game_Key) {
        $game = game
    }

    var body: some View {
        ForEach(game?.categories ?? [], id: \.id) { category in
            NavigationLink(destination: LeaderboardScreen(gameID: self.game!.id, categoryID: category.id)) {
                Text(category.name)
            }
        }
    }
}

private let previewQuery = graphql("""
query GameDetailLeaderboardListPreviewQuery($id: ID!) {
  game(id: $id) {
    ...GameDetailLeaderboardList_game
  }
}
""")

struct GameDetailLeaderboardList_Previews: PreviewProvider {
    static let mockEnvironment = MockEnvironment()

    static let mockGameID = UUID().uuidString

    static let gameFragment: [String: Any] = [
        "id": mockGameID,
        "categories": [
            [
                "id": UUID().uuidString,
                "name": "Any%",
            ],
            [
                "id": UUID().uuidString,
                "name": "Glitchless",
            ],
            [
                "id": UUID().uuidString,
                "name": "100%",
            ],
        ],
    ]

    static var previews: some View {
        let op = GameDetailLeaderboardListPreviewQuery(variables: .init(id: mockGameID))
        mockEnvironment.cachePayload(op, [
            "data": [
                "game": gameFragment
            ],
        ])

        return Group {
            QueryPreview(op) { data in
                List {
                    GameDetailLeaderboardList(game: data.game!)
                }.listStyle(GroupedListStyle())
            }
        }.relayEnvironment(mockEnvironment)
    }
}
