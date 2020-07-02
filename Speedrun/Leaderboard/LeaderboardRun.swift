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
    @Fragment<LeaderboardRun_run> var run

    @ViewBuilder var body: some View {
        if let run = run {
            HStack(alignment: .firstTextBaseline) {
                Text(ordinalFormatter.string(from: run.place as NSNumber)!)
                    .font(.callout)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(run.run.players.first?.asUserRunPlayer?.user?.name ?? "(unknown name)")
                        .font(.headline)
                    if !run.run.comment.isEmpty {
                        Text(run.run.comment)
                            .lineLimit(2)
                            .font(Font.caption.italic())
                            .foregroundColor(.secondary)
                    }
                }
                
                Spacer()
                
                if run.run.time != nil {
                    Text(runTimeFormatter.string(from: run.run.time!)!)
                        .font(.callout)
                }
            }.padding(.vertical, 4)
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
    static let op = LeaderboardRunPreviewQuery()

    static var previews: some View {
        QueryPreview(op) { data in
            List(data.viewer!.leaderboard!.runs, id: \.run.id) { run in
                LeaderboardRun(run: run.asFragment())
            }
        }
        .previewPayload(op, resource: "LeaderboardRunPreview")
    }
}
