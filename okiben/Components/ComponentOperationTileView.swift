import SwiftUI

struct ComponentOperationTileView: View {
    let buttonText: String
    let onPressed: () -> Void
    let detailText: String
    let centerText: String
    let isLightMode: Bool

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
                (isLightMode)
                    ? Color(red: 236/255, green: 235/255, blue: 241/255)
                    : Color(red: 70/255, green: 68/255, blue: 65/255)
            )
            .cornerRadius(8)
        }
    }
}
