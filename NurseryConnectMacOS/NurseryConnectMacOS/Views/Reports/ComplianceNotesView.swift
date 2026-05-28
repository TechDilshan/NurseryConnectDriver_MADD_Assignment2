import SwiftUI

struct ComplianceNotesView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            SectionHeaderView(
                title: "Regulatory Compliance Notes",
                subtitle: "How this macOS MVP reflects NurseryConnect childcare requirements"
            )

            complianceCard(
                title: "UK GDPR",
                text: "The app uses data minimisation by showing only transport-related child information needed by the driver. A production system would require encryption, audit logging, retention policies, consent management, and role-based access control."
            )

            complianceCard(
                title: "EYFS 2024",
                text: "The transport workflow supports child supervision by showing pickup status, passengers on board, route state, and incident records."
            )

            complianceCard(
                title: "Ofsted",
                text: "Trip reports and incident logs support operational accountability. In production, these records would be exportable as inspection-ready audit evidence."
            )

            complianceCard(
                title: "Children Act 1989",
                text: "The design prioritises safeguarding by recording safety incidents, route delays, and pickup confirmation logs."
            )

            complianceCard(
                title: "FSA Guidelines",
                text: "Food safety requirements are not directly implemented because this version focuses on the Driver role and transport safety."
            )
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func complianceCard(title: String, text: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.headline)

            Text(text)
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.appSecondaryBackground)
        .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}
