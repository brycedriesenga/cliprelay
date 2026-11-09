import Foundation

enum MenuBarIconStyle: String, CaseIterable {
    case colored
    case monochrome
    case connectionBadge

    static let defaultsKey = "menuBarIconStyle"

    var title: String {
        switch self {
        case .colored: return "Colored (Default)"
        case .monochrome: return "Monochrome"
        case .connectionBadge: return "Monochrome with Connection Dot"
        }
    }

    static func load(from defaults: UserDefaults = .standard) -> MenuBarIconStyle {
        guard let value = defaults.string(forKey: defaultsKey),
              let style = MenuBarIconStyle(rawValue: value) else {
            return .colored
        }
        return style
    }

    func save(to defaults: UserDefaults = .standard) {
        defaults.set(rawValue, forKey: Self.defaultsKey)
    }
}
