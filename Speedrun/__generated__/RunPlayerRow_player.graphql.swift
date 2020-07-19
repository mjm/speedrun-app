// Auto-generated by relay-compiler. Do not edit.

import Relay

public struct RunPlayerRow_player {
    public var fragmentPointer: FragmentPointer

    public init(key: RunPlayerRow_player_Key) {
        fragmentPointer = key.fragment_RunPlayerRow_player
    }

    public static var node: ReaderFragment {
        ReaderFragment(
            name: "RunPlayerRow_player",
            type: "RunPlayer",
            selections: [
                .inlineFragment(ReaderInlineFragment(
                    type: "UserRunPlayer",
                    selections: [
                        .field(ReaderLinkedField(
                            name: "user",
                            concreteType: "User",
                            plural: false,
                            selections: [
                                .field(ReaderScalarField(
                                    name: "name"
                                )),
                                .field(ReaderLinkedField(
                                    name: "nameStyle",
                                    plural: false,
                                    selections: [
                                        .inlineFragment(ReaderInlineFragment(
                                            type: "SolidUserNameStyle",
                                            selections: [
                                                .field(ReaderLinkedField(
                                                    name: "color",
                                                    concreteType: "Color",
                                                    plural: false,
                                                    selections: [
                                                        .field(ReaderScalarField(
                                                            name: "light"
                                                        ))
                                                    ]
                                                ))
                                            ]
                                        )),
                                        .inlineFragment(ReaderInlineFragment(
                                            type: "GradientUserNameStyle",
                                            selections: [
                                                .field(ReaderLinkedField(
                                                    name: "fromColor",
                                                    concreteType: "Color",
                                                    plural: false,
                                                    selections: [
                                                        .field(ReaderScalarField(
                                                            name: "light"
                                                        ))
                                                    ]
                                                )),
                                                .field(ReaderLinkedField(
                                                    name: "toColor",
                                                    concreteType: "Color",
                                                    plural: false,
                                                    selections: [
                                                        .field(ReaderScalarField(
                                                            name: "light"
                                                        ))
                                                    ]
                                                ))
                                            ]
                                        ))
                                    ]
                                ))
                            ]
                        ))
                    ]
                )),
                .inlineFragment(ReaderInlineFragment(
                    type: "GuestRunPlayer",
                    selections: [
                        .field(ReaderScalarField(
                            name: "name"
                        ))
                    ]
                ))
            ]
        )
    }
}

extension RunPlayerRow_player {
    public enum Data: Decodable {
        case userRunPlayer(UserRunPlayer)
        case guestRunPlayer(GuestRunPlayer)
        case runPlayer(RunPlayer)

        private enum TypeKeys: String, CodingKey {
            case __typename
        }

        public init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: TypeKeys.self)
            let typeName = try container.decode(String.self, forKey: .__typename)
            switch typeName {
            case "UserRunPlayer":
                self = .userRunPlayer(try UserRunPlayer(from: decoder))
            case "GuestRunPlayer":
                self = .guestRunPlayer(try GuestRunPlayer(from: decoder))
            default:
                self = .runPlayer(try RunPlayer(from: decoder))
            }
        }

        public var asUserRunPlayer: UserRunPlayer? {
            if case .userRunPlayer(let val) = self {
                return val
            }
            return nil
        }

        public var asGuestRunPlayer: GuestRunPlayer? {
            if case .guestRunPlayer(let val) = self {
                return val
            }
            return nil
        }

        public var asRunPlayer: RunPlayer? {
            if case .runPlayer(let val) = self {
                return val
            }
            return nil
        }

        public struct UserRunPlayer: Decodable {
            public var user: User_user?

            public struct User_user: Decodable {
                public var name: String?
                public var nameStyle: UserNameStyle_nameStyle

                public enum UserNameStyle_nameStyle: Decodable {
                    case solidUserNameStyle(SolidUserNameStyle)
                    case gradientUserNameStyle(GradientUserNameStyle)
                    case userNameStyle(UserNameStyle)

                    private enum TypeKeys: String, CodingKey {
                        case __typename
                    }

                    public init(from decoder: Decoder) throws {
                        let container = try decoder.container(keyedBy: TypeKeys.self)
                        let typeName = try container.decode(String.self, forKey: .__typename)
                        switch typeName {
                        case "SolidUserNameStyle":
                            self = .solidUserNameStyle(try SolidUserNameStyle(from: decoder))
                        case "GradientUserNameStyle":
                            self = .gradientUserNameStyle(try GradientUserNameStyle(from: decoder))
                        default:
                            self = .userNameStyle(try UserNameStyle(from: decoder))
                        }
                    }

                    public var asSolidUserNameStyle: SolidUserNameStyle? {
                        if case .solidUserNameStyle(let val) = self {
                            return val
                        }
                        return nil
                    }

                    public var asGradientUserNameStyle: GradientUserNameStyle? {
                        if case .gradientUserNameStyle(let val) = self {
                            return val
                        }
                        return nil
                    }

                    public var asUserNameStyle: UserNameStyle? {
                        if case .userNameStyle(let val) = self {
                            return val
                        }
                        return nil
                    }

                    public struct SolidUserNameStyle: Decodable {
                        public var color: Color_color

                        public struct Color_color: Decodable {
                            public var light: String
                        }
                    }

                    public struct GradientUserNameStyle: Decodable {
                        public var fromColor: Color_fromColor
                        public var toColor: Color_toColor

                        public struct Color_fromColor: Decodable {
                            public var light: String
                        }

                        public struct Color_toColor: Decodable {
                            public var light: String
                        }
                    }

                    public struct UserNameStyle: Decodable {
                    }
                }
            }
        }

        public struct GuestRunPlayer: Decodable {
            public var name: String
        }

        public struct RunPlayer: Decodable {
        }
    }
}

public protocol RunPlayerRow_player_Key {
    var fragment_RunPlayerRow_player: FragmentPointer { get }
}
extension RunPlayerRow_player: Relay.Fragment {}

#if swift(>=5.3) && canImport(RelaySwiftUI)
import RelaySwiftUI
extension RunPlayerRow_player_Key {
    @available(iOS 14.0, macOS 10.16, tvOS 14.0, watchOS 7.0, *)
    public func asFragment() -> RelaySwiftUI.FragmentNext<RunPlayerRow_player> {
        RelaySwiftUI.FragmentNext<RunPlayerRow_player>(self)
    }
}
#endif