import SwiftUI

struct ComponentCloseButton: View {
    var onPressed: () -> Void
    var customIconSize: CGFloat = 39  // アイコンサイズ
    var isLightMode: Bool

    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        Button(action: onPressed) {
            ZStack {
                // ------------------------------------ 背景の円 -----------------------------------
                Circle()
                    .fill(
                        (isLightMode)
                            ? Color(red: 240/255, green: 240/255, blue: 240/255)
                            : Color(red: 140/255, green: 140/255, blue: 140/255)
                    )
                    .frame(width: customIconSize, height: customIconSize)
                // -------------------------------------------------------------------------------
                
                // ------------------------------------ バツマーク ---------------------------------
                Image(systemName: "xmark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .font(.system(size: customIconSize * 0.38, weight: .bold))
                    .frame(width: customIconSize * 0.38, height: customIconSize * 0.38)
                    .foregroundColor(
                        (isLightMode)
                            ? Color(red: 100/255, green: 100/255, blue: 100/255)
                            : Color(red: 20/255, green: 20/255, blue: 20/255)
                    )
                // -------------------------------------------------------------------------------
            }
        }
        .buttonStyle(PlainButtonStyle())
        .padding(.top, 15)
    }
}
