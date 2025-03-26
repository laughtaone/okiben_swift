import SwiftUI

struct ComponentUpDialog<Content: View>: View {
    @Binding var showModal: Bool
    @State var title: String
    var argIsOnPressed: () -> Void
    let content: () -> Content
    
    init(showModal: Binding<Bool>, title: String, argIsOnPressed: @escaping () -> Void, @ViewBuilder content: @escaping () -> Content) {
        self._showModal = showModal
        self.title = title
        self.argIsOnPressed = argIsOnPressed
        self.content = content
    }
    
    


    var body: some View {
        NavigationStack {
            VStack {
                content()
            }
            .padding(.horizontal, 15)
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
                // - - - - - - - 真ん中のバー - - - - - - - -
                ToolbarItem(placement: .principal) {
                    ComponentDialogBar()
                        .padding(.horizontal, 0) // 水平余白を削除
                }
                // - - - - - - - - - - - - - - - - - - - -
                // - - - - - - 右側の閉じるボタン - - - - - -
                ToolbarItem(placement: .navigationBarTrailing) {
                    ComponentCloseButton(
                        onPressed: {
                            showModal.toggle()
                            argIsOnPressed()
                        }
                    )
                    .padding(.trailing, 0) // 右の余白を削除
                }
                // - - - - - - - - - - - - - - - - - - -
            }
        }
        .presentationDetents([.medium])
    }
}
