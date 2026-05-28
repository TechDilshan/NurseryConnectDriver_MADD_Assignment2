import SwiftUI

struct MacRootView: View {
    @EnvironmentObject var navigationViewModel: MacNavigationViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel
    @EnvironmentObject var themeViewModel: ThemeViewModel

    var body: some View {
        NavigationSplitView {
            MacSidebarView()
        } detail: {
            selectedDetailView
                .frame(minWidth: 900, minHeight: 650)
                .background(Color.appGroupedBackground)
        }
        .navigationTitle(AppConstants.displayName)
        .toolbar {
            MacToolbarView()
        }
        .sheet(isPresented: $navigationViewModel.showingIncidentForm) {
            IncidentFormView()
                .environmentObject(incidentViewModel)
                .frame(minWidth: 520, minHeight: 600)
        }
        .sheet(isPresented: $navigationViewModel.showingExportReport) {
            ExportReportView()
                .environmentObject(transportViewModel)
                .environmentObject(incidentViewModel)
                .frame(minWidth: 560, minHeight: 500)
        }
        .onAppear {
            analyticsViewModel.refresh(
                children: transportViewModel.children,
                incidents: incidentViewModel.incidents
            )
        }
    }

    @ViewBuilder
    private var selectedDetailView: some View {
        switch navigationViewModel.selectedSidebarItem ?? .dashboard {
        case .dashboard:
            MacDashboardView()

        case .liveRoute:
            MacLiveRouteView()

        case .manifest:
            MacManifestView()

        case .incidents:
            SecureAccessView(
                title: "Secure Incident Records",
                subtitle: "Incident reports contain safeguarding information. Please unlock to continue.",
                systemImage: "exclamationmark.shield.fill"
            ) {
                IncidentListView()
            }

        case .analytics:
            AnalyticsDashboardView()

        case .reports:
            SecureAccessView(
                title: "Secure Daily Reports",
                subtitle: "Daily transport reports contain child journey records and incident summaries.",
                systemImage: "doc.text.fill"
            ) {
                DailyReportView()
            }

        case .notes:
            SecureAccessView(
                title: "Secure Driver Notes",
                subtitle: "Driver notes may include operational observations about children and route safety.",
                systemImage: "note.text"
            ) {
                DriverNotesListView()
            }

        case .settings:
            MacSettingsView()
        }
    }
}
