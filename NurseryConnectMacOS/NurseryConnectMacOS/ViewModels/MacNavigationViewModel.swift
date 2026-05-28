import Foundation
import SwiftUI

@MainActor
final class MacNavigationViewModel: ObservableObject {
    @Published var selectedSidebarItem: SidebarSelection? = .dashboard
    @Published var showingIncidentForm: Bool = false
    @Published var showingExportReport: Bool = false
    @Published var showingSettings: Bool = false

    func select(_ item: SidebarSelection) {
        withAnimation(.easeInOut) {
            selectedSidebarItem = item
        }
    }

    func openIncidentForm() {
        showingIncidentForm = true
    }

    func openExportReport() {
        showingExportReport = true
    }

    func openSettings() {
        showingSettings = true
    }

    func closeSheets() {
        showingIncidentForm = false
        showingExportReport = false
        showingSettings = false
    }
}
