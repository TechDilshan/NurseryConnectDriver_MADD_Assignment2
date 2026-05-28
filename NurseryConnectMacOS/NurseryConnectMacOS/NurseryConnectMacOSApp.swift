//
//  NurseryConnectMacOSApp.swift
//  NurseryConnectMacOS
//
//  Created by chamika dilshan on 2026-05-28.
//
//

import SwiftUI

@main
struct NurseryConnectMacOSApp: App {

    @StateObject private var transportViewModel = TransportViewModel()
    @StateObject private var locationViewModel = LocationViewModel()
    @StateObject private var themeViewModel = ThemeViewModel()
    @StateObject private var incidentViewModel = IncidentViewModel()
    @StateObject private var analyticsViewModel = AnalyticsViewModel()
    @StateObject private var tripHistoryViewModel = TripHistoryViewModel()
    @StateObject private var driverNotesViewModel = DriverNotesViewModel()
    @StateObject private var navigationViewModel = MacNavigationViewModel()
    @StateObject private var routePreferenceViewModel = RoutePreferenceViewModel()

    var body: some Scene {

        WindowGroup("NurseryConnect Driver") {
            ContentView()
                .environmentObject(transportViewModel)
                .environmentObject(locationViewModel)
                .environmentObject(themeViewModel)
                .environmentObject(incidentViewModel)
                .environmentObject(analyticsViewModel)
                .environmentObject(tripHistoryViewModel)
                .environmentObject(driverNotesViewModel)
                .environmentObject(navigationViewModel)
                .environmentObject(routePreferenceViewModel)
                .preferredColorScheme(themeViewModel.colorScheme)
                .frame(minWidth: 1280, minHeight: 820)
        }
        .windowStyle(.automatic)

        WindowGroup("Live Route Monitor") {
            MacLiveRouteView()
                .environmentObject(locationViewModel)
                .environmentObject(transportViewModel)
                .frame(minWidth: 1000, minHeight: 700)
        }
        .windowResizability(.contentSize)

        Settings {
            MacSettingsView()
                .environmentObject(transportViewModel)
                .environmentObject(locationViewModel)
                .environmentObject(themeViewModel)
                .environmentObject(incidentViewModel)
                .environmentObject(tripHistoryViewModel)
                .environmentObject(routePreferenceViewModel)
                .frame(width: 700, height: 620)
        }

        MenuBarExtra("NurseryConnect", systemImage: "car.fill") {
            VStack(alignment: .leading, spacing: 14) {

                Text("NurseryConnect")
                    .font(.headline)

                Divider()

                Label(
                    "\(transportViewModel.onboardCount) Children On Board",
                    systemImage: "bus.fill"
                )

                Label(
                    "\(incidentViewModel.unresolvedIncidents.count) Open Incidents",
                    systemImage: "exclamationmark.triangle.fill"
                )

                Divider()

                Button("Start Route Simulation") {
                    locationViewModel.startSimulation()
                    transportViewModel.startTripIfNeeded()
                }

                Button("Stop Route Simulation") {
                    locationViewModel.stopSimulation()
                }

                Divider()

                Button("Quit Application") {
                    NSApplication.shared.terminate(nil)
                }
            }
            .padding()
            .frame(width: 260)
        }
    }
}
