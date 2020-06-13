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
