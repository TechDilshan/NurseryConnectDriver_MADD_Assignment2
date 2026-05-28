import SwiftUI

struct MacToolbarView: ToolbarContent {
    @EnvironmentObject var navigationViewModel: MacNavigationViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var tripHistoryViewModel: TripHistoryViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel

    var body: some ToolbarContent {
        ToolbarItemGroup(placement: .primaryAction) {
            Button {
                locationViewModel.startSimulation()
                transportViewModel.startTripIfNeeded()
            } label: {
                Label("Start Route", systemImage: "play.fill")
            }

            Button {
                locationViewModel.stopSimulation()
            } label: {
                Label("Stop", systemImage: "pause.fill")
            }

            Button {
                navigationViewModel.openIncidentForm()
            } label: {
                Label("New Incident", systemImage: "exclamationmark.bubble.fill")
            }

            Button {
                tripHistoryViewModel.addRecord(
                    from: transportViewModel.trip,
                    incidentCount: incidentViewModel.incidents.count
                )
            } label: {
                Label("Save History", systemImage: "archivebox.fill")
            }

            Button {
                navigationViewModel.openExportReport()
            } label: {
                Label("Export Report", systemImage: "square.and.arrow.down.fill")
            }
        }
    }
}
