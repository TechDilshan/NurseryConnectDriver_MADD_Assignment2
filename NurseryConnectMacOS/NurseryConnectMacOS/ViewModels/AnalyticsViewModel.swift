import Foundation
import SwiftUI

@MainActor
final class AnalyticsViewModel: ObservableObject {
    @Published var pickupStatusData: [AnalyticsDataPoint] = []
    @Published var incidentSeverityData: [AnalyticsDataPoint] = []
    @Published var weeklyRoutePerformanceData: [AnalyticsDataPoint] = []
    @Published var driverEfficiencyData: [AnalyticsDataPoint] = []

    private let analyticsService: AnalyticsServiceProtocol

    init(analyticsService: AnalyticsServiceProtocol = AnalyticsService()) {
        self.analyticsService = analyticsService
    }

    func refresh(children: [Child], incidents: [IncidentReport]) {
        pickupStatusData = analyticsService.pickupStatusData(children: children)
        incidentSeverityData = analyticsService.incidentSeverityData(incidents: incidents)
        weeklyRoutePerformanceData = analyticsService.weeklyRoutePerformanceData()
        driverEfficiencyData = analyticsService.driverEfficiencyData()
    }

    var totalPickupItems: Int {
        pickupStatusData.map(\.value).reduce(0, +)
    }

    var totalIncidents: Int {
        incidentSeverityData.map(\.value).reduce(0, +)
    }

    var averageWeeklyPerformance: Int {
        guard !weeklyRoutePerformanceData.isEmpty else { return 0 }
        let total = weeklyRoutePerformanceData.map(\.value).reduce(0, +)
        return total / weeklyRoutePerformanceData.count
    }
}
