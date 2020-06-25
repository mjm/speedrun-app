import SwiftUI
import RelaySwiftUI

private let query = graphql("""
query LeaderboardScreenQuery(
  $gameID: ID!
  $categoryID: ID!
  $levelID: ID
) {
  viewer {
    leaderboard(
      game: $gameID
      category: $categoryID
      level: $levelID
    ) {
      category {
        name
      }
      ...LeaderboardRunsList_leaderboard @arguments(count: 50)
    }
  }
}
""")

struct LeaderboardScreen: View {
    let gameID: String
    let categoryID: String
    let levelID: String? = nil

    @Query(LeaderboardScreenQuery.self) var query

    var body: some View {
        Group {
            switch query.get(.init(gameID: gameID, categoryID: categoryID, levelID: levelID)) {
            case .loading:
                Text("Loading…")
            case .failure(let error):
                Text("Error: \(error.localizedDescription)")
            case .success(let data):
                List {
                    if let leaderboard = data?.viewer?.leaderboard {
                        LeaderboardRunsList(leaderboard: leaderboard)
                    }
                }
                .navigationBarTitle(data?.viewer?.leaderboard?.category.name ?? "")
            }
        }
    }
}

struct LeaderboardScreen_Previews: PreviewProvider {
    static let mockEnvironment = MockEnvironment()

    static let payload: [String: Any] = [
        "data": [
            "viewer": [
                "leaderboard": [
                    "category": [
                        "name": "Glitchless",
                    ],
                ].merging( LeaderboardRunsList_Previews.leaderboardFragment) { $1 },
            ],
        ],
    ]

    static var previews: some View {
        let op = LeaderboardScreenQuery(variables: .init(gameID: "foo", categoryID: "bar"))
        mockEnvironment.mockResponse(op, payload)

        return Group {
            NavigationView {
                LeaderboardScreen(gameID: "foo", categoryID: "bar")
            }
        }.relayEnvironment(mockEnvironment)
    }
}
