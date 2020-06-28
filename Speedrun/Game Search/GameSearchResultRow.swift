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
    @Fragment(GameSearchResultRow_game.self) var game

    init(game: GameSearchResultRow_game_Key) {
        $game = game
    }

    var body: some View {
        Group {
            if game != nil {
                HStack {
                    Group {
                        if game!.cover == nil {
                            ImagePlaceholder()
                                .frame(width: 80, height: 80)
                        } else {
                            AsyncImage(
                                url: URL(string: game!.cover!.uri)!,
                                placeholder: ImagePlaceholder()
                                    .frame(width: 80, height: 80))
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    .frame(width: 80)

                    Text(game!.name ?? "Name unknown")
                        .font(.headline)
                }
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
    static let op = GameSearchResultRowPreviewQuery(variables: .init(id: UUID().uuidString))

    static var previews: some View {
        List {
            QueryPreview(op) { data in
                GameSearchResultRow(game: data.game!)
            }
            .previewPayload(op, resource: "GameSearchResultRowPreview_LAS")

            QueryPreview(op) { data in
                GameSearchResultRow(game: data.game!)
            }
            .previewPayload(op, resource: "GameSearchResultRowPreview_Empty")
        }
    }
}
