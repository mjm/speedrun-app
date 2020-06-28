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
    @StateObject private var searchDelayer: SearchDelayer
    @State private var isInspectorPresented = false

    init(initialQuery: String = "") {
        _searchDelayer = StateObject(wrappedValue: SearchDelayer(text: initialQuery))
    }

    var body: some View {
        VStack {
            TextField("Search games…", text: $searchDelayer.inputText)
                .padding(.horizontal)
                .textFieldStyle(RoundedBorderTextFieldStyle())

            VStack {
                if !searchDelayer.query.isEmpty {
                    switch query.get(.init(query: searchDelayer.query)) {
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
    }
}

private class SearchDelayer: ObservableObject {
    @Published var inputText: String
    @Published var query: String

    init(text: String) {
        inputText = text
        query = text

        $inputText
            .debounce(for: .milliseconds(500), scheduler: DispatchQueue.main)
            .assign(to: $query)
    }
}

struct GameSearchScreen_Previews: PreviewProvider {
    static let op = GameSearchScreenQuery(variables: .init(query: "link's awak"))

    static var previews: some View {
        GameSearchScreen(initialQuery: "link's awak")
            .previewPayload(op, resource: "GameSearchScreenPreview")
    }
}
