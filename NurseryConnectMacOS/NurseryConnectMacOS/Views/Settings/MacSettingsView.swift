import SwiftUI

struct MacSettingsView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var themeViewModel: ThemeViewModel
    @EnvironmentObject var incidentViewModel: IncidentViewModel
    @EnvironmentObject var tripHistoryViewModel: TripHistoryViewModel

    @State private var showResetTripConfirmation = false
    @State private var showClearIncidentsConfirmation = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                header
                appearanceSection
                securitySection
                AccessibilitySettingsView()
                tripControlsSection
                dataSummarySection
            }
            .padding(28)
        }
        .confirmationDialog("Reset trip data?", isPresented: $showResetTripConfirmation) {
            Button("Reset", role: .destructive) {
                transportViewModel.resetTrip()
                locationViewModel.resetSimulation()
            }

            Button("Cancel", role: .cancel) { }
        }
        .confirmationDialog("Clear incidents?", isPresented: $showClearIncidentsConfirmation) {
            Button("Clear", role: .destructive) {
                incidentViewModel.incidents.removeAll()
            }

            Button("Cancel", role: .cancel) { }
        }
    }

    private var header: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Settings")
                .font(.largeTitle.bold())

            Text("Manage appearance, local demo data, security, and route simulation settings.")
                .foregroundStyle(.secondary)
        }
    }

    private var appearanceSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Appearance",
                subtitle: "Choose how the macOS app should display"
            )

            Picker("Theme", selection: $themeViewModel.selectedTheme) {
                ForEach(AppTheme.allCases, id: \.self) { theme in
                    Text(theme.displayName).tag(theme)
                }
            }
            .pickerStyle(.segmented)
            .onChange(of: themeViewModel.selectedTheme) {
                themeViewModel.updateTheme(themeViewModel.selectedTheme)
            }
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var securitySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Security",
                subtitle: "LocalAuthentication protects sensitive transport records"
            )

            InfoCardView(
                title: "Security Framework",
                value: "LocalAuthentication enabled",
                systemImage: "lock.shield.fill"
            )

            InfoCardView(
                title: "Protected Sections",
                value: "Incidents, Reports, Driver Notes",
                systemImage: "eye.slash.fill"
            )

            Text("This is not a login feature. The app still opens directly into the dashboard. Touch ID or device password is only used when opening sensitive child transport records.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var tripControlsSection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Trip Controls",
                subtitle: "Reset demo data and route simulation"
            )

            HStack(spacing: 14) {
                Button {
                    showResetTripConfirmation = true
                } label: {
                    PrimaryButton(
                        title: "Reset Trip Data",
                        systemImage: "arrow.clockwise",
                        color: .red
                    )
                }

                Button {
                    locationViewModel.resetSimulation()
                } label: {
                    PrimaryButton(
                        title: "Reset Route Simulation",
                        systemImage: "map.fill",
                        color: .orange
                    )
                }

                Button {
                    showClearIncidentsConfirmation = true
                } label: {
                    PrimaryButton(
                        title: "Clear Incidents",
                        systemImage: "trash.fill",
                        color: .gray
                    )
                }
            }
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private var dataSummarySection: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Data Summary",
                subtitle: "Current local demo data stored in this MVP"
            )

            InfoCardView(
                title: "Children",
                value: "\(transportViewModel.children.count)",
                systemImage: "person.3.fill"
            )

            InfoCardView(
                title: "Incidents",
                value: "\(incidentViewModel.incidents.count)",
                systemImage: "exclamationmark.triangle.fill"
            )

            InfoCardView(
                title: "Trip History",
                value: "\(tripHistoryViewModel.records.count)",
                systemImage: "archivebox.fill"
            )

            InfoCardView(
                title: "Advanced Frameworks",
                value: "Swift Charts + LocalAuthentication",
                systemImage: "sparkles"
            )
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
