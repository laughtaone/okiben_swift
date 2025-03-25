import SwiftUI

struct ComponentItemTile: View {
    var title: String
    var memo: String
    var value: Bool
    var onToggle: (Bool) -> Void
    
    @State private var showModal = false
    var argIsOnPressed: (Bool) -> Void
    

    var body: some View {
        ZStack {
            VStack {
                Button(action: {
                    print("ボタンが押されたお")
                    showModal.toggle()
                    argIsOnPressed(true)
                }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(title)
                                .font(.system(size: 23, weight: .bold))
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundColor(.black)
                            
                            Text(memo)
                                .font(.system(size: 13))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .foregroundColor(.black)
                        }
                        Spacer()
                        Toggle("", isOn: .constant(value))
                            .labelsHidden()
                            .scaleEffect(1.3)
                            .onChange(of: value) { newValue in
                                onToggle(newValue)
                            }
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                }
                .frame(maxWidth: .infinity, minHeight: 95)
                .sheet(isPresented: $showModal) {
                    ComponentUpDialog(
                        showModal: $showModal,
                        title: "⚒️ 操作",
                        content: {VStack {
                            // - - - - - - - - 操作対象 - - - - - - - -
                            ComponentTargetDisplayView(title: "操作対象", displayText: "サンプルタイトル")
                            // - - - - - - - - - - - - - - - - - - - -
                            
                            Spacer().frame(height: 25)
                            
                            // - - - - - - - - 操作ボタン - - - - - - -
                            HStack {
                                ComponentOperationTileView(
                                    buttonText: "✏️ 操作",
                                    onPressed: { print("操作ボタンが押されたお") },
                                    detailText: "アイテム名を編集",
                                    centerText: "詳細情報"
                                    
                                )
                                ComponentOperationTileView(
                                    buttonText: "📋 メモ",
                                    onPressed: { print("メモボタンが押されたお") },
                                    detailText: "メモを編集",
                                    centerText: "詳細情報"
                                    
                                )
                            }
                            // - - - - - - - - - - - - - - - - - - - -
                            
                            Spacer().frame(height: 40)
                            
                            // - - - - - - - - 削除ボタン - - - - - - -
                            Button(action: { print("削除ボタンが押されたお") }) {
                                HStack(alignment: .center, spacing: 7) {
                                    Image(systemName: "trash")
                                        .font(.system(size: 15))
                                        .foregroundColor(.black)
                                    Text("削除")
                                        .font(.system(size: 13))
                                        .lineLimit(1)
                                        .truncationMode(.tail)
                                        .foregroundColor(.black)
                                }
                            }
                            // - - - - - - - - - - - - - - - - - - - -
                            
                            Spacer()
                        }}
                    )
                }
            }
        }
    }
}

struct ComponentItemTile_Previews: PreviewProvider {
    static var previews: some View {
        ComponentItemTile(title: "Title", memo: "Memo text goes here", value: true, onToggle: { _ in }, argIsOnPressed: {_ in })
            .previewLayout(.sizeThatFits)
    }
}
