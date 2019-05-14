// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command
// swiftlint:disable file_length

// MARK: - Strings

// swiftlint:disable function_parameter_count identifier_name line_length type_body_length
internal enum L10n {
  /// Character
  internal static let character = L10n.tr("Localizable", "Character")
  /// CRITICAL ARTS
  internal static let criticalArts = L10n.tr("Localizable", "CriticalArts")
  /// -
  internal static let empty = L10n.tr("Localizable", "Empty")
  /// Active
  internal static let moveActive = L10n.tr("Localizable", "MoveActive")
  /// Comments
  internal static let moveComments = L10n.tr("Localizable", "MoveComments")
  /// Move
  internal static let moveName = L10n.tr("Localizable", "MoveName")
  /// Recovery
  internal static let moveRecovery = L10n.tr("Localizable", "MoveRecovery")
  /// Block
  internal static let moveRecoveryOnBlock = L10n.tr("Localizable", "MoveRecoveryOnBlock")
  /// Hit
  internal static let moveRecoveryOnHit = L10n.tr("Localizable", "MoveRecoveryOnHit")
  /// Start\nUp
  internal static let moveStartUp = L10n.tr("Localizable", "MoveStartUp")
  /// VTC\nBlock
  internal static let moveVTriggerCancelRecoveryOnBlock = L10n.tr("Localizable", "MoveVTriggerCancelRecoveryOnBlock")
  /// VTC\nHit
  internal static let moveVTriggerCancelRecoveryOnHit = L10n.tr("Localizable", "MoveVTriggerCancelRecoveryOnHit")
  /// NORMAL MOVES
  internal static let normalMoves = L10n.tr("Localizable", "NormalMoves")
  /// THROWS
  internal static let normalThrows = L10n.tr("Localizable", "NormalThrows")
  /// ▼
  internal static let selection = L10n.tr("Localizable", "Selection")
  /// SPECIAL MOVES
  internal static let specialMoves = L10n.tr("Localizable", "SpecialMoves")
  /// UNIQUE ATTACKS
  internal static let uniqueAttacks = L10n.tr("Localizable", "UniqueAttacks")
  /// V-SYSTEM
  internal static let vSystem = L10n.tr("Localizable", "VSystem")
}
// swiftlint:enable function_parameter_count identifier_name line_length type_body_length

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg...) -> String {
    // swiftlint:disable:next nslocalizedstring_key
    let format = NSLocalizedString(key, tableName: table, bundle: Bundle(for: BundleToken.self), comment: "")
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

private final class BundleToken {}
