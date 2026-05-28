import SwiftUI

struct PickupConfirmationView: View {
    let child: Child

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            SectionHeaderView(
                title: "Pickup Confirmation Log",
                subtitle: "Timestamped transport confirmation for safeguarding"
            )

            confirmationRow(
                title: "Pickup Status",
                value: child.status == .pending ? "Not picked up yet" : child.status.title
            )

            confirmationRow(
                title: "Pickup Time",
                value: DateFormatterHelper.displayDateTime(child.pickupTime)
            )

            confirmationRow(
                title: "Dropoff Time",
                value: DateFormatterHelper.displayDateTime(child.dropoffTime)
            )

            Text("Production note: In a real NurseryConnect system, these records would be stored in an encrypted audit log for Ofsted and safeguarding review.")
                .font(.caption)
                .foregroundStyle(.secondary)
                .padding(.top, 8)
        }
        .padding()
        .background(Color.appSecondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }

    private func confirmationRow(title: String, value: String) -> some View {
        HStack {
            Text(title)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .fontWeight(.semibold)
        }
    }
}
