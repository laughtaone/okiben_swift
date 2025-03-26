import SwiftUI

struct ComponentCloseButton: View {
    var onPressed: () -> Void
    var customIconSize: CGFloat = 38  // アイコンサイズ (デフォルトは27)

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: onPressed) {
            Image(systemName: "xmark.circle.fill")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: customIconSize, height: customIconSize)
                .foregroundColor(Color(red: 224/255, green: 224/255, blue: 224/255))
                .background(
                    Circle()
                        .fill(Color(red: 21/255, green: 21/255, blue: 21/255))
                )
        }
            .buttonStyle(PlainButtonStyle())
            .padding(.top, 15)
    }
}

struct ComponentCloseButton_Previews: PreviewProvider {
    static var previews: some View {
        ComponentCloseButton(onPressed: { print("Close button pressed") })
            .previewLayout(.sizeThatFits)
    }
}
