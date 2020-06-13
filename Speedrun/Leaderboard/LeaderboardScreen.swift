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
    @Query(LeaderboardScreenQuery.self) var query

    init(gameID: String, categoryID: String, levelID: String? = nil) {
        $query = .init(gameID: gameID, categoryID: categoryID, levelID: levelID)
    }

    var body: some View {
        Group {
            if query.isLoading {
                Text("Loading…")
            } else if query.error != nil {
                Text("Error: \(query.error!.localizedDescription)")
            } else {
                List {
                    if query.data?.viewer?.leaderboard != nil {
                        LeaderboardRunsList(leaderboard: query.data!.viewer!.leaderboard!)
                    }
                }.navigationBarTitle(query.data?.viewer?.leaderboard?.category.name ?? "")
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
