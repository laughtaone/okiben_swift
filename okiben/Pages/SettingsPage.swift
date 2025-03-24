import SwiftUI

struct SettingsPage: View {
    var body: some View {
        // ------------ アプリ上部タイトル(=FlutterのAppBar) ------------
        Text("設定画面")
            .padding()
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack {
                        Image(systemName: "gearshape")
                        Text("設定")
                    }
                }
            }
        // -----------------------------------------------------------
    }
}


#Preview {
    SettingsPage()
}
