import SwiftUI

struct PrimaryButton: View {
    let title: String
    let systemImage: String
    var color: Color = .blue

    var body: some View {
        Label(title, systemImage: systemImage)
            .font(.headline)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .background(color)
            .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}
