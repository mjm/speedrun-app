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
    @Fragment<RunPlayerRow_player> var player

    @ViewBuilder var body: some View {
        switch player {
        case .userRunPlayer(let userPlayer):
            if let user = userPlayer.user {
                UserRunPlayerRow(user: user)
            }
        case .guestRunPlayer(let guestPlayer):
            GuestRunPlayerRow(player: guestPlayer)
        default:
            EmptyView()
        }
    }

    struct UserRunPlayerRow: View {
        var user: RunPlayerRow_player.Data.UserRunPlayer.User_user

        var body: some View {
            HStack {
                Label {
                    Text(user.name ?? "")
                } icon: {
                    filledIcon
                }
                .font(.headline)
            }
        }

        var filledIcon: some View {
            let image = Image(systemName: "person.crop.circle.fill")
            return Group {
                if let style = user.nameStyle.asGradientUserNameStyle {
                    if style.toColor.light != style.fromColor.light {
                        image
                            .overlay(
                                LinearGradient(
                                    gradient: Gradient(colors: [
                                        Color(hex: style.fromColor.light),
                                        Color(hex: style.toColor.light),
                                    ]),
                                    startPoint: .top,
                                    endPoint: .bottom
                                )
                                .mask(image))
                    } else {
                        image
                            .foregroundColor(Color(hex: style.toColor.light))
                    }
                } else if let style = user.nameStyle.asSolidUserNameStyle {
                    image
                        .foregroundColor(Color(hex: style.color.light))
                } else {
                    image
                        .foregroundColor(Color.black)
                }
            }
        }
    }

    struct GuestRunPlayerRow: View {
        var player: RunPlayerRow_player.Data.GuestRunPlayer

        var body: some View {
            Label(player.name, systemImage: "person.crop.circle.badge.questionmark")
                .font(.headline)
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
    static let op = RunPlayerRowPreviewQuery(id: "foo")

    static var previews: some View {
        QueryPreview(op) { data in
            List(data.node!.asRun!.players.indices, id: \.self) { idx in
                RunPlayerRow(player: data.node!.asRun!.players[idx].asFragment())
            }
            .listStyle(GroupedListStyle())
        }
        .previewPayload(op, resource: "RunPlayerRowPreview")
        .previewLayout(.fixed(width: 400, height: 250))
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
