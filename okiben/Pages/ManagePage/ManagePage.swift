import SwiftUI

struct ManagePage: View {
    // ================================================== 変数類 =================================================
    @State private var showModal = false
    @Binding var itemList: [ItemData]
    var argListChanged: ([ItemData]) -> Void
    var isLightMode: Bool
    // ==========================================================================================================
    


    var body: some View {
        if (itemList.count == 0) {
            ComponentNoItemDisplay(type: 1)
        } else {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // - - - - - - - アイテム数表示 - - - - - -
                    Text("全\(itemList.count)アイテム (置き勉\(itemList.filter { $0.isOkiben }.count)点 | 家\(itemList.filter { !$0.isOkiben }.count)点)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.bottom, 10)
                    // - - - - - - - - - - - - - - - - - - -
                    
                    // - - - - - - - アイテムタイル - - - - - -
                    ForEach(itemList.indices, id: \.self) { index in
                        ComponentItemTile(
                            name: itemList[index].name,
                            memo: itemList[index].memo,
                            value: $itemList[index].isOkiben,
                            argIsOkibenChanged: { newIsOkiben in
                                itemList[index].isOkiben = newIsOkiben
                                argListChanged(itemList)
                            },
                            argNameChanged: { newName in
                                itemList[index].name = newName
                                argListChanged(itemList)
                            },
                            argMemoChanged: { newMemo in
                                itemList[index].memo = newMemo
                                argListChanged(itemList)
                            },
                            argDeleted: {
                                itemList.remove(at: index)
                                argListChanged(itemList)
                            },
                            isLightMode: isLightMode
                        )
                    }
                    // - - - - - - - - - - - - - - - - - - -
                    
                    Spacer()
                }
            }
            .padding([.leading, .trailing], 15)
            .padding(.bottom, (itemList.count == 0) ? 0 : 65)
        }
    }
}

