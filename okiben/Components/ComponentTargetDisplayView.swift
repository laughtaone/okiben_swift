import SwiftUI

struct ComponentTargetDisplayView: View {
    let title: String
    let displayText: String

    var body: some View {
        HStack {
            Text(title)
                .font(.system(size: 15))
                .foregroundColor(Color.primary)
            
            Spacer().frame(width: 10)
            
            Text(displayText.isEmpty ? "未設定" : displayText)
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(displayText.isEmpty ? Color.gray : Color.primary)
                .lineLimit(3)
                .truncationMode(.tail)
                .frame(maxWidth: .infinity, alignment: .center)
        }
        .padding(.horizontal, 17)
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity)
        .background(
            Color(UIColor { $0.userInterfaceStyle == .dark ? UIColor.darkGray : UIColor.systemGray6 })
        )
        .cornerRadius(12)
    }
}

