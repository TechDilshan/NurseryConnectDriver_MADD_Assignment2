import SwiftUI
import Charts

struct IncidentChartView: View {

    @EnvironmentObject var analyticsViewModel: AnalyticsViewModel

    var body: some View {

        VStack(alignment: .leading, spacing: 16) {

            SectionHeaderView(
                title: "Incident Severity",
                subtitle: "Distribution of low, medium, and high severity incidents"
            )

            Chart(analyticsViewModel.incidentSeverityData) { item in

                SectorMark(
                    angle: .value("Count", item.value),
                    innerRadius: .ratio(0.58)
                )
                .foregroundStyle(by: .value("Severity", item.title))
                .annotation(position: .overlay) {

                    if item.value > 0 {

                        Text("\(item.value)")
                            .font(.caption.bold())
                    }
                }
            }
            .frame(height: 240)

            VStack(alignment: .leading, spacing: 8) {

                legendRow(
                    title: "Low Severity",
                    color: .yellow
                )

                legendRow(
                    title: "Medium Severity",
                    color: .orange
                )

                legendRow(
                    title: "High Severity",
                    color: .red
                )
            }
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }

    private func legendRow(
        title: String,
        color: Color
    ) -> some View {

        HStack(spacing: 10) {

            Circle()
                .fill(color)
                .frame(width: 12, height: 12)

            Text(title)
                .font(.caption)

            Spacer()
        }
    }
}
