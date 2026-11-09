import Foundation
import XCTest
@testable import ClipRelay

final class MenuBarIconStyleTests: XCTestCase {
    private var suiteName: String!
    private var defaults: UserDefaults!

    override func setUp() {
        super.setUp()
        suiteName = "MenuBarIconStyleTests.\(UUID().uuidString)"
        defaults = UserDefaults(suiteName: suiteName)!
    }

    override func tearDown() {
        defaults.removePersistentDomain(forName: suiteName)
        defaults = nil
        suiteName = nil
        super.tearDown()
    }

    func testExistingUsersKeepColoredStyleWithoutAStoredPreference() {
        XCTAssertEqual(MenuBarIconStyle.load(from: defaults), .colored)
        XCTAssertNil(defaults.object(forKey: MenuBarIconStyle.defaultsKey))
    }

    func testUnknownOrMalformedPreferenceFallsBackToColoredStyle() {
        defaults.set("unsupported-style", forKey: MenuBarIconStyle.defaultsKey)
        XCTAssertEqual(MenuBarIconStyle.load(from: defaults), .colored)

        defaults.set(["monochrome"], forKey: MenuBarIconStyle.defaultsKey)
        XCTAssertEqual(MenuBarIconStyle.load(from: defaults), .colored)
    }

    func testStyleSelectionPersistsAndCanBeChangedBackToDefault() {
        for style in [MenuBarIconStyle.monochrome, .connectionBadge, .colored] {
            style.save(to: defaults)
            let reloadedDefaults = UserDefaults(suiteName: suiteName)!
            XCTAssertEqual(MenuBarIconStyle.load(from: reloadedDefaults), style)
        }
    }
}
