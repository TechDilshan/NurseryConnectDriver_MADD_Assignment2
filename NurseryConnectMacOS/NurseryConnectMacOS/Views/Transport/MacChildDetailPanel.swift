import SwiftUI

struct MacChildDetailPanel: View {
    @EnvironmentObject var transportViewModel: TransportViewModel

    let child: Child

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 22) {
                HStack(spacing: 18) {
                    Circle()
                        .fill(Color.blue.opacity(0.15))
                        .frame(width: 80, height: 80)
                        .overlay {
                            Text(child.initials)
                                .font(.title.bold())
                                .foregroundStyle(.blue)
                        }

                    VStack(alignment: .leading, spacing: 8) {
                        Text(child.name)
                            .font(.largeTitle.bold())

                        Text("\(child.age) years old")
                            .foregroundStyle(.secondary)

                        StatusBadgeView(status: child.status)
                    }

                    Spacer()
                }

                VStack(alignment: .leading, spacing: 14) {
                    SectionHeaderView(
                        title: "Transport Information",
                        subtitle: "Pickup, drop-off, and guardian details"
                    )

                    infoRow("School", child.schoolName)
                    infoRow("Pickup Point", child.pickupLocation)
                    infoRow("Dropoff Point", child.dropoffLocation)
                    infoRow("Pickup Time", DateFormatterHelper.displayTimeOnly(child.pickupTime))
                    infoRow("Dropoff Time", DateFormatterHelper.displayTimeOnly(child.dropoffTime))
                    infoRow("Guardian", child.guardianName)
                    infoRow("Emergency Contact", child.guardianContact)
                }

                HStack(spacing: 14) {
                    Button {
                        transportViewModel.markPickedUp(child: child)
                    } label: {
                        PrimaryButton(title: "Mark On Board", systemImage: "bus.fill", color: .blue)
                    }
                    .disabled(child.status != .pending)

                    Button {
                        transportViewModel.markDroppedOff(child: child)
                    } label: {
                        PrimaryButton(title: "Mark Dropped Off", systemImage: "checkmark.circle.fill", color: .green)
                    }
                    .disabled(child.status != .pickedUp)
                }

                PickupConfirmationView(child: child)
            }
            .padding(28)
        }
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .alert("Success", isPresented: Binding(
            get: { transportViewModel.successMessage != nil },
            set: { if !$0 { transportViewModel.clearMessages() } }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(transportViewModel.successMessage ?? "")
        }
        .alert("Notice", isPresented: Binding(
            get: { transportViewModel.errorMessage != nil },
            set: { if !$0 { transportViewModel.clearMessages() } }
        )) {
            Button("OK", role: .cancel) {}
        } message: {
            Text(transportViewModel.errorMessage ?? "")
        }
    }

    private func infoRow(_ title: String, _ value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
        }
        .padding()
        .background(Color.appSecondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
