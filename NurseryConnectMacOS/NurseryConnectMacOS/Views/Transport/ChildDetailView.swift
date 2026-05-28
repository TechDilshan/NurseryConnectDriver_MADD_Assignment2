import SwiftUI

struct ChildDetailView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel
    let childID: String

    var child: Child? {
        transportViewModel.child(withID: childID)
    }

    var body: some View {
        Group {
            if let child {
                ScrollView {
                    VStack(alignment: .leading, spacing: 20) {
                        childHeader(child)
                        transportInfo(child)
                        actionButtons(child)
                    }
                    .padding()
                }
                .background(Color.appGroupedBackground)
                .navigationTitle("Child Details")
            } else {
                EmptyStateView(
                    title: "Child Not Found",
                    message: "The selected child record could not be found.",
                    systemImage: "exclamationmark.triangle.fill"
                )
            }
        }
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

    private func childHeader(_ child: Child) -> some View {
        VStack(spacing: 12) {
            Circle()
                .fill(Color.blue.opacity(0.15))
                .frame(width: 90, height: 90)
                .overlay {
                    Text(child.initials)
                        .font(.title.bold())
                        .foregroundStyle(.blue)
                }

            Text(child.name)
                .font(.title2.bold())

            StatusBadgeView(status: child.status)
        }
        .frame(maxWidth: .infinity)
    }

    private func transportInfo(_ child: Child) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Transport Information")
                .font(.headline)

            detailCard(title: "School", value: child.schoolName)
            detailCard(title: "Pickup Point", value: child.pickupLocation)
            detailCard(title: "Dropoff Point", value: child.dropoffLocation)
            detailCard(title: "Pickup Time", value: DateFormatterHelper.displayTimeOnly(child.pickupTime))
            detailCard(title: "Dropoff Time", value: DateFormatterHelper.displayTimeOnly(child.dropoffTime))
            detailCard(title: "Guardian", value: child.guardianName)
            detailCard(title: "Contact", value: child.guardianContact)
        }
    }

    private func actionButtons(_ child: Child) -> some View {
        VStack(spacing: 12) {
            Button {
                transportViewModel.markPickedUp(child: child)
            } label: {
                PrimaryButton(title: "Mark as On Board", systemImage: "arrow.up.circle.fill")
            }
            .disabled(child.status != .pending)

            Button {
                transportViewModel.markDroppedOff(child: child)
            } label: {
                PrimaryButton(title: "Mark as Dropped Off", systemImage: "arrow.down.circle.fill", color: .green)
            }
            .disabled(child.status != .pickedUp)
        }
    }

    private func detailCard(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
