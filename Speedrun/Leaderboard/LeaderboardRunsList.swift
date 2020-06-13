import SwiftUI
import RelaySwiftUI

private let leaderboardFragment = graphql("""
fragment LeaderboardRunsList_leaderboard on Leaderboard
  @argumentDefinitions(
    count: { type: "Int!" }
  ) {
  runs(first: $count) {
    run {
      id
    }
    ...LeaderboardRun_run
  }
}
""")

struct LeaderboardRunsList: View {
    @Fragment(LeaderboardRunsList_leaderboard.self) var leaderboard

    init(leaderboard: LeaderboardRunsList_leaderboard_Key) {
        $leaderboard = leaderboard
    }

    var body: some View {
        Group {
            if leaderboard != nil {
                ForEach(leaderboard!.runs, id: \.run.id) { placedRun in
                    LeaderboardRun(run: placedRun)
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
    static let mockEnvironment = MockEnvironment()

    static let leaderboardFragment = [
        "runs": LeaderboardRun_Previews.runFragments
    ]

    static var previews: some View {
        let op = LeaderboardRunsListPreviewQuery()
        mockEnvironment.cachePayload(op, [
            "data": [
                "viewer": [
                    "leaderboard": leaderboardFragment,
                ],
            ],
        ])

        return Group {
            QueryPreview(op) { data in
                List {
                    LeaderboardRunsList(leaderboard: data.viewer!.leaderboard!)
                }
            }
        }.relayEnvironment(mockEnvironment)
    }
}
