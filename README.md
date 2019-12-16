# Steam Analytics
This repo contains simple iOS app which display data from Steam API - friends, own games, play time, some statistics from game (if game collects it), acheivements and so on.
I plan to use this app as playground for my ideas about iOS development and also as showcase of my current skillz :)

[README in Russian 🇷🇺](https://github.com/migonin/SteamAnalytics/blob/master/README_ru.md)

## Architecture features 🌉
- framework-based layers
- test apps for some layers
- clean code. No hidden dependencies and singletons, no `SuperDuperManager.shared.getStuff` and so on. SOLID as it should be.
- SOA
- [generic coordinators](https://github.com/migonin/AnyCoordinatable)
- VIPER screen modules
- unit tests for storages

## Layers 🏠
- `SteamAnalyticsApp`
- `LoginScenes`, `UsersScenes` и `GamesScenes`
- `Services`, `UICommon`, `UICommonTestApp`
- `APIClient`, `Storages`
- `Core`

Each layer can use only underlying layers. Horisontal connections are not allowed also.

## Core ☢️
Base data structures (`User`, `Game` etc).

## Storages 💾
Storages is based on `CoreData` and [CoreStore][CoreStore]. 
Each storage is enclosed with `SomeStorageInput` and `SomeStorageOutput` protocols. Basically only services can use `Input` protocols to save data from API. Interactors of screen modules subscribes for data changes and gets it reactively by `Output` protocols. `Inputs` and `Outputs` uses simple structs from `Core`, `NSManagedObject` and its subclasses are not exposed outside.

## APIClient 📻
At this level `Core` structures are extended to `Codable`. Also there are some networking helpers (`queries`, `url factories`, etc). API clients protocols. Concrete implementation of these protocols uses [Alamofire].

## Services 🛠
`Services` uses `APIClients` to get data from API and then to save it to `Storages`. Also there are services for complex logic like users comparison.

## UICommon 🧩
`UIView` subclasses and its models. [SnapKit] for layout (no xibs), [Kingfisher] for images loading. Also this level contains strings and images, wrapped with [SwiftGen].

### UICommonTestApp 🧪
Test app for all cells and other views. Handy for UI developement and UI tests.

### Coordinators 🔀
`UICommon` also contains generic coordinators. For detailed explanation please check [my other repo](https://github.com/migonin/AnyCoordinatable). Main idea shortly:
- `Coordinatable` protocol with two associated type: `start option` and `result`. 
- `CoordinatorFactoring`, which is used by coordinators to instantiate other coordinators (wrapped with type erased `AnyCoordinatable`) without knowledge of concrete implementation, only of `start option` and `result` types.
- Useful feature: with this approach you can use every coordinator separately in test application. Other coordinators can be stubbed. Please check [`StubCoordinator`](https://github.com/migonin/SteamAnalytics/blob/master/UICommon/Main/Coordinators/Abstractions/StubCoordinators/StubCoordinator.swift) and [`StubCoordinatorFactory`](https://github.com/migonin/SteamAnalytics/blob/master/UICommon/Main/Coordinators/Abstractions/StubCoordinators/StubCoordinatorFactory.swift).

3 base coordinators: `WindowCoordinator`, `TabCoordinator` и `NavigationCoordinator`, its purposes is obvious.

## Screens flows layer ➡️
Separate frameworks for diffenert flows: `LoginScenes`, `UsersScenes` & `GamesScenes`. Each contains: coordinator, viper modules, modules factory.

## Screen module 📺
Each screen module is enclosed with same approach as coordinator: it has `input` and `output` protocols, and exposes `UIViewController`, so coordinator can intagrate it into views hierarchy. 

VIPER-like pattern is used for every module, however as it is fully enclosed with protocols, it does not matter.

## Main app 📱
Main app is very thin and minimalistic - it combines all layers, sets up and injects all dependencies and starts main coordinator.  

## Graphs 📈
[Charts] pod is used for games stats history, in future I have plans to develop my own charting library.

## Debug 🔧
Main app schema has `xDebugMode` environment variable, when it is enabled  `fake login` button appears on login screen, it emulates login by user with great CS: GO stats :)

## Tests ✅
Unit tests for `Storages`. In-memory data stacks, background transactions awaiting.

## Other features 🎅
- dark mode
- dynamic type

## Future plans 📋
- sourcery for autoinits generation.
- test some DI container.
- enclose `Storage`'s object monitoring.
- test apps for separate coordinators.
- stats from Dota2.

## Pods 🥜

| Pod | Description | URL |
| ------ | ------ | ------ |
| CoreStore | CoreData as it should be | [https://github.com/JohnEstropia/CoreStore][CoreStore] |
| SnapKit | UI layaout | [https://github.com/SnapKit/SnapKit][SnapKit] |
| Kingfisher | Images loading | [https://github.com/onevcat/Kingfisher][Kingfisher] |
| Alamofire | Networking | https://github.com/Alamofire/Alamofire |
| Charts | Graphs | https://github.com/danielgindi/Charts |
| SwiftGen | Codegeneration for images and strings | https://github.com/SwiftGen/SwiftGen |

## My contacts:
Email: mikhail.igonin@gmail.com

Telegram: https://t.me/mikhail_igonin

Twitter: https://twitter.com/frozen_lion/

   [Alamofire]: <https://github.com/Alamofire/Alamofire>
   [CoreStore]: <https://github.com/JohnEstropia/CoreStore>
   [SnapKit]: <https://github.com/SnapKit/SnapKit>
   [Kingfisher]: <https://github.com/onevcat/Kingfisher>
   [Charts]: <https://github.com/danielgindi/Charts>
   [SwiftGen]: <https://github.com/SwiftGen/SwiftGen>
