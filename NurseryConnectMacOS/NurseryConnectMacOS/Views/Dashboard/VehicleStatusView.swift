import SwiftUI

struct VehicleStatusView: View {
    @EnvironmentObject var transportViewModel: TransportViewModel
    @EnvironmentObject var locationViewModel: LocationViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 18) {
            SectionHeaderView(
                title: "Vehicle Status",
                subtitle: "Route and vehicle monitoring"
            )

            InfoCardView(
                title: "Vehicle Number",
                value: transportViewModel.trip.vehicleNumber,
                systemImage: "car.fill"
            )

            InfoCardView(
                title: "Current Route State",
                value: locationViewModel.tripStatusText,
                systemImage: "location.fill"
            )

            InfoCardView(
                title: "Estimated Arrival",
                value: locationViewModel.estimatedArrivalText,
                systemImage: "timer"
            )

            InfoCardView(
                title: "Total Distance",
                value: locationViewModel.totalRouteDistanceText,
                systemImage: "ruler.fill"
            )
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
