import SwiftUI

struct RoutePreferenceSettingsView: View {
    @EnvironmentObject var routePreferenceViewModel: RoutePreferenceViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            SectionHeaderView(
                title: "Route Preferences",
                subtitle: "Adjust route behaviour and simulated location update settings"
            )

            VStack(alignment: .leading, spacing: 10) {
                Text("Route Priority")
                    .font(.headline)

                Picker("Route Priority", selection: $routePreferenceViewModel.selectedPriority) {
                    ForEach(RoutePriority.allCases, id: \.self) { priority in
                        Text(priority.title).tag(priority)
                    }
                }
                .pickerStyle(.segmented)
                .onChange(of: routePreferenceViewModel.selectedPriority) {
                    routePreferenceViewModel.updatePriority(routePreferenceViewModel.selectedPriority)
                }

                Text(routePreferenceViewModel.selectedPriority.description)
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Divider()

            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    Text("GPS Update Frequency")
                        .font(.headline)

                    Spacer()

                    Text(routePreferenceViewModel.updateFrequencyText)
                        .font(.headline)
                        .foregroundStyle(.blue)
                }

                Slider(
                    value: $routePreferenceViewModel.updateFrequency,
                    in: 5...30,
                    step: 5
                )
                .onChange(of: routePreferenceViewModel.updateFrequency) {
                    routePreferenceViewModel.updateFrequencyValue(routePreferenceViewModel.updateFrequency)
                }

                HStack {
                    Text("5 sec")
                    Spacer()
                    Text("30 sec")
                }
                .font(.caption)
                .foregroundStyle(.secondary)

                Text("This slider demonstrates user-controlled route update behaviour. In a real system, this could control how frequently vehicle location updates are sent during an active transport run.")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
