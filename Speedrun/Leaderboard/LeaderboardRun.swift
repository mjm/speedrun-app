import SwiftUI
import RelaySwiftUI

private let runFragment = graphql("""
fragment LeaderboardRun_run on PlacedRun {
  place
  run {
    id
    comment
    time
    players {
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
}
""")

struct LeaderboardRun: View {
    @Fragment(LeaderboardRun_run.self) var run

    init(run: LeaderboardRun_run_Key) {
        $run = run
    }

    var body: some View {
        Group {
            if run != nil {
                HStack(alignment: .firstTextBaseline) {
                    Text(ordinalFormatter.string(from: run!.place as NSNumber)!)
                        .font(.callout)

                    VStack(alignment: .leading, spacing: 8) {
                        Text(run!.run.players.first?.asUserRunPlayer?.user?.name ?? "(unknown name)")
                            .font(.headline)
                        if !run!.run.comment.isEmpty {
                            Text(run!.run.comment)
                                .lineLimit(2)
                                .font(Font.caption.italic())
                                .foregroundColor(.secondary)
                        }
                    }

                    Spacer()

                    if run!.run.time != nil {
                        Text(runTimeFormatter.string(from: run!.run.time!)!)
                            .font(.callout)
                    }
                }.padding(.vertical, 4)
            }
        }
    }
}

private let ordinalFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .ordinal
    return formatter
}()

private let runTimeFormatter: DateComponentsFormatter = {
    let formatter = DateComponentsFormatter()
    formatter.unitsStyle = .abbreviated
    formatter.allowedUnits = [.hour, .minute, .second]
    formatter.zeroFormattingBehavior = .dropLeading
    return formatter
}()

private let previewQuery = graphql("""
query LeaderboardRunPreviewQuery {
  viewer {
    leaderboard(game: "foo", category: "bar") {
      runs {
        run {
          id
        }
        ...LeaderboardRun_run
      }
    }
  }
}
""")

struct LeaderboardRun_Previews: PreviewProvider {
    static let mockEnvironment = MockEnvironment()

    static let runFragments: [[String: Any]] = [
        [
            "place": 1,
            "run": [
                "id": UUID().uuidString,
                "comment": "",
                "time": 5997,
                "players": [
                    [
                        "__typename": "UserRunPlayer",
                        "user": [
                            "name": "TGH"
                        ],
                    ],
                ],
            ],
        ],
        [
            "place": 2,
            "run": [
                "id": UUID().uuidString,
                "comment": "happ",
                "time": 6312,
                "players": [
                    [
                        "__typename": "UserRunPlayer",
                        "user": [
                            "name": "Skurry"
                        ],
                    ],
                ],
            ],
        ],
        [
            "place": 3,
            "run": [
                "id": UUID().uuidString,
                "comment": "",
                "time": 6321,
                "players": [
                    [
                        "__typename": "UserRunPlayer",
                        "user": [
                            "name": "Samura1man"
                        ],
                    ],
                ],
            ],
        ],
        [
            "place": 4,
            "run": [
                "id": UUID().uuidString,
                "comment": "Slime eel went very bad, everything else went pretty well. Perfect Nightmare rng",
                "time": 6325,
                "players": [
                    [
                        "__typename": "UserRunPlayer",
                        "user": [
                            "name": "Glan"
                        ],
                    ],
                ],
            ],
        ],
    ]

    static var previews: some View {
        let op = LeaderboardRunPreviewQuery()
        mockEnvironment.cachePayload(op, [
            "data": [
                "viewer": [
                    "leaderboard": [
                        "runs": runFragments,
                    ],
                ],
            ],
        ])

        return Group {
            QueryPreview(op) { data in
                List(data.viewer!.leaderboard!.runs, id: \.run.id) { run in
                    LeaderboardRun(run: run)
                }
            }
        }.relayEnvironment(mockEnvironment)
    }
}
