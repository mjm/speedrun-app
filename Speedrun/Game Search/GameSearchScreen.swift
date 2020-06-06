import Combine
import SwiftUI
import RelaySwiftUI

private let query = graphql("""
query GameSearchScreenQuery($query: String!) {
  viewer {
    games(filter: { name: $query }) {
      edges {
        node {
          id
          name
        }
      }
    }
  }
}
""")

struct GameSearchScreen: View {
    @Query(GameSearchScreenQuery.self) var query
    @State private var searchText = ""

    private let queryDelayer = PassthroughSubject<String, Never>()

    private var searchTextBinding: Binding<String> {
        Binding(get: { self.searchText }, set: {
            self.searchText = $0
            self.queryDelayer.send($0)
        })
    }

    init() {
        $query = .init(query: "")
    }

    var body: some View {
        VStack {
            TextField("Search Query", text: searchTextBinding)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            VStack {
                if !$query.query.isEmpty {
                    if query.isLoading {
                        Text("Loading…")
                    } else if query.error != nil {
                        Text("Error: \(query.error!.localizedDescription)")
                    } else if games.isEmpty {
                        Text("No games found")
                    } else {
                        List(games, id: \.id) { game in
                            Text(game.name ?? "Name unknown")
                        }
                    }
                }
            }.frame(maxHeight: .infinity)
        }
            .navigationBarTitle("Games")
            .onReceive(queryDelayer.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)) { text in
                self.$query.query = text
            }
    }

    typealias Game = GameSearchScreenQuery.Data.Viewer_viewer.GameConnection_games.GameEdge_edges.Game_node

    private var games: [Game] {
        query.data?.viewer?.games.edges.map { $0.node } ?? []
    }
}
