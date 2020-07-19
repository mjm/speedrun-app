import SwiftUI
import RelaySwiftUI
import SpeedrunGenerated

private let query = graphql("""
query RunDetailScreenQuery($id: ID!) {
  node(id: $id) {
    ...on Run {
      ...RunDetailInfo_run
    }
  }
}
""")

struct RunDetailScreen: View {
    let id: String

    @Query<RunDetailScreenQuery> var query

    var body: some View {
        switch query.get(id: id) {
        case .loading:
            Text("Loading…")
        case .failure(let error):
            Text("Error: \(error.localizedDescription)")
        case .success(let data):
            if let run = data?.node?.asRun {
                List {
                    RunDetailInfo(run: run.asFragment())
                }
                .listStyle(InsetGroupedListStyle())
            }
        }
    }
}
