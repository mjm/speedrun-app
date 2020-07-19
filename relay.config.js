module.exports = {
    src: "./Speedrun",
    schema: "schema.graphql",
    language: "swift",
    artifactDirectory: "./SpeedrunCommon/Sources/SpeedrunGenerated",
    customScalars: {
        Time: "String",
        Cursor: "String",
    },
};
