import SwiftUI
import RelaySwiftUI

private let runFragment = graphql("""
fragment RunDetailInfo_run on Run {
  game {
    name
  }
  category {
    name
  }
  players {
    ...RunPlayerRow_player
    ...on UserRunPlayer {
      user {
        name
      }
    }
    ...on GuestRunPlayer {
      name
    }
  }
}
""")

struct RunDetailInfo: View {
    @Fragment<RunDetailInfo_run> var run

    @ViewBuilder var body: some View {
        if let run = run {
            Section(header: Text(run.players.count == 1 ? "PLAYER" : "PLAYERS")) {
                ForEach(run.players, id: \.name) { player in
                    RunPlayerRow(player: player.asFragment())
                }
            }
            
            Section {
                HStack {
                    Text("Game")
                    Spacer()
                    Text(run.game.name ?? "Unknown")
                        .foregroundColor(.secondary)
                }
                HStack {
                    Text("Category")
                    Spacer()
                    Text(run.category.name)
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

private extension RunDetailInfo_run.Data.RunPlayer_players {
    var name: String {
        switch self {
        case .userRunPlayer(let player):
            return player.user?.name ?? ""
        case .guestRunPlayer(let player):
            return player.name
        default:
            return ""
        }
    }
}

private let previewQuery = graphql("""
query RunDetailInfoPreviewQuery($id: ID!) {
  node(id: $id) {
    ...on Run {
      ...RunDetailInfo_run
    }
  }
}
""")

struct RunDetailInfo_Previews: PreviewProvider {
    static let op = RunDetailInfoPreviewQuery(id: "foo")

    static var previews: some View {
        Group {
            ForEach(["TGH", "Glan"], id: \.self) { player in
                QueryPreview(op) { data in
                    List {
                        RunDetailInfo(run: data.node!.asRun!.asFragment())
                    }.listStyle(GroupedListStyle())
                }
                .previewPayload(op, resource: "RunDetailInfoPreview_\(player)")
            }
        }
    }
}
