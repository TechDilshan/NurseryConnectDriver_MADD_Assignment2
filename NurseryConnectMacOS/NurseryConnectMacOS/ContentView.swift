//
//  ContentView.swift
//  NurseryConnectMacOS
//
//  Created by chamika dilshan on 2026-05-28.
//

import SwiftUI

struct ContentView: View {

    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel
    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @EnvironmentObject var tripHistoryViewModel: TripHistoryViewModel
    @EnvironmentObject var driverNotesViewModel: DriverNotesViewModel
    @EnvironmentObject var navigationViewModel: MacNavigationViewModel
    @EnvironmentObject var routePreferenceViewModel: RoutePreferenceViewModel

    var body: some View {
        MacRootView()
            .environmentObject(transportViewModel)
            .environmentObject(locationViewModel)
            .environmentObject(incidentViewModel)
            .environmentObject(analyticsViewModel)
            .environmentObject(themeViewModel)
            .environmentObject(tripHistoryViewModel)
            .environmentObject(driverNotesViewModel)
            .environmentObject(navigationViewModel)
            .environmentObject(routePreferenceViewModel)
            .onAppear {
                refreshAnalytics()
            }
    }

    private func refreshAnalytics() {
        analyticsViewModel.refresh(
            children: transportViewModel.children,
            incidents: incidentViewModel.incidents
        )
    }
}

#Preview {
    ContentView()
        .environmentObject(TransportViewModel())
        .environmentObject(LocationViewModel())
        .environmentObject(ThemeViewModel())
        .environmentObject(IncidentViewModel())
        .environmentObject(AnalyticsViewModel())
        .environmentObject(TripHistoryViewModel())
        .environmentObject(DriverNotesViewModel())
        .environmentObject(MacNavigationViewModel())
        .environmentObject(RoutePreferenceViewModel())
}
