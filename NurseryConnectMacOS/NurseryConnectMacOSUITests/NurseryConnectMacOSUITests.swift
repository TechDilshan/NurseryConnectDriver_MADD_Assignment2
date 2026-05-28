import XCTest

final class NurseryConnectMacOSUITests: XCTestCase {

    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    @MainActor
    func testAppLaunchesAndShowsDashboard() throws {
        let app = XCUIApplication()
        app.launch()

        XCTAssertTrue(waitForText("Driver Operations Center", in: app))
    }

    @MainActor
    func testSidebarNavigationToLiveRoute() throws {
        let app = XCUIApplication()
        app.launch()

        tapSidebarItem("Live Route", in: app)

        XCTAssertTrue(waitForText("Live Route Tracking", in: app))
        XCTAssertTrue(waitForText("Start Route", in: app))
        XCTAssertTrue(waitForText("Stop Route", in: app))
    }

    @MainActor
    func testSidebarNavigationToManifest() throws {
        let app = XCUIApplication()
        app.launch()

        tapSidebarItem("Manifest", in: app)

        XCTAssertTrue(waitForText("Today’s Manifest", in: app) || waitForText("Today's Manifest", in: app))
    }

    @MainActor
    func testSidebarNavigationToAnalytics() throws {
        let app = XCUIApplication()
        app.launch()

        tapSidebarItem("Analytics", in: app)

        XCTAssertTrue(waitForText("Transport Analytics", in: app))
        XCTAssertTrue(waitForText("Pickup Status", in: app))
    }

    @MainActor
    func testSidebarNavigationToSettings() throws {
        let app = XCUIApplication()
        app.launch()

        tapSidebarItem("Settings", in: app)

        XCTAssertTrue(waitForText("Settings", in: app))
        XCTAssertTrue(waitForText("Appearance", in: app))
        XCTAssertTrue(waitForText("Security", in: app))
    }

    @MainActor
    func testSettingsHasPickerAndSliderControls() throws {
        let app = XCUIApplication()
        app.launch()

        tapSidebarItem("Settings", in: app)

        XCTAssertTrue(waitForText("Route Preferences", in: app))
        XCTAssertTrue(waitForText("Route Priority", in: app))
        XCTAssertTrue(waitForText("GPS Update Frequency", in: app))

        XCTAssertTrue(
            app.sliders.firstMatch.waitForExistence(timeout: 5),
            "Slider was not found in Settings screen."
        )
    }

    @MainActor
    func testIncidentSectionShowsSecureAccess() throws {
        let app = XCUIApplication()
        app.launch()

        tapSidebarItem("Incidents", in: app)

        XCTAssertTrue(waitForText("Secure Incident Records", in: app))
        XCTAssertTrue(waitForText("Unlock", in: app))
    }

    @MainActor
    func testReportsSectionShowsSecureAccess() throws {
        let app = XCUIApplication()
        app.launch()

        tapSidebarItem("Reports", in: app)

        XCTAssertTrue(waitForText("Secure Daily Reports", in: app))
    }

    @MainActor
    func testNotesSectionShowsSecureAccess() throws {
        let app = XCUIApplication()
        app.launch()

        tapSidebarItem("Driver Notes", in: app)

        XCTAssertTrue(waitForText("Secure Driver Notes", in: app))
    }

    private func tapSidebarItem(_ title: String, in app: XCUIApplication) {
        let button = app.buttons[title]
        if button.waitForExistence(timeout: 3) {
            button.click()
            return
        }

        let text = app.staticTexts[title]
        if text.waitForExistence(timeout: 3) {
            text.click()
            return
        }

        let cell = app.cells.containing(.staticText, identifier: title).firstMatch
        if cell.waitForExistence(timeout: 3) {
            cell.click()
            return
        }

        let outlineRow = app.outlines.cells.containing(.staticText, identifier: title).firstMatch
        if outlineRow.waitForExistence(timeout: 3) {
            outlineRow.click()
            return
        }

        XCTFail("Could not find sidebar item: \(title)")
    }

    private func waitForText(_ text: String, in app: XCUIApplication, timeout: TimeInterval = 5) -> Bool {
        if app.staticTexts[text].waitForExistence(timeout: timeout) {
            return true
        }

        if app.buttons[text].waitForExistence(timeout: 1) {
            return true
        }

        if app.textFields[text].waitForExistence(timeout: 1) {
            return true
        }

        let partialText = app.staticTexts.containing(NSPredicate(format: "label CONTAINS %@", text)).firstMatch
        if partialText.waitForExistence(timeout: 1) {
            return true
        }

        let partialButton = app.buttons.containing(NSPredicate(format: "label CONTAINS %@", text)).firstMatch
        if partialButton.waitForExistence(timeout: 1) {
            return true
        }

        return false
    }
}
