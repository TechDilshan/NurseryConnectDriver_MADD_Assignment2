import SwiftUI

struct AccessibilitySettingsView: View {
    @State private var largeTextMode = false
    @State private var reduceVisualComplexity = false
    @State private var showSafetyLabels = true

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            SectionHeaderView(
                title: "Accessibility",
                subtitle: "Design considerations for a professional childcare environment"
            )

            Toggle("Large Text Friendly Layout", isOn: $largeTextMode)
            Toggle("Reduce Visual Complexity", isOn: $reduceVisualComplexity)
            Toggle("Show Safety Labels", isOn: $showSafetyLabels)

            Text("These settings are included to demonstrate accessibility awareness. A production app would connect these controls to the full UI theme system.")
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .padding()
        .background(Color.appCardBackground)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
