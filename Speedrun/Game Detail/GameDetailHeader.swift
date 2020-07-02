import SwiftUI
import class Relay.MockEnvironment
import RelaySwiftUI

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

    var body: some View {
        VStack(alignment: .center) {
            Group {
                if let cover = game?.cover {
                    AsyncImage(url: URL(string: cover.uri)!,
                               placeholder: ImagePlaceholder())
                        .aspectRatio(contentMode: .fit)
                } else {
                    ImagePlaceholder()
                }
            }.frame(height: 200)

            Text(game?.name ?? "")
                .fontWeight(.semibold)
                .foregroundColor(Color("GameHeaderText", bundle: nil))
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .font(.title)
                .textCase(.none)
        }
            .frame(maxWidth: .infinity)
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
