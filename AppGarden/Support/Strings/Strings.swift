// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  /// Item
  internal static let accessibilityItemName = L10n.tr("Localizable", "ACCESSIBILITY_ITEM_NAME", fallback: "Item")
  /// Of
  internal static let accessibilityItemOf = L10n.tr("Localizable", "ACCESSIBILITY_ITEM_OF", fallback: "Of")
  /// Title
  internal static let accessibilityItemTitleName = L10n.tr("Localizable", "ACCESSIBILITY_ITEM_TITLE_NAME", fallback: "Title")
  /// Details
  internal static let detailsScreenTitle = L10n.tr("Localizable", "DETAILS_SCREEN_TITLE", fallback: "Details")
  /// Localizable.strings
  ///   AppGarden
  /// 
  ///   Created by Luiz Diniz Hammerli on 23/08/23.
  internal static let gridViewTitle = L10n.tr("Localizable", "GRID_VIEW_TITLE", fallback: "App Garden")
  /// Date
  internal static let imageDate = L10n.tr("Localizable", "IMAGE_DATE", fallback: "Date")
  /// Height
  internal static let imageHeight = L10n.tr("Localizable", "IMAGE_HEIGHT", fallback: "Height")
  /// Title
  internal static let imageTitle = L10n.tr("Localizable", "IMAGE_TITLE", fallback: "Title")
  /// Width
  internal static let imageWidth = L10n.tr("Localizable", "IMAGE_WIDTH", fallback: "Width")
  /// Try a new search.
  internal static let searchErrorDescription = L10n.tr("Localizable", "SEARCH_ERROR_DESCRIPTION", fallback: "Try a new search.")
  /// No Results
  internal static let searchErrorTitle = L10n.tr("Localizable", "SEARCH_ERROR_TITLE", fallback: "No Results")
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
