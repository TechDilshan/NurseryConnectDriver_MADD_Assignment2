import SwiftUI
import MapKit

struct DriverMapView: View {
    @EnvironmentObject var locationViewModel: LocationViewModel
    var isFullScreen: Bool = false

    @State private var showPassengers = false

    var body: some View {
        Map(position: .constant(.region(locationViewModel.currentRegion))) {
            Annotation("Vehicle", coordinate: locationViewModel.currentLocation.coordinate) {
                Button {
                    showPassengers = true
                } label: {
                    VStack(spacing: 4) {
                        Image(systemName: "car.side.fill")
                            .font(.system(size: isFullScreen ? 32 : 24, weight: .bold))
                            .foregroundStyle(.white)
                            .padding(10)
                            .background(Color.blue)
                            .clipShape(Circle())
                            .shadow(radius: 4)

                        Text("Vehicle")
                            .font(.caption2.weight(.semibold))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.thinMaterial)
                            .clipShape(Capsule())
                    }
                }
                .buttonStyle(.plain)
            }

            ForEach(locationViewModel.routeStops) { stop in
                Annotation(stop.title, coordinate: stop.coordinate) {
                    VStack(spacing: 4) {
                        Image(systemName: "mappin.circle.fill")
                            .font(.title2)
                            .foregroundStyle(.red)

                        Text(stop.title)
                            .font(.caption2.weight(.medium))
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(.regularMaterial)
                            .clipShape(Capsule())
                    }
                }
            }
        }
        .mapStyle(mapStyle)
        .frame(height: isFullScreen ? nil : 420)
        .clipShape(RoundedRectangle(cornerRadius: isFullScreen ? 0 : 22))
        .overlay {
            if !isFullScreen {
                RoundedRectangle(cornerRadius: 22)
                    .stroke(Color.blue.opacity(0.15), lineWidth: 1)
            }
        }
        .sheet(isPresented: $showPassengers) {
            PassengerListView(passengers: locationViewModel.currentLocation.passengers)
                .frame(minWidth: 420, minHeight: 400)
        }
    }

    private var mapStyle: MapStyle {
        switch locationViewModel.selectedMapStyle {
        case .standard:
            return .standard
        case .hybrid:
            return .hybrid
        case .imagery:
            return .imagery
        }
    }
}
