import SwiftUI

struct ComponentCommonButton: View {
    let buttonText: String
    let onPressed: (() -> Void)?
    let customButtonColor: Color?
    let customWidth: CGFloat
    
    init(buttonText: String, onPressed: (() -> Void)?, customButtonColor: Color? = nil, customWidth: CGFloat = 190) {
        self.buttonText = buttonText
        self.onPressed = onPressed
        self.customButtonColor = customButtonColor
        self.customWidth = customWidth
    }

    var body: some View {
        Button(action: {
            onPressed?()
        }) {
            Text(buttonText)
                .font(.system(size: 17, weight: .bold))
                .frame(width: customWidth, height: 63)
                .background(
                    (customButtonColor != nil ? customButtonColor : (colorScheme == .light ? Color.gray : Color.gray))
                        .cornerRadius(30)
                )
                .foregroundColor(onPressed == nil ? (colorScheme == .light ? Color.white : Color.gray) : Color.white)
                .opacity(onPressed == nil ? 0.35 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
    }

    private var colorScheme: ColorScheme {
        return UITraitCollection.current.userInterfaceStyle == .light ? .light : .dark
    }
}

struct ComponentCommonButton_Previews: PreviewProvider {
    static var previews: some View {
        ComponentCommonButton(buttonText: "保存", onPressed: nil)
            .previewLayout(.sizeThatFits)
    }
}
