import SwiftUI
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
                        } else {
                            AsyncImage(url: URL(string: game!.cover!.uri)!,
                                       placeholder: ImagePlaceholder())
                                .aspectRatio(contentMode: .fit)
                        }
                    }.frame(width: 80)

                    Text(game!.name ?? "Name unknown")
                        .font(.headline)
                }
            }
        }
    }
}
