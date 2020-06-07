import SwiftUI
import RelaySwiftUI

private let gameFragment = graphql("""
fragment GameDetailLeaderboardList_game on Game {
  categories {
    id
    name
  }
}
""")

struct GameDetailLeaderboardList: View {
    @Fragment(GameDetailLeaderboardList_game.self) var game

    init(game: GameDetailLeaderboardList_game_Key) {
        $game = game
    }

    var body: some View {
        ForEach(game?.categories ?? [], id: \.id) { category in
            Text(category.name)
        }
    }
}
