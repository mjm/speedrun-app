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

private let previewQuery = graphql("""
query GameDetailHeaderPreviewQuery($id: ID!) {
  game(id: $id) {
    ...GameDetailHeader_game
  }
}
""")

struct GameDetailHeader_Previews: PreviewProvider {
    static let mockEnvironment = MockEnvironment()

    static let mockGameID = UUID().uuidString

    static let gameFragment: [String: Any] = [
        "name": "The Legend of Zelda: Link's Awakening (2019)",
        "cover": [
            "uri": "https://www.speedrun.com/themes/las/cover-256.png?version=e4b0e636",
        ],
    ]

    static var previews: some View {
        let op = GameDetailHeaderPreviewQuery(variables: .init(id: mockGameID))
        mockEnvironment.cachePayload(op, [
            "data": [
                "game": gameFragment
            ],
        ])

        return Group {
            QueryPreview(op) { data in
                NavigationView {
                    List {
                        Section(header: GameDetailHeader(game: data.game!)) {
                            EmptyView()
                        }
                    }.listStyle(GroupedListStyle())
                }
            }
        }.relayEnvironment(mockEnvironment)
    }
}
