import SwiftUI
import class Relay.MockEnvironment
import RelaySwiftUI

private let gameFragment = graphql("""
fragment GameDetailLeaderboardList_game on Game {
  id
  categories {
    id
    name
  }
}
""")

struct GameDetailLeaderboardList: View {
    @Fragment<GameDetailLeaderboardList_game> var game

    var body: some View {
        ForEach(game?.categories ?? []) { category in
            NavigationLink(destination: LeaderboardScreen(gameID: game!.id, categoryID: category.id)) {
                Text(category.name)
            }
        }
    }
}

struct GameDetailLeaderboardList_Previews: PreviewProvider {
    static let op = GameDetailScreenQuery(id: "Z2FtZToieWQ0bzMydzEi")

    static var previews: some View {
        QueryPreview(op) { data in
            NavigationView {
                List {
                    GameDetailLeaderboardList(game: data.game!.asFragment())
                }
                .listStyle(GroupedListStyle())
            }
        }
        .previewPayload(op, resource: "GameDetailScreenPreview")
    }
}
