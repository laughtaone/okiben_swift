import SwiftUI


struct ComponentItemTile: View {
    // ================================================== 変数類 =================================================
    var name: String
    var memo: String
    @Binding var value: Bool
    var argIsOkibenChanged: (Bool) -> Void
    var argNameChanged: (String) -> Void
    var argMemoChanged: (String) -> Void
    var argDeleted: () -> Void
    
    @State private var isDisplayDialog: DialogType? = nil
    @State var inputNewName: String
    @State var inputNewMemo: String
    
    var isLightMode: Bool
    
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
    
    init(
        name: String,
        memo: String,
        value: Binding<Bool>,
        argIsOkibenChanged: @escaping (Bool) -> Void,
        argNameChanged: @escaping (String) -> Void,
        argMemoChanged: @escaping (String) -> Void,
        argDeleted: @escaping () -> Void,
        isLightMode: Bool
    ) {
        self.name = name
        self.memo = memo
        _value = value
        self.argIsOkibenChanged = argIsOkibenChanged
        self.argNameChanged = argNameChanged
        self.argMemoChanged = argMemoChanged
        self.argDeleted = argDeleted
        self.isLightMode = isLightMode
        
        _inputNewName = State(initialValue: name)
        _inputNewMemo = State(initialValue: memo)
    }
    // ==========================================================================================================
    
    

    


    var body: some View {
        ZStack {
            VStack {
                // ================================================ ボタン本体 ================================================
                Button(action: {
                    print("ボタンが押されたお")
                    isDisplayDialog = .main
                }) {
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text(name)
                                .font(.system(size: 23, weight: .bold))
                                .lineLimit(1)
                                .truncationMode(.tail)
                                .foregroundColor((isLightMode) ? .black : .white)
                            
                            Text(memo)
                                .font(.system(size: 13))
                                .lineLimit(2)
                                .multilineTextAlignment(.leading)
                                .foregroundColor((isLightMode) ? .black : .white)
                        }
                        Spacer()
                        Toggle("", isOn: $value)
                            .labelsHidden()
                            .scaleEffect(1.3)
                            .onChange(of: value) {
                                argIsOkibenChanged(value)
                            }
                            .padding(.trailing, 5)
                    }
                    .padding(.vertical, 17)
                    .padding(.horizontal, 15)
                    .background(
                        (isLightMode)
                            ? Color(red: 244/255, green: 244/255, blue: 244/255)
                            : Color(red: 68/255, green: 68/255, blue: 68/255)
                    )
                    .cornerRadius(8)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                    )
                    .frame(height: 60)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical)
                // ==========================================================================================================
                // ================================================ ダイアログ ================================================
                .sheet(
                    item: $isDisplayDialog,
                    onDismiss: {
                        inputNewName = name
                        inputNewMemo = memo
                    }
                ) { dialogType in
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
                                    ComponentTargetDisplayView(title: "元の名前", displayText: name, isLightMode: isLightMode)
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                    
                                    // - - - -　アイテム名入力フィールド - - - -
                                    Text("↓ 変更後の名前を入力")
                                        .font(.system(size: 14))
                                    TextField("", text: $inputNewName)
                                        .font(.system(size: 16))
                                        .padding()
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                        )
                                    // - - - - - - - - - - - - - - - - - - -

                                    Spacer()
                                    
                                    // - - - - - - -　保存ボタン - - - - - - -
                                    ComponentCommonButton(
                                        buttonText: "保存",
                                        onPressed: (inputNewName != name && inputNewName != "")
                                            ? {
                                                print("保存ボタンが押されました")
                                                argNameChanged(inputNewName)
                                                isDisplayDialog = nil
                                            }
                                            : nil,
                                        customButtonColor: (inputNewName != name)
                                            ? (isLightMode)
                                                ? Color(red: 85/255, green: 85/255, blue: 85/255)
                                                : Color(red: 110/255, green: 110/255, blue: 110/255)
                                            : (isLightMode)
                                                ? Color(red: 235/255, green: 235/255, blue: 235/255)
                                                : Color(red: 95/255, green: 95/255, blue: 95/255)
                                    )
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                }
                            },
                            isLightMode: isLightMode
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
                                    // - - - - - - -　元のメモ案内 - - - - - -
                                    ComponentTargetDisplayView(title: "元のメモ", displayText: memo, isLightMode: isLightMode)
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()

                                    // - - - - -　メモ入力フィールド - - - - -
                                    Text("↓ 変更後のメモを入力")
                                        .font(.system(size: 14))
                                    TextEditor(text: $inputNewMemo)
                                        .font(.system(size: 16))
                                        .frame(height: 100)
                                        .padding(.horizontal, 8)
                                        .overlay(
                                            RoundedRectangle(cornerRadius: 8)
                                                .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                        )
                                    // - - - - - - - - - - - - - - - - - - -

                                    Spacer()
                                    
                                    // - - - - - - -　保存ボタン - - - - - - -
                                    ComponentCommonButton(
                                        buttonText: "保存",
                                        onPressed: (inputNewMemo != memo && inputNewMemo != "")
                                            ? {
                                                print("保存ボタンが押されました")
                                                argMemoChanged(inputNewMemo)
                                                isDisplayDialog = nil
                                            }
                                            : nil,
                                        customButtonColor: (inputNewMemo != memo && inputNewMemo != "")
                                            ? (isLightMode)
                                                ? Color(red: 85/255, green: 85/255, blue: 85/255)
                                                : Color(red: 110/255, green: 110/255, blue: 110/255)
                                            : (isLightMode)
                                                ? Color(red: 235/255, green: 235/255, blue: 235/255)
                                                : Color(red: 95/255, green: 95/255, blue: 95/255)
                                    )
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                }
                            },
                            isLightMode: isLightMode
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
                                    ComponentTargetDisplayView(title: "削除対象", displayText: name, isLightMode: isLightMode)
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                    
                                    // - - - - - - 削除ボタン - - - - - - - -
                                    ComponentCommonButton(
                                        buttonText: "完全に削除",
                                        onPressed: {
                                            print("ボタンが押されました")
                                            argDeleted()
                                            isDisplayDialog = nil
                                        },
                                        customButtonColor: Color(red: 234/255, green: 89/255, blue: 110/255)
                                    )
                                    .padding(.horizontal)
                                    .frame(maxWidth: .infinity)
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                }
                            },
                            isLightMode: isLightMode
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
                                    ComponentTargetDisplayView(title: "操作対象", displayText: name, isLightMode: isLightMode)
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
                                            centerText: name,
                                            isLightMode: isLightMode
                                        )
                                        ComponentOperationTileView(
                                            buttonText: "📋 メモ",
                                            onPressed: {
                                                print("メモボタンが押されたお")
                                                isDisplayDialog = .memo
                                            },
                                            detailText: "メモを編集",
                                            centerText: memo,
                                            isLightMode: isLightMode
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
                                                .foregroundColor(.primary)
                                            Text("削除")
                                                .font(.system(size: 13))
                                                .lineLimit(1)
                                                .truncationMode(.tail)
                                                .foregroundColor(.primary)
                                        }
                                    }
                                    // - - - - - - - - - - - - - - - - - - -
                                    
                                    Spacer()
                                }
                            },
                            isLightMode: isLightMode
                        )
                    // -------------------------------------------------------------------------------
                    }
                }
                // ==========================================================================================================
            }
        }
    }
}
