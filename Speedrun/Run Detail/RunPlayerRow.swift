import SwiftUI
import RelaySwiftUI

private let playerFragment = graphql("""
fragment RunPlayerRow_player on RunPlayer {
  ...on UserRunPlayer {
    user {
      name
      nameStyle {
        ...on SolidUserNameStyle {
          color {
            light
          }
        }
        ...on GradientUserNameStyle {
          fromColor {
            light
          }
          toColor {
            light
          }
        }
      }
    }
  }
  ...on GuestRunPlayer {
    name
  }
}
""")

struct RunPlayerRow: View {
    @Fragment(RunPlayerRow_player.self) var player

    init(player: RunPlayerRow_player_Key) {
        $player = player
    }

    var body: some View {
        Group {
            if player?.asUserRunPlayer?.user != nil {
                UserRunPlayerRow(user: player!.asUserRunPlayer!.user!)
            } else if player?.asGuestRunPlayer != nil {
                GuestRunPlayerRow(player: player!.asGuestRunPlayer!)
            }
        }
    }

    struct UserRunPlayerRow: View {
        var user: RunPlayerRow_player.Data.UserRunPlayer.User_user

        var body: some View {
            HStack {
                Circle()
                    .fill(dotBackground)
                    .shadow(radius: 2)
                    .aspectRatio(1, contentMode: .fit)
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.vertical, 8)
                Text(user.name ?? "").font(.headline)
            }
        }

        var dotBackground: some ShapeStyle {
            let gradient: Gradient
            if user.nameStyle.asGradientUserNameStyle != nil {
                gradient = Gradient(colors: [
                    Color(hex: user.nameStyle.asGradientUserNameStyle!.fromColor.light),
                    Color(hex: user.nameStyle.asGradientUserNameStyle!.toColor.light),
                ])
            } else if user.nameStyle.asSolidUserNameStyle != nil {
                gradient = Gradient(colors: [Color(hex: user.nameStyle.asSolidUserNameStyle!.color.light)])
            } else {
                gradient = Gradient(colors: [.black])
            }
            return LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom)
        }
    }

    struct GuestRunPlayerRow: View {
        var player: RunPlayerRow_player.Data.GuestRunPlayer

        var body: some View {
            Text(player.name).font(.headline)
        }
    }
}

private let previewQuery = graphql("""
query RunPlayerRowPreviewQuery($id: ID!) {
  node(id: $id) {
    ...on Run {
      players {
        ...RunPlayerRow_player
      }
    }
  }
}
""")

struct RunPlayerRow_Previews: PreviewProvider {
    static let mockEnvironment = MockEnvironment()

    static let mockRunID = UUID().uuidString

    static let playerFragments: [[String: Any]] = [
        [
            "__typename": "UserRunPlayer",
            "user": [
                "name": "TGH",
                "nameStyle": [
                    "__typename": "GradientUserNameStyle",
                    "fromColor": [
                      "light": "#808080",
                    ],
                    "toColor": [
                      "light": "#000000",
                    ],
                ],
            ],
        ],
        [
            "__typename": "UserRunPlayer",
            "user": [
                "name": "Skurry",
                "nameStyle": [
                    "__typename": "GradientUserNameStyle",
                    "fromColor": [
                        "light": "#EF2081",
                    ],
                    "toColor": [
                        "light": "#009856",
                    ],
                ],
            ],
        ],
        [
            "__typename": "GuestRunPlayer",
            "name": "MattMattPartyHat",
        ],
    ]


    static var previews: some View {
        let op = RunPlayerRowPreviewQuery(variables: .init(id: mockRunID))
        mockEnvironment.cachePayload(op, [
            "data": [
                "node": [
                    "__typename": "Run",
                    "players": playerFragments,
                ],
            ],
        ])

        return Group {
            QueryPreview(op) { data in
                return List(data.node!.asRun!.players.indices, id: \.self) { idx in
                    RunPlayerRow(player: data.node!.asRun!.players[idx])
                }.listStyle(GroupedListStyle())
            }
        }
            .relayEnvironment(mockEnvironment)
            .previewLayout(.fixed(width: 400, height: 200))
    }
}

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }

        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
