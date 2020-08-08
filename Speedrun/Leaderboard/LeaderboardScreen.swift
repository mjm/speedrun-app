import SwiftUI
import RelaySwiftUI
import SpeedrunGenerated

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
      game {
        ...LeaderboardHeader_game
      }
      category {
        ...LeaderboardHeader_category
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

    @Query<LeaderboardScreenQuery>(fetchPolicy: .storeAndNetwork) var query

    @ViewBuilder var body: some View {
        switch query.get(gameID: gameID, categoryID: categoryID, levelID: levelID) {
        case .loading:
            Loading()
        case .failure(let error):
            Text("Error: \(error.localizedDescription)")
        case .success(let data):
            List {
                if let leaderboard = data?.viewer?.leaderboard {
                    LeaderboardHeader(
                        game: leaderboard.game.asFragment(),
                        category: leaderboard.category.asFragment())
                    
                    LeaderboardRunsList(leaderboard: leaderboard.asFragment())
                }
            }
            .listStyle(PlainListStyle())
            .navigationBarTitle("", displayMode: .inline)
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
