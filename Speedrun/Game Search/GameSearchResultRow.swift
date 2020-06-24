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
    static let mockEnvironment = MockEnvironment()
    static let mockID1 = UUID().uuidString
    static let mockID2 = UUID().uuidString

    static let completeFragment: [String: Any] = [
        "name": "Link's Awakening (2019)",
        "cover": [
            "uri": "https://www.speedrun.com/themes/las/cover-256.png?version=e4b0e636",
        ],
    ]

    static let missingDataFragment: [String: Any] = [
        "name": NSNull(),
        "cover": NSNull(),
    ]

    static var previews: some View {
        let op1 = GameSearchResultRowPreviewQuery(variables: .init(id: mockID1))
        mockEnvironment.cachePayload(op1, [
            "data": [
                "game": completeFragment,
            ],
        ])
        let op2 = GameSearchResultRowPreviewQuery(variables: .init(id: mockID2))
        mockEnvironment.cachePayload(op2, [
            "data": [
                "game": missingDataFragment,
            ],
        ])

        return Group {
            List {
                QueryPreview(op1) { data in
                    GameSearchResultRow(game: data.game!)
                }
                QueryPreview(op2) { data in
                    GameSearchResultRow(game: data.game!)
                }
            }
                .relayEnvironment(mockEnvironment)
        }
    }
}
