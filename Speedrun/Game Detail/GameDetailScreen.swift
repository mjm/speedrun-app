import SwiftUI
import class Relay.MockEnvironment
import RelaySwiftUI

private let query = graphql("""
query GameDetailScreenQuery($id: ID!) {
  game(id: $id) {
    id
    ...GameDetailHeader_game
    ...GameDetailLeaderboardList_game
  }
}
""")

struct GameDetailScreen: View {
    let id: String

    @Query(GameDetailScreenQuery.self) var query

    var body: some View {
        Group {
            switch query.get(.init(id: id)) {
            case .loading:
                Text("Loading…")
            case .failure(let error):
                Text("Error: \(error.localizedDescription)")
            case .success(let data):
                if let game = data?.game {
                    List {
                        Section(header: GameDetailHeader(game: game)) {
                            EmptyView()
                        }

                        Section(header: Text("Leaderboards")) {
                            GameDetailLeaderboardList(game: game)
                        }
                    }
                    .listStyle(GroupedListStyle())
                }
            }
        }
    }
}

struct GameDetailScreen_Previews: PreviewProvider {
    static let mockEnvironment = MockEnvironment()

    static let mockGameID = GameDetailLeaderboardList_Previews.mockGameID

    static let payload = [
        "data": [
            "game": [
                "id": mockGameID
            ]
                .merging(GameDetailHeader_Previews.gameFragment) { $1 }
                .merging(GameDetailLeaderboardList_Previews.gameFragment) { $1 },
        ],
    ]

    static var previews: some View {
        let op = GameDetailScreenQuery(variables: .init(id: mockGameID))
        mockEnvironment.mockResponse(op, payload)

        return Group {
            NavigationView {
                GameDetailScreen(id: mockGameID)
            }
        }.relayEnvironment(mockEnvironment)
    }
}
