import SwiftUI

struct ComponentOperationTileView: View {
    let buttonText: String
    let onPressed: () -> Void
    let detailText: String
    let centerText: String

    var body: some View {
        Button(action: onPressed) {
            VStack(alignment: .leading, spacing: 0) {
                // - - - - - - - - ヘッダー - - - - - - - -
                Text(buttonText)
                    .font(.system(size: 18, weight: .bold))
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundColor(.primary)
                // - - - - - - - - - - - - - - - - - - - -
                
                Spacer()

                // - - - - - - - 真ん中のテキスト - - - - - -
                Text(centerText)
                    .font(.system(size: 14))
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(.primary)
                // - - - - - - - - - - - - - - - - - - - -
                
                Spacer()

                // - - - - - - - - フッター - - - - - - - -
                HStack {
                    Text(detailText)
                        .font(.system(size: 13))
                        .lineLimit(1)
                        .truncationMode(.tail)
                        .foregroundColor(.primary)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .font(.system(size: 17))
                        .foregroundColor(.primary)
                }
                // - - - - - - - - - - - - - - - - - - - -
            }
            .padding(12)
            .frame(maxWidth: .infinity, maxHeight: 150)
            .background(
                Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor.darkGray : UIColor.systemGray6 })
            )
            .cornerRadius(8)
        }
    }
}
