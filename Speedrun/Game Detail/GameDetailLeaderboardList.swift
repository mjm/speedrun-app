import SwiftUI
import RelaySwiftUI
import SpeedrunGenerated

private let gameFragment = graphql("""
fragment GameDetailLeaderboardList_game on Game
@refetchable(queryName: "GameDetailLeaderboardListRefetchQuery") {
  id
  categories {
    id
    name
  }
}
""")

struct GameDetailLeaderboardList: View {
    @RefetchableFragment<GameDetailLeaderboardList_game> var game

    var body: some View {
        Section(header: HStack {
            Text("Leaderboards")
            Spacer()
            Button {
                game?.refetch()
            } label: {
                Image(systemName: "arrow.clockwise.circle.fill")
                    .font(.system(size: 22))
                    .foregroundColor(.accentColor)
            }
        }) {
            ForEach(game?.categories ?? []) { category in
                NavigationLink(
                    destination: LeaderboardScreen(gameID: game!.id, categoryID: category.id)
                ) {
                    Text(category.name)
                }
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
