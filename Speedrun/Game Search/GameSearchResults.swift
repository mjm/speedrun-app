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
    @PaginationFragment(GameSearchResults_games.self) var games

    init(games: GameSearchResults_games_Key) {
        $games = games
    }

    private var gameNodes: [GameSearchResults_games.Data.GameConnection_games.GameEdge_edges.Game_node] {
        games?.games.edges.map { $0.node } ?? []
    }

    var body: some View {
        Group {
            if games != nil {
                List(gameNodes, id: \.id) { game in
                    NavigationLink(destination: GameDetailScreen(id: game.id)) {
                        GameSearchResultRow(game: game)
                    }
                }
                .listStyle(PlainListStyle())
            }
        }
    }
}

struct GameSearchResults_Previews: PreviewProvider {
    static let op = GameSearchResultsPaginationQuery(variables: .init(query: "link's aw"))

    static var previews: some View {
        QueryPreview(op) { data in
            GameSearchResults(games: data.viewer!)
        }
        .navigationBarTitle("Games")
        .previewPayload(op, resource: "GameSearchResultsPreview")
    }
}
