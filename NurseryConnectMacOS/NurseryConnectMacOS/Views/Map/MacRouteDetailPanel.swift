import SwiftUI

struct MacRouteDetailPanel: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var transportViewModel: TransportViewModel

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 18) {
                SectionHeaderView(
                    title: "Route Details",
                    subtitle: "Current trip status and map controls"
                )

                RouteInfoCardView(
                    title: locationViewModel.tripStatusText,
                    subtitle: locationViewModel.estimatedArrivalText,
                    systemImage: "location.circle.fill",
                    extraInfo: "Total distance: \(locationViewModel.totalRouteDistanceText)"
                )

                VStack(alignment: .leading, spacing: 12) {
                    Text("Map Background")
                        .font(.headline)

                    Picker("Map Style", selection: $locationViewModel.selectedMapStyle) {
                        ForEach(MapStyleOption.allCases, id: \.self) { style in
                            Text(style.title).tag(style)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding()
                .background(Color.appCardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 18))

                VStack(alignment: .leading, spacing: 12) {
                    Text("Passenger Summary")
                        .font(.headline)

                    MacStatusPillView(
                        title: "Pending \(transportViewModel.pendingCount)",
                        systemImage: "clock.fill",
                        color: .orange
                    )

                    MacStatusPillView(
                        title: "On Board \(transportViewModel.onboardCount)",
                        systemImage: "bus.fill",
                        color: .blue
                    )

                    MacStatusPillView(
                        title: "Dropped \(transportViewModel.droppedOffCount)",
                        systemImage: "checkmark.circle.fill",
                        color: .green
                    )
                }
                .padding()
                .background(Color.appCardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 18))

                VStack(alignment: .leading, spacing: 12) {
                    Text("Route Stops")
                        .font(.headline)

                    ForEach(locationViewModel.routeStops) { stop in
                        VStack(alignment: .leading, spacing: 5) {
                            Text("\(stop.order). \(stop.title)")
                                .font(.subheadline.weight(.semibold))

                            Text(stop.subtitle)
                                .font(.caption)
                                .foregroundStyle(.secondary)

                            Text("Distance from vehicle: \(locationViewModel.distanceFromDriver(to: stop))")
                                .font(.caption)
                                .foregroundStyle(.blue)
                        }
                        .padding(10)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color.appSecondaryBackground)
                        .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                }
                .padding()
                .background(Color.appCardBackground)
                .clipShape(RoundedRectangle(cornerRadius: 18))
            }
        }
    }
}
