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

    @Query<LeaderboardScreenQuery> var query

    @ViewBuilder var body: some View {
        switch query.get(.init(gameID: gameID, categoryID: categoryID, levelID: levelID)) {
        case .loading:
            Text("Loading…")
        case .failure(let error):
            Text("Error: \(error.localizedDescription)")
        case .success(let data):
            List {
                if let leaderboard = data?.viewer?.leaderboard {
                    LeaderboardRunsList(leaderboard: leaderboard.asFragment())
                }
            }
            .navigationBarTitle(data?.viewer?.leaderboard?.category.name ?? "")
        }
    }
}

struct LeaderboardScreen_Previews: PreviewProvider {
    static let op = LeaderboardScreenQuery(
        gameID: "Z2FtZToieWQ0bzMydzEi",
        categoryID: "Y2F0ZWdvcnk6IjdrajNwbTQyIg=="
    )

    static var previews: some View {
        NavigationView {
            LeaderboardScreen(
                gameID: "Z2FtZToieWQ0bzMydzEi",
                categoryID: "Y2F0ZWdvcnk6IjdrajNwbTQyIg==")
        }
        .previewPayload(op, resource: "LeaderboardScreenPreview")
    }
}
