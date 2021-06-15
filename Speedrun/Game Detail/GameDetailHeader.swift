import SwiftUI
import RelaySwiftUI
import SpeedrunGenerated

private let gameFragment = graphql("""
fragment GameDetailHeader_game on Game {
  name
  cover: asset(kind: COVER_MEDIUM) {
    uri
  }
}
""")

struct GameDetailHeader: View {
    @Fragment<GameDetailHeader_game> var game

    private var coverURL: URL? {
        (game?.cover?.uri).flatMap { URL(string: $0) }
    }

    var body: some View {
        HStack(alignment: .center, spacing: 12) {
            AsyncImage(url: coverURL) { image in
                image
                    .resizable()
                    .renderingMode(.original)
                    .aspectRatio(contentMode: .fit)
            } placeholder: {
                ImagePlaceholder()
            }
            .frame(width: 60)

            Text(game?.name ?? "")
                .fontWeight(.semibold)
                .foregroundColor(Color("GameHeaderText", bundle: nil))
                .lineLimit(3)
                .multilineTextAlignment(.leading)
                .font(Font.title3)
                .textCase(.none)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, -40)
    }
}

struct GameDetailHeader_Previews: PreviewProvider {
    static let op = GameDetailScreenQuery(id: "Z2FtZToieWQ0bzMydzEi")

    static var previews: some View {
        QueryPreview(op) { data in
            NavigationView {
                List {
                    Section(header: GameDetailHeader(game: data.game!.asFragment())) {
                        EmptyView()
                    }
                }
                .listStyle(GroupedListStyle())
            }
        }
        .previewPayload(op, resource: "GameDetailScreenPreview")
    }
}
