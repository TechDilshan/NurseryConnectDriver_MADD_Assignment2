import Foundation
import SwiftUI

@MainActor
final class RoutePreferenceViewModel: ObservableObject {
    @Published var selectedPriority: RoutePriority
    @Published var updateFrequency: Double

    private let service: RoutePreferenceServiceProtocol

    init(service: RoutePreferenceServiceProtocol = RoutePreferenceService()) {
        self.service = service
        self.selectedPriority = service.loadRoutePriority()
        self.updateFrequency = service.loadUpdateFrequency()
    }

    func updatePriority(_ priority: RoutePriority) {
        selectedPriority = priority
        service.saveRoutePriority(priority)
    }

    func updateFrequencyValue(_ value: Double) {
        updateFrequency = value
        service.saveUpdateFrequency(value)
    }

    var updateFrequencyText: String {
        "\(Int(updateFrequency)) seconds"
    }
}
