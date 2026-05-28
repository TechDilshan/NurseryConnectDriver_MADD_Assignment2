import SwiftUI

struct PassengerListView: View {
    let passengers: [Passenger]

    var body: some View {
        NavigationStack {
            Group {
                if passengers.isEmpty {
                    EmptyStateView(
                        title: "No Passengers On Board",
                        message: "Passengers will appear here after the route starts.",
                        systemImage: "person.3.sequence.fill"
                    )
                } else {
                    List(passengers) { passenger in
                        HStack(spacing: 14) {
                            Image(systemName: "person.fill")
                                .foregroundStyle(.blue)
                                .frame(width: 40, height: 40)
                                .background(Color.blue.opacity(0.12))
                                .clipShape(Circle())

                            VStack(alignment: .leading, spacing: 4) {
                                Text(passenger.name)
                                    .font(.headline)

                                Text("Age: \(passenger.age)")
                                    .font(.caption)
                                    .foregroundStyle(.secondary)
                            }

                            Spacer()

                            MacStatusPillView(
                                title: "On Board",
                                systemImage: "bus.fill",
                                color: .blue
                            )
                        }
                        .padding(.vertical, 6)
                    }
                }
            }
            .navigationTitle("Passengers On Board")
        }
    }
}
