import SwiftUI
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
    @Fragment(GameDetailHeader_game.self) var game

    init(game: GameDetailHeader_game_Key) {
        $game = game
    }

    var body: some View {
        VStack(alignment: .center) {
            Group {
                if game?.cover == nil {
                    ImagePlaceholder()
                } else {
                    AsyncImage(url: URL(string: game!.cover!.uri)!,
                               placeholder: ImagePlaceholder())
                        .aspectRatio(contentMode: .fit)
                }
            }.frame(height: 200)

            Text(game?.name ?? "")
                .fixedSize(horizontal: false, vertical: true)
                .lineLimit(3)
                .multilineTextAlignment(.center)
                .font(.title)
        }
            .frame(maxWidth: .infinity)
            .padding(.top, -40)
    }
}
