import SwiftUI
import Orbit

public struct DSButton: View {
    private let label: String
    private let icon: Icon.Content
    private let action: () -> Void

    public init(_ label: String, icon: Icon.Content, action: @escaping () -> Void) {
        self.label = label
        self.icon = icon
        self.action = action
    }

    public var body: some View {
        Button(label, icon: icon, action: action)

    }
}
