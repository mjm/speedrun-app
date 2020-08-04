import SwiftUI
import RelaySwiftUI
import SpeedrunGenerated

private let gameFragment = graphql("""
fragment LeaderboardHeader_game on Game {
  name
  cover: asset(kind: COVER_MEDIUM) {
    uri
  }
}
""")

private let categoryFragment = graphql("""
fragment LeaderboardHeader_category on Category {
  name
}
""")

struct LeaderboardHeader: View {
    @Fragment<LeaderboardHeader_game> var game
    @Fragment<LeaderboardHeader_category> var category

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            Group {
                if let cover = game?.cover {
                    AsyncImage(url: URL(string: cover.uri)!,
                               placeholder: ImagePlaceholder())
                        .aspectRatio(contentMode: .fit)
                } else {
                    ImagePlaceholder()
                }
            }.frame(width: 60)

            VStack(alignment: .leading, spacing: 8) {
                Text(game?.name ?? "")
                    .fontWeight(.semibold)
                    .foregroundColor(Color("GameHeaderText", bundle: nil))
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .font(Font.title3)
                    .textCase(.none)

                Text(category?.name ?? "")
                    .font(Font.subheadline.weight(.medium))
                    .textCase(.uppercase)
                    .foregroundColor(.secondary)
            }
        }
        .frame(maxWidth: .infinity)
        .padding(.top, -40)
        .padding(.bottom, 10)
    }
}

private let previewQuery = graphql("""
query LeaderboardHeaderPreviewQuery {
    game(id: "foo") {
        ...LeaderboardHeader_game
    }
    category: node(id: "bar") {
        ...LeaderboardHeader_category
    }
}
""")

struct LeaderboardHeader_Previews: PreviewProvider {
    static let op = LeaderboardHeaderPreviewQuery()

    static var previews: some View {
        QueryPreview(op) { data in
            NavigationView {
                List {
                    LeaderboardHeader(
                                game: data.game!.asFragment(),
                                category: data.category!.asFragment())

                    Text("Hello")
                    Text("Goodbye")
                }
                .listStyle(PlainListStyle())
            }
        }
        .previewPayload(op, resource: "LeaderboardHeaderPreview")
    }
}
