import SwiftUI

struct ComponentUpDialog<Content: View>: View {
    // ================================================== 変数類 =================================================
    @Binding var showModal: Bool
    @State var title: String
    var argIsOnPressed: () -> Void
    let content: () -> Content
    var isNeedLRPadding: Bool
    var isLightMode: Bool = true

    init(
        showModal: Binding<Bool>,
        title: String,
        argIsOnPressed: @escaping () -> Void,
        isNeedLRPadding: Bool = true, // ここでデフォルト値を設定
        @ViewBuilder content: @escaping () -> Content,
        isLightMode:Bool = true
    ) {
        self._showModal = showModal
        self.title = title
        self.argIsOnPressed = argIsOnPressed
        self.isNeedLRPadding = isNeedLRPadding
        self.content = content
        self.isLightMode = isLightMode
    }
    // ==========================================================================================================


    var body: some View {
        NavigationStack {
            VStack {
                content()
            }
            .padding(.horizontal, (isNeedLRPadding) ? 15 : 0)
            .padding(.top, 8)   // ヘッダーと操作対象の間の余白
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                // - - - - - - - 左側のテキスト - - - - - - -
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(title)
                        .padding(.top, 15)
                        .font(.system(size: 24))
                        .padding(.leading, 0) // 左の余白を削除
                }
                // - - - - - - - - - - - - - - - - - - - -
                // - - - - - - 右側の閉じるボタン - - - - - -
                ToolbarItem(placement: .navigationBarTrailing) {
                    ComponentCloseButton(
                        onPressed: {
                            showModal.toggle()
                            argIsOnPressed()
                        },
                        isLightMode: isLightMode
                    )
                    .padding(.trailing, 0) // 右の余白を削除
                }
                // - - - - - - - - - - - - - - - - - - -
            }
        }
        .presentationDetents([.fraction(0.47)])
        .presentationDragIndicator(.visible)
    }
}
