import SwiftUI

struct ComponentDialogBar: View {
    var body: some View {
        RoundedRectangle(cornerRadius: 10) // 角丸の半径
            .frame(width: 60, height: 4)
            .foregroundColor(Color(red: 158/255, green: 158/255, blue: 158/255))
            .padding(.bottom)
    }
}
