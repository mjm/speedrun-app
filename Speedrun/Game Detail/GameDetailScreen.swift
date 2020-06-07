import SwiftUI
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
    @Query(GameDetailScreenQuery.self) var query

    init(id: String) {
        $query = .init(id: id)
    }

    var body: some View {
        Group {
            if query.isLoading {
                Text("Loading…")
            } else if query.error != nil {
                Text("Error: \(query.error!.localizedDescription)")
            } else if query.data?.game != nil {
                List {
                    Section(header: GameDetailHeader(game: query.data!.game!)) {
                        EmptyView()
                    }

                    Section(header: Text("LEADERBOARDS")) {
                        GameDetailLeaderboardList(game: query.data!.game!)
                    }
                }
                    .listStyle(GroupedListStyle())
            }
        }
    }
}
