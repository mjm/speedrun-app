import SwiftUI
import RelaySwiftUI
import SpeedrunGenerated

private let leaderboardFragment = graphql("""
fragment LeaderboardRunsList_leaderboard on Leaderboard
  @argumentDefinitions(
    count: { type: "Int!" }
  ) {
  runs(first: $count) {
    run {
      id
    }
    place
    ...LeaderboardRun_run
  }
}
""")

struct LeaderboardRunsList: View {
    @Fragment<LeaderboardRunsList_leaderboard> var leaderboard

    @ViewBuilder var body: some View {
        if let leaderboard = leaderboard {
            ForEach(leaderboard.runs.filter { $0.place != 0 }, id: \.run.id) { placedRun in
                NavigationLink(destination: RunDetailScreen(id: placedRun.run.id)) {
                    LeaderboardRun(run: placedRun.asFragment())
                }
            }
        }
    }
}

private let previewQuery = graphql("""
query LeaderboardRunsListPreviewQuery {
  viewer {
    leaderboard(game: "foo", category: "bar") {
      ...LeaderboardRunsList_leaderboard @arguments(count: 10)
    }
  }
}
""")

struct LeaderboardRunsList_Previews: PreviewProvider {
    static let op = LeaderboardScreenQuery(
        gameID: "Z2FtZToieWQ0bzMydzEi",
        categoryID: "Y2F0ZWdvcnk6IjdrajNwbTQyIg=="
    )

    static var previews: some View {
        QueryPreview(op) { data in
            List {
                LeaderboardRunsList(leaderboard: data.viewer!.leaderboard!.asFragment())
            }
        }
        .previewPayload(op, resource: "LeaderboardScreenPreview")
    }
}
