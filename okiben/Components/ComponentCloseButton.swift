import SwiftUI

struct ComponentCloseButton: View {
    var onPressed: () -> Void
    var customIconSize: CGFloat = 38  // アイコンサイズ (デフォルトは27)
    var isLightMode: Bool

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: onPressed) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: customIconSize, height: customIconSize)
                .foregroundColor(
                    (isLightMode)
                        ? Color(red: 224/255, green: 224/255, blue: 224/255)
                        : Color(red: 100/255, green: 100/255, blue: 100/255)
                )
                .background(
                    Circle()
                        .fill(
                            (isLightMode)
                                ? Color(red: 21/255, green: 21/255, blue: 21/255)
                                : Color(red: 240/255, green: 240/255, blue: 240/255)
                        )
                )
        }
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 15)
    }
}

