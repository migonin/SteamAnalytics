// swiftlint:disable all
// Generated using SwiftGen, by O.Halligon — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name
public enum L10n {

  public enum Achievements {
    /// Ачивки
    public static let title = L10n.tr("Localizable", "Achievements.title")
  }

  public enum Common {
    /// Назад
    public static let back = L10n.tr("Localizable", "Common.back")
    /// ОК
    public static let ok = L10n.tr("Localizable", "Common.ok")
    /// Повторить
    public static let retry = L10n.tr("Localizable", "Common.retry")
  }

  public enum Error {
    /// Что-то пошло не так.
    public static let general = L10n.tr("Localizable", "Error.general")
    /// Проблемы с инернетом.
    public static let internet = L10n.tr("Localizable", "Error.internet")
  }

  public enum Game {
    /// Ачивки
    public static let achievements = L10n.tr("Localizable", "Game.achievements")
    /// Новости
    public static let news = L10n.tr("Localizable", "Game.news")
    /// У игры нет доступных стат. Посмотрите другие игры, например, CS: GO, Team Fortress 2, Portal 2, по ним есть много всего.
    public static let noStats = L10n.tr("Localizable", "Game.noStats")
    /// Статистика
    public static let stats = L10n.tr("Localizable", "Game.stats")
    public enum Time {
      /// %d ч %d мин
      public static func hmformat(_ p1: Int, _ p2: Int) -> String {
        return L10n.tr("Localizable", "Game.time.hmformat", p1, p2)
      }
      /// %d мин
      public static func mformat(_ p1: Int) -> String {
        return L10n.tr("Localizable", "Game.time.mformat", p1)
      }
      /// Всего %@
      public static func total(_ p1: String) -> String {
        return L10n.tr("Localizable", "Game.time.total", p1)
      }
      /// За 2 недели %@
      public static func twoWeeks(_ p1: String) -> String {
        return L10n.tr("Localizable", "Game.time.twoWeeks", p1)
      }
    }
  }

  public enum GameNews {
    /// Пожалуйста, подождите. Обрабатываются HTML и BB-коды...
    public static let loading = L10n.tr("Localizable", "GameNews.loading")
    /// Новости игры
    public static let title = L10n.tr("Localizable", "GameNews.title")
  }

  public enum GameStats {
    /// Статистика игры
    public static let title = L10n.tr("Localizable", "GameStats.title")
  }

  public enum Login {
    /// Фейковый вход
    public static let fakeLogin = L10n.tr("Localizable", "Login.fakeLogin")
    /// Вход
    public static let title = L10n.tr("Localizable", "Login.title")
  }

  public enum TabBar {
    /// Последние игры
    public static let games = L10n.tr("Localizable", "TabBar.games")
    /// Юзер
    public static let user = L10n.tr("Localizable", "TabBar.user")
  }

  public enum User {
    /// Друзья
    public static let friends = L10n.tr("Localizable", "User.friends")
    /// Игры
    public static let games = L10n.tr("Localizable", "User.games")
    /// Выйти
    public static let logout = L10n.tr("Localizable", "User.logout")
    /// Старт
    public static let mainScreen = L10n.tr("Localizable", "User.mainScreen")
    /// Закрытый профиль
    public static let `private` = L10n.tr("Localizable", "User.private")
    /// Юзер
    public static let user = L10n.tr("Localizable", "User.user")
    public enum LogoutPopup {
      /// Отмена
      public static let cancel = L10n.tr("Localizable", "User.logoutPopup.cancel")
      /// Выйти
      public static let confirm = L10n.tr("Localizable", "User.logoutPopup.confirm")
      /// Вы точно хотите выйти?
      public static let text = L10n.tr("Localizable", "User.logoutPopup.text")
    }
  }

  public enum UserFriends {
    /// У пользователя нет друзей
    public static let noFriends = L10n.tr("Localizable", "UserFriends.noFriends")
    /// Друзья пользователя недоступны
    public static let `private` = L10n.tr("Localizable", "UserFriends.private")
    /// Друзья %@
    public static func title(_ p1: String) -> String {
      return L10n.tr("Localizable", "UserFriends.title", p1)
    }
  }

  public enum UserGames {
    /// У пользователя нет игр
    public static let noGames = L10n.tr("Localizable", "UserGames.noGames")
    /// Игры пользователя недоступны
    public static let `private` = L10n.tr("Localizable", "UserGames.private")
    /// Игры %@
    public static func title(_ p1: String) -> String {
      return L10n.tr("Localizable", "UserGames.title", p1)
    }
    public enum LastGames {
      /// Последние игры %@
      public static func title(_ p1: String) -> String {
        return L10n.tr("Localizable", "UserGames.lastGames.title", p1)
      }
    }
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String) -> String {
    return NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
  }

  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
