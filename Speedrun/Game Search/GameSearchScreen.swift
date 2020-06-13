import Combine
import SwiftUI
import Relay
import RelaySwiftUI

private let query = graphql("""
query GameSearchScreenQuery($query: String!) {
  viewer {
    ...GameSearchResults_games @arguments(query: $query)
  }
}
""")

struct GameSearchScreen: View {
    @RelayEnvironment var environment: Relay.Environment
    @Query(GameSearchScreenQuery.self) var query
    @State private var searchText = "link's awak"
    @State private var isInspectorPresented = false

    private let queryDelayer = PassthroughSubject<String, Never>()

    private var searchTextBinding: Binding<String> {
        Binding(get: { self.searchText }, set: {
            self.searchText = $0
            self.queryDelayer.send($0)
        })
    }

    init(initialQuery: String = "link's awak") {
        $query = .init(query: initialQuery)
    }

    var body: some View {
        VStack {
            TextField("Search games…", text: searchTextBinding)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            VStack {
                if !$query.query.isEmpty {
                    if query.isLoading {
                        Text("Loading…")
                    } else if query.error != nil {
                        Text("Error: \(query.error!.localizedDescription)")
                    } else if query.data?.viewer != nil {
                        GameSearchResults(games: query.data!.viewer!)
                    }
                }
            }.frame(maxHeight: .infinity)
        }
            .navigationBarTitle("Games")
            .navigationBarItems(trailing: Group {
                #if DEBUG
                Button(
                    action: { self.isInspectorPresented = true},
                    label: { Image(systemName: "briefcase") }
                ).sheet(isPresented: $isInspectorPresented) {
                    NavigationView {
                        RelaySwiftUI.Inspector()
                    }.relayEnvironment(self.environment)
                }
                #else
                EmptyView()
                #endif
            })
            .onReceive(queryDelayer.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)) { text in
                self.$query.query = text
            }
    }
}

struct GameSearchScreen_Previews: PreviewProvider {
    static let mockEnvironment = Relay.MockEnvironment()

    static let payload = [
        "data": [
            "viewer": GameSearchResults_Previews.gamesFragment,
        ],
    ]

    static var previews: some View {
        let op = GameSearchScreenQuery(variables: .init(query: "link's awak"))
        mockEnvironment.mockResponse(op, payload)

        return Group {
            GameSearchScreen()
        }.relayEnvironment(mockEnvironment)
    }
}
