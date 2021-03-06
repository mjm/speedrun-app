// Auto-generated by relay-compiler. Do not edit.

import Relay

public struct LeaderboardHeader_category {
    public var fragmentPointer: FragmentPointer

    public init(key: LeaderboardHeader_category_Key) {
        fragmentPointer = key.fragment_LeaderboardHeader_category
    }

    public static var node: ReaderFragment {
        ReaderFragment(
            name: "LeaderboardHeader_category",
            type: "Category",
            selections: [
                .field(ReaderScalarField(
                    name: "name"
                ))
            ]
        )
    }
}

extension LeaderboardHeader_category {
    public struct Data: Decodable {
        public var name: String
    }
}

public protocol LeaderboardHeader_category_Key {
    var fragment_LeaderboardHeader_category: FragmentPointer { get }
}

extension LeaderboardHeader_category: Relay.Fragment {}

#if swift(>=5.3) && canImport(RelaySwiftUI)
import RelaySwiftUI

extension LeaderboardHeader_category_Key {
    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    public func asFragment() -> RelaySwiftUI.FragmentNext<LeaderboardHeader_category> {
        RelaySwiftUI.FragmentNext<LeaderboardHeader_category>(self)
    }
}
#endif