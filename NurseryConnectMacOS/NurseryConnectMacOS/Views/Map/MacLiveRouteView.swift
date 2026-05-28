import SwiftUI

struct MacLiveRouteView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel

    @State private var showDistanceSheet = false

    var body: some View {
        HStack(spacing: 22) {
            VStack(alignment: .leading, spacing: 18) {
                header

                DriverMapView()
                    .environmentObject(locationViewModel)

                HStack(spacing: 12) {
                    Button {
                        locationViewModel.startSimulation()
                        transportViewModel.startTripIfNeeded()
                    } label: {
                        PrimaryButton(title: "Start Route", systemImage: "play.fill", color: .blue)
                    }

                    Button {
                        locationViewModel.stopSimulation()
                    } label: {
                        PrimaryButton(title: "Stop Route", systemImage: "pause.fill", color: .orange)
                    }

                    Button {
                        locationViewModel.resetSimulation()
                    } label: {
                        PrimaryButton(title: "Reset", systemImage: "arrow.clockwise", color: .gray)
                    }
                }

                RouteDistanceBreakdownView()
            }
            .frame(maxWidth: .infinity)

            MacRouteDetailPanel()
                .frame(width: 350)
        }
        .padding(28)
        .sheet(isPresented: $showDistanceSheet) {
            RouteDistanceBreakdownView()
                .frame(minWidth: 520, minHeight: 420)
                .padding()
        }
    }

    private var header: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Live Route Tracking")
                    .font(.largeTitle.bold())

                Text("Monitor the active nursery transport route, current vehicle position, ETA, and route stops.")
                    .font(.body)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            MacStatusPillView(
                title: locationViewModel.isSimulationRunning ? "Route Active" : "Route Idle",
                systemImage: locationViewModel.isSimulationRunning ? "location.fill" : "pause.circle.fill",
                color: locationViewModel.isSimulationRunning ? .green : .orange
            )
        }
    }
}
