import SwiftUI
import Relay
import RelaySwiftUI

@main
struct SpeedrunApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                GameSearchScreen()
            }.relayEnvironment(environment)
        }
    }
}
