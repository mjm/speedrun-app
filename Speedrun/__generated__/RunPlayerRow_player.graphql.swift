// Auto-generated by relay-compiler. Do not edit.

import Relay

struct RunPlayerRow_player {
    var fragmentPointer: FragmentPointer

    init(key: RunPlayerRow_player_Key) {
        fragmentPointer = key.fragment_RunPlayerRow_player
    }

    static var node: ReaderFragment {
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
            ])
    }
}


extension RunPlayerRow_player {
    enum Data: Decodable {
        case userRunPlayer(UserRunPlayer)
        case guestRunPlayer(GuestRunPlayer)
        case runPlayer(RunPlayer)

        private enum TypeKeys: String, CodingKey {
            case __typename
        }
  
        init(from decoder: Decoder) throws {
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

        var asUserRunPlayer: UserRunPlayer? {
            if case .userRunPlayer(let val) = self {
                return val
            }
            return nil
        }

        var asGuestRunPlayer: GuestRunPlayer? {
            if case .guestRunPlayer(let val) = self {
                return val
            }
            return nil
        }

        var asRunPlayer: RunPlayer? {
            if case .runPlayer(let val) = self {
                return val
            }
            return nil
        }

        struct UserRunPlayer: Decodable {
            var user: User_user?

            struct User_user: Decodable {
                var name: String?
                var nameStyle: UserNameStyle_nameStyle

                enum UserNameStyle_nameStyle: Decodable {
                    case solidUserNameStyle(SolidUserNameStyle)
                    case gradientUserNameStyle(GradientUserNameStyle)
                    case userNameStyle(UserNameStyle)

                    private enum TypeKeys: String, CodingKey {
                        case __typename
                    }
  
                    init(from decoder: Decoder) throws {
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

                    var asSolidUserNameStyle: SolidUserNameStyle? {
                        if case .solidUserNameStyle(let val) = self {
                            return val
                        }
                        return nil
                    }

                    var asGradientUserNameStyle: GradientUserNameStyle? {
                        if case .gradientUserNameStyle(let val) = self {
                            return val
                        }
                        return nil
                    }

                    var asUserNameStyle: UserNameStyle? {
                        if case .userNameStyle(let val) = self {
                            return val
                        }
                        return nil
                    }

                    struct SolidUserNameStyle: Decodable {
                        var color: Color_color

                        struct Color_color: Decodable {
                            var light: String
                        }
                    }

                    struct GradientUserNameStyle: Decodable {
                        var fromColor: Color_fromColor
                        var toColor: Color_toColor

                        struct Color_fromColor: Decodable {
                            var light: String
                        }

                        struct Color_toColor: Decodable {
                            var light: String
                        }
                    }

                    struct UserNameStyle: Decodable {
                    }
                }
            }
        }

        struct GuestRunPlayer: Decodable {
            var name: String
        }

        struct RunPlayer: Decodable {
        }
    }
}

protocol RunPlayerRow_player_Key {
    var fragment_RunPlayerRow_player: FragmentPointer { get }
}

extension RunPlayerRow_player: Relay.Fragment {}
