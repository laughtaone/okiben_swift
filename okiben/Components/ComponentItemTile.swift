import SwiftUI


struct ComponentItemTile: View {
    var title: String
    var memo: String
    var value: Bool
    var onToggle: (Bool) -> Void
    
    @State private var isDisplayDialog: DialogType? = nil
    @State var inputNewItemName = ""
    
    enum DialogType: Identifiable {
        case main, edit, memo, delete
        
        var id: String {
            switch self {
                case .main: return "main"
                case .edit: return "edit"
                case .memo: return "memo"
                case .delete: return "delete"
            }
        }
    }

    var argIsOnPressed: (Bool) -> Void


    var body: some View {
        ZStack {
            VStack {
                // ================================================ ボタン本体 ================================================
                Button(action: {
                    print("ボタンが押されたお")
                    print("isDisplayDialogは、\(isDisplayDialog)")
                    isDisplayDialog = .main
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
                // ==========================================================================================================
                .frame(maxWidth: .infinity, minHeight: 95)
                // ================================================ ダイアログ ================================================
                .sheet(item: $isDisplayDialog) { dialogType in
                    switch dialogType {
                    // --------------------------------- 編集ダイアログ ---------------------------------
                    case .edit:
                        ComponentUpDialog(
                            showModal: .constant(true),
                            title: "✏️ 編集",
                            argIsOnPressed: {
                                isDisplayDialog = nil
                            },
                            content: {
                                VStack(alignment: .leading) {
                                    // - - - - - - -　元の名前案内 - - - - - -
                                    ComponentTargetDisplayView(title: "元の名前", displayText: "サンプルタイトル")
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer().frame(height: 40)
                                    
                                    Text("↓ 変更後のアイテム名を入力")
                                        .font(.system(size: 14))
                                    TextField("", text: $inputNewItemName)
                                        .font(.system(size: 16))
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                        )

                                    Spacer().frame(height: 40)
                                    
                                    ComponentCommonButton(
                                        buttonText: "保存",
                                        onPressed: { print("保存ボタンが押されました") }
                                    )
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    
                                    Spacer()
                                }
                            }
                        )
                    // -------------------------------------------------------------------------------
                    // --------------------------------- メモダイアログ ---------------------------------
                    case .memo:
                        ComponentUpDialog(
                            showModal: .constant(true),
                            title: "📋 メモ",
                            argIsOnPressed: {
                                isDisplayDialog = nil
                            },
                            content: {
                                VStack(alignment: .leading) {
                                    // - - - - - - -　元の名前案内 - - - - - -
                                    ComponentTargetDisplayView(title: "元のメモ", displayText: "サンプルメモ")
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer().frame(height: 40)
                                    
                                    Text("↓ 変更後のメモを入力")
                                        .font(.system(size: 14))
                                    TextField("", text: $inputNewItemName)
                                        .font(.system(size: 16))
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                        )

                                    Spacer().frame(height: 40)
                                    
                                    ComponentCommonButton(
                                        buttonText: "保存",
                                        onPressed: { print("保存ボタンが押されました") }
                                    )
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    
                                    Spacer()
                                }
                            }
                        )
                    // -------------------------------------------------------------------------------
                    // --------------------------------- 削除ダイアログ ---------------------------------
                    case .delete:
                        ComponentUpDialog(
                            showModal: .constant(true),
                            title: "🗑️ 削除",
                            argIsOnPressed: {
                                isDisplayDialog = nil
                            },
                            content: {
                                VStack(alignment: .leading) {
                                    // - - - - - - - 確認文 - - - - - - - - -
                                    Text("本当に削除しますか？")
                                        .font(.system(size: 19, weight: .medium))
                                        .multilineTextAlignment(.leading)
                                        .padding(.bottom, 1)
                                    Text("下のボタンを押すと確認なしに削除が実行されます")
                                        .font(.system(size: 14))
                                        .multilineTextAlignment(.leading)
                                        .padding(.bottom, 7)
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    // - - - - - - -　削除対象案内 - - - - - -
                                    ComponentTargetDisplayView(title: "削除対象", displayText: "サンプルタイトル")
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                    
                                    // - - - - - - 削除ボタン - - - - - - - -
                                    ComponentCommonButton(
                                        buttonText: "完全に削除",
                                        onPressed: { print("ボタンが押されました") },
                                        customButtonColor: Color(red: 234/255, green: 89/255, blue: 110/255)
                                    )
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                }
                            }
                        )
                    // -------------------------------------------------------------------------------
                    // --------------------------------- 操作ダイアログ ---------------------------------
                    case .main:
                        ComponentUpDialog(
                            showModal: .constant(true),
                            title: "⚒️ 操作",
                            argIsOnPressed: {
                                isDisplayDialog = nil
                            },
                            content: {
                                VStack {
                                    // - - - - - - -　操作対象案内 - - - - - - -
                                    ComponentTargetDisplayView(title: "操作対象", displayText: "サンプルタイトル")
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer().frame(height: 25)
                                    
                                    // - - - - - - - 操作ボタン - - - - - - - -
                                    HStack {
                                        ComponentOperationTileView(
                                            buttonText: "✏️ 編集",
                                            onPressed: {
                                                print("編集ボタンが押されたお")
                                                isDisplayDialog = .edit
                                            },
                                            detailText: "アイテム名を編集",
                                            centerText: "詳細情報"
                                        )
                                        ComponentOperationTileView(
                                            buttonText: "📋 メモ",
                                            onPressed: {
                                                print("メモボタンが押されたお")
                                                isDisplayDialog = .memo
                                            },
                                            detailText: "メモを編集",
                                            centerText: "詳細情報"
                                        )
                                    }
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer().frame(height: 40)
                                    
                                    // - - - - - - 削除ボタン - - - - - - - -
                                    Button(action: {
                                        print("削除ボタンが押されたお")
                                        isDisplayDialog = .delete
                                    }) {
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
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                }
                            }
                        )
                    // -------------------------------------------------------------------------------
                    }
                }
                // ==========================================================================================================
            }
        }
    }
}
