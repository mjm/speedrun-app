// Auto-generated by relay-compiler. Do not edit.

import Relay

struct LeaderboardRunsListPreviewQuery {
    var variables: Variables

    init(variables: Variables) {
        self.variables = variables
    }

    static var node: ConcreteRequest {
        ConcreteRequest(
            fragment: ReaderFragment(
                name: "LeaderboardRunsListPreviewQuery",
                type: "Query",
                selections: [
                    .field(ReaderLinkedField(
                        name: "viewer",
                        concreteType: "Viewer",
                        plural: false,
                        selections: [
                            .field(ReaderLinkedField(
                                name: "leaderboard",
                                args: [
                                    LiteralArgument(name: "category", value: "bar"),
                                    LiteralArgument(name: "game", value: "foo")
                                ],
                                concreteType: "Leaderboard",
                                plural: false,
                                selections: [
                                    .fragmentSpread(ReaderFragmentSpread(
                                        name: "LeaderboardRunsList_leaderboard",
                                        args: [
                                            LiteralArgument(name: "count", value: 10)
                                        ]
                                    ))
                                ]
                            ))
                        ]
                    ))
                ]),
            operation: NormalizationOperation(
                name: "LeaderboardRunsListPreviewQuery",
                selections: [
                    .field(NormalizationLinkedField(
                        name: "viewer",
                        concreteType: "Viewer",
                        plural: false,
                        selections: [
                            .field(NormalizationLinkedField(
                                name: "leaderboard",
                                args: [
                                    LiteralArgument(name: "category", value: "bar"),
                                    LiteralArgument(name: "game", value: "foo")
                                ],
                                storageKey: "leaderboard(category:\"bar\",game:\"foo\")",
                                concreteType: "Leaderboard",
                                plural: false,
                                selections: [
                                    .field(NormalizationLinkedField(
                                        name: "runs",
                                        args: [
                                            LiteralArgument(name: "first", value: 10)
                                        ],
                                        storageKey: "runs(first:10)",
                                        concreteType: "PlacedRun",
                                        plural: true,
                                        selections: [
                                            .field(NormalizationLinkedField(
                                                name: "run",
                                                concreteType: "Run",
                                                plural: false,
                                                selections: [
                                                    .field(NormalizationScalarField(
                                                        name: "id"
                                                    )),
                                                    .field(NormalizationScalarField(
                                                        name: "comment"
                                                    )),
                                                    .field(NormalizationScalarField(
                                                        name: "time"
                                                    )),
                                                    .field(NormalizationLinkedField(
                                                        name: "players",
                                                        plural: true,
                                                        selections: [
                                                            .field(NormalizationScalarField(
                                                                name: "__typename"
                                                            )),
                                                            .inlineFragment(NormalizationInlineFragment(
                                                                type: "UserRunPlayer",
                                                                selections: [
                                                                    .field(NormalizationLinkedField(
                                                                        name: "user",
                                                                        concreteType: "User",
                                                                        plural: false,
                                                                        selections: [
                                                                            .field(NormalizationScalarField(
                                                                                name: "name"
                                                                            )),
                                                                            .field(NormalizationScalarField(
                                                                                name: "id"
                                                                            ))
                                                                        ]
                                                                    ))
                                                                ]
                                                            )),
                                                            .inlineFragment(NormalizationInlineFragment(
                                                                type: "GuestRunPlayer",
                                                                selections: [
                                                                    .field(NormalizationScalarField(
                                                                        name: "name"
                                                                    ))
                                                                ]
                                                            ))
                                                        ]
                                                    ))
                                                ]
                                            )),
                                            .field(NormalizationScalarField(
                                                name: "place"
                                            ))
                                        ]
                                    ))
                                ]
                            ))
                        ]
                    ))
                ]),
            params: RequestParameters(
                name: "LeaderboardRunsListPreviewQuery",
                operationKind: .query,
                text: """
query LeaderboardRunsListPreviewQuery {
  viewer {
    leaderboard(game: "foo", category: "bar") {
      ...LeaderboardRunsList_leaderboard_1KmBw7
    }
  }
}

fragment LeaderboardRun_run on PlacedRun {
  place
  run {
    id
    comment
    time
    players {
      __typename
      ... on UserRunPlayer {
        user {
          name
          id
        }
      }
      ... on GuestRunPlayer {
        name
      }
    }
  }
}

fragment LeaderboardRunsList_leaderboard_1KmBw7 on Leaderboard {
  runs(first: 10) {
    run {
      id
    }
    ...LeaderboardRun_run
  }
}
"""))
    }
}


extension LeaderboardRunsListPreviewQuery {
    typealias Variables = EmptyVariables
}

extension LeaderboardRunsListPreviewQuery {
    struct Data: Decodable {
        var viewer: Viewer_viewer?

        struct Viewer_viewer: Decodable {
            var leaderboard: Leaderboard_leaderboard?

            struct Leaderboard_leaderboard: Decodable, LeaderboardRunsList_leaderboard_Key {
                var fragment_LeaderboardRunsList_leaderboard: FragmentPointer
            }
        }
    }
}

extension LeaderboardRunsListPreviewQuery: Relay.Operation {}
