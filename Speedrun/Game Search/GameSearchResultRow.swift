import SwiftUI
import class Relay.MockEnvironment
import RelaySwiftUI

private let gameFragment = graphql("""
fragment GameSearchResultRow_game on Game {
    name
    cover: asset(kind: COVER_MEDIUM) {
        uri
    }
}
""")

struct GameSearchResultRow: View {
    @Fragment<GameSearchResultRow_game> var game

    @ViewBuilder var body: some View {
        if let game = game {
            HStack {
                Group {
                    if let cover = game.cover {
                        AsyncImage(
                            url: URL(string: cover.uri)!,
                            placeholder: ImagePlaceholder()
                                .frame(width: 80, height: 80))
                            .aspectRatio(contentMode: .fit)
                    } else {
                        ImagePlaceholder()
                            .frame(width: 80, height: 80)
                    }
                }
                .frame(width: 80)
                
                Text(game.name ?? "Name unknown")
                    .font(.headline)
            }
        }
    }
}

private let previewQuery = graphql("""
query GameSearchResultRowPreviewQuery($id: ID!) {
  game(id: $id) {
    ...GameSearchResultRow_game
  }
}
""")

struct GameSearchResultRow_Previews: PreviewProvider {
    static let op = GameSearchResultRowPreviewQuery(id: UUID().uuidString)

    static var previews: some View {
        List {
            QueryPreview(op) { data in
                GameSearchResultRow(game: data.game!.asFragment())
            }
            .previewPayload(op, resource: "GameSearchResultRowPreview_LAS")

            QueryPreview(op) { data in
                GameSearchResultRow(game: data.game!.asFragment())
            }
            .previewPayload(op, resource: "GameSearchResultRowPreview_Empty")
        }
    }
}
