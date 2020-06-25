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
    @State private var searchText = ""
    @State private var queryText = ""
    @State private var isInspectorPresented = false

    private let queryDelayer = PassthroughSubject<String, Never>()

    init(initialQuery: String = "") {
        _searchText = State(wrappedValue: initialQuery)
        _queryText = State(wrappedValue: initialQuery)
    }

    var body: some View {
        VStack {
            TextField("Search games…", text: $searchText)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            VStack {
                if !queryText.isEmpty {
                    switch query.get(.init(query: queryText)) {
                    case .loading:
                        Text("Loading…")
                    case .failure(let error):
                        Text("Error: \(error.localizedDescription)")
                    case .success(let data):
                        if let viewer = data?.viewer {
                            GameSearchResults(games: viewer)
                        }
                    }
                }
            }.frame(maxHeight: .infinity)
        }
        .navigationBarTitle("Games")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                #if DEBUG
                Button(
                    action: { isInspectorPresented = true},
                    label: { Image(systemName: "briefcase") }
                ).sheet(isPresented: $isInspectorPresented) {
                    NavigationView {
                        RelaySwiftUI.Inspector()
                    }.relayEnvironment(environment)
                }
                #else
                EmptyView()
                #endif
            }
        }
        .onChange(of: searchText) { newText in
            queryDelayer.send(newText)
        }
        .onReceive(queryDelayer.debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)) { text in
            queryText = text
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
            GameSearchScreen(initialQuery: "link's awak")
        }.relayEnvironment(mockEnvironment)
    }
}
