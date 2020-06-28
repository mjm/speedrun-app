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
    static let op = GameDetailScreenQuery(variables: .init(id: "Z2FtZToieWQ0bzMydzEi"))

    static var previews: some View {
        NavigationView {
            GameDetailScreen(id: "Z2FtZToieWQ0bzMydzEi")
        }
        .previewPayload(op, resource: "GameDetailScreenPreview")
    }
}
