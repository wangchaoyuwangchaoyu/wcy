
import PackageDescription

let package = Package(
    name: "DeckOfPlayingCards",
	pkgConfig: "gtk+-3.0",//SwiftPM会搜索gtk+-3.0.pc文件
	providers: [//SwiftPM不会执行该命令，只会提供建议"未安装GTK 3软件包"
        .brew(["gtk3"]),
        .apt(["gtk3"])
    ]
    products: [
		.executable(name: "tool", targets: ["tool"]),//只有在需要将可执行文件提供给其他软件包时才能使用该功能。
        .library(name: "DeckOfPlayingCards", targets: ["DeckOfPlayingCards"]),//DeckOfPlayingCards可以被当做公共的API用
    ],
    dependencies: [
        .package(url: "https://github.com/apple/example-package-fisheryates.git", from: "2.0.0"),
        .package(url: "https://github.com/apple/example-package-playingcard.git", from: "3.0.0"),
		.package(url: "../project", .upToNextMinor(from: "1.5.8")),//1.5.8 ..< 1.6.0
    ],
    targets: [
        .target(
            name: "DeckOfPlayingCards",//DeckOfPlayingCards依赖于"FisherYates", "PlayingCard
            dependencies: ["FisherYates", "PlayingCard"]),
        .testTarget(
            name: "DeckOfPlayingCardsTests",//DeckOfPlayingCardsTests依赖于DeckOfPlayingCards（target）
            dependencies: ["DeckOfPlayingCards"]),
    ]
)

/*
// 1.0.0 ..< 2.0.0
.package(url: "/SwiftyJSON", from: "1.0.0"),

// 1.2.0 ..< 2.0.0
.package(url: "/SwiftyJSON", from: "1.2.0"),

// 1.5.8 ..< 2.0.0
.package(url: "/SwiftyJSON", from: "1.5.8"),

// 1.5.8 ..< 2.0.0
.package(url: "/SwiftyJSON", .upToNextMajor(from: "1.5.8")),

// 1.5.8 ..< 1.6.0
.package(url: "/SwiftyJSON", .upToNextMinor(from: "1.5.8")),

// 1.5.8
.package(url: "/SwiftyJSON", .exact("1.5.8")),

.package(url: "/SwiftyJSON", "1.2.3"..<"1.2.6"),

.package(url: "/SwiftyJSON", "1.2.3"..."1.2.8"),

// Branch and revision.
.package(url: "/SwiftyJSON", .branch("develop")),
.package(url: "/SwiftyJSON", .revision("e74b07278b926c9ec6f9643455ea00d1ce04a021"))
*/

