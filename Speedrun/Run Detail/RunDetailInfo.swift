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
    @Fragment(RunDetailInfo_run.self) var run

    init(run: RunDetailInfo_run_Key) {
        $run = run
    }

    var body: some View {
        Group {
            if run != nil {
                Section(header: Text(run!.players.count == 1 ? "PLAYER" : "PLAYERS")) {
                    ForEach(run!.players, id: \.name) { player in
                        RunPlayerRow(player: player)
                    }
                }

                Section {
                    HStack {
                        Text("Game")
                        Spacer()
                        Text(run!.game.name ?? "Unknown")
                            .foregroundColor(.secondary)
                    }
                    HStack {
                        Text("Category")
                        Spacer()
                        Text(run!.category.name)
                            .foregroundColor(.secondary)
                    }
                }
            }
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
    static let mockEnvironment = MockEnvironment()

    static let mockRunID = UUID().uuidString

    static let runFragment: [String: Any] = [
        "game": [
            "name": "Link's Awakening (2019)",
        ],
        "category": [
            "name": "Glitchless",
        ],
        "players": RunPlayerRow_Previews.playerFragments,
    ]

    static var previews: some View {
        let op = RunDetailInfoPreviewQuery(variables: .init(id: mockRunID))
        mockEnvironment.cachePayload(op, [
            "data": [
                "node": [
                    "__typename": "Run",
                ].merging(runFragment) { $1 },
            ],
        ])

        return Group {
            QueryPreview(op) { data in
                List {
                    RunDetailInfo(run: data.node!.asRun!)
                }.listStyle(GroupedListStyle())
            }
        }.relayEnvironment(mockEnvironment)
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
