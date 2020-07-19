import SwiftUI
import RelaySwiftUI
import SpeedrunGenerated

private let runFragment = graphql("""
fragment RunDetailInfo_run on Run {
  game {
    name
  }
  category {
    name
  }
  videos {
    links {
      uri
    }
  }
  comment
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
    @Environment(\.openURL) var openURL

    @ViewBuilder var body: some View {
        if let run = run {
            if let videos = run.videos, !videos.links.isEmpty {
                Section {
                    ForEach(videos.links, id: \.uri) { link in
                        if let url = URL(string: link.uri), let hostname = url.host {
                            Button {
                                openURL(url)
                            } label: {
                                Label("View on \(hostname.hasPrefix("www.") ? String(hostname.dropFirst(4)) : hostname)", systemImage: "safari.fill")
                            }
                        }
                    }
                }
            }

            ForEach(run.players, id: \.name) { player in
                RunPlayerRow(player: player.asFragment())
            }
            if !run.comment.isEmpty {
                Text(run.comment)
                    .padding(.vertical, 6)
            }
            
            Section {
                HStack {
                    Text("Game")
                    Spacer()
                    Text(run.game.name ?? "Unknown")
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.trailing)
                }
                HStack {
                    Text("Category")
                    Spacer()
                    Text(run.category.name)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.trailing)
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
                    }.listStyle(InsetGroupedListStyle())
                }
                .previewPayload(op, resource: "RunDetailInfoPreview_\(player)")
            }
        }
    }
}
