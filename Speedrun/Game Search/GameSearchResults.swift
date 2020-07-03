import SwiftUI
import class Relay.MockEnvironment
import RelaySwiftUI

private let gamesFragment = graphql("""
fragment GameSearchResults_games on Viewer
  @refetchable(queryName: "GameSearchResultsPaginationQuery")
  @argumentDefinitions(
    query: { type: "String!" }
    count: { type: "Int", defaultValue: 10 }
    cursor: { type: "Cursor" }
  ) {
  games(
    filter: { name: $query }
    first: $count
    after: $cursor
  )
  @connection(key: "GameSearchResults_games", filters: ["filter"]) {
    edges {
      node {
        id
        ...GameSearchResultRow_game
      }
    }
  }
}
""")

struct GameSearchResults: View {
    @PaginationFragment<GameSearchResults_games> var games

    @ViewBuilder var body: some View {
        if let games = games {
            List(games.games) { game in
                NavigationLink(destination: GameDetailScreen(id: game.id)) {
                    GameSearchResultRow(game: game.asFragment())
                }
            }
            .listStyle(PlainListStyle())
        }
    }
}

struct GameSearchResults_Previews: PreviewProvider {
    static let op = GameSearchResultsPaginationQuery(query: "link's aw")

    static var previews: some View {
        QueryPreview(op) { data in
            GameSearchResults(games: data.viewer!.asFragment())
        }
        .navigationBarTitle("Games")
        .previewPayload(op, resource: "GameSearchResultsPreview")
    }
}
