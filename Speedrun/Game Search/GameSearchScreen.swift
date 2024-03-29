import Combine
import SwiftUI
import Relay
import RelaySwiftUI
import SpeedrunGenerated

private let query = graphql("""
query GameSearchScreenQuery($query: String!) {
  viewer {
    ...GameSearchResults_games @arguments(query: $query)
  }
}
""")

struct GameSearchScreen: View {
    @RelayEnvironment var environment: Relay.Environment
    @Query<GameSearchScreenQuery> var query
    @StateObject private var searchDelayer = SearchDelayer()
    @State private var isInspectorPresented = false
    @SceneStorage("gameSearchInput") var searchInput = ""

    init(initialQuery: String = "") {
        _searchInput = SceneStorage(wrappedValue: initialQuery, "gameSearchInput")
    }

    var body: some View {
        VStack {
            if !searchDelayer.query.isEmpty {
                switch query.get(query: searchDelayer.query) {
                case .loading:
                    Loading()
                case .failure(let error):
                    Text("Error: \(error.localizedDescription)")
                case .success(let data):
                    if let viewer = data?.viewer {
                        GameSearchResults(games: viewer.asFragment())
                    }
                }
            }
        }
        .frame(maxHeight: .infinity)
        .searchable(text: $searchInput)
        .onAppear {
            searchDelayer.inputText = searchInput
            searchDelayer.query = searchInput
        }
        .onChange(of: searchInput) { newInput in
            searchDelayer.inputText = newInput
        }
        .navigationBarTitle("Games")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                #if DEBUG
                Button {
                    isInspectorPresented = true
                } label: {
                    Image(systemName: "briefcase")
                }
                #else
                EmptyView()
                #endif
            }
        }
        #if DEBUG
        .sheet(isPresented: $isInspectorPresented) {
            NavigationView {
                RelaySwiftUI.Inspector()
            }.relayEnvironment(environment)
        }
        #endif
    }
}

private class SearchDelayer: ObservableObject {
    @Published var inputText: String = ""
    @Published var query: String = ""

    init() {
        $inputText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .assign(to: &$query)
    }
}

struct GameSearchScreen_Previews: PreviewProvider {
    static let op = GameSearchScreenQuery(query: "link's awak")

    static var previews: some View {
        NavigationView {
            GameSearchScreen(initialQuery: "link's awak")
        }
        .previewPayload(op, resource: "GameSearchScreenPreview")
    }
}
