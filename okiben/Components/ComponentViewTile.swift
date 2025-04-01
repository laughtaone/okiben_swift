import SwiftUI


struct ComponentViewTile: View {
    // ================================================== 変数類 =================================================
    let isInSchool: Bool
    let itemList: [ItemData]
    let isLightMode: Bool
    // ==========================================================================================================
    
    var filteredItems: [ItemData] {
        itemList.filter { $0.isOkiben == isInSchool }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HStack {
                HStack {
                    Toggle("", isOn: .constant(isInSchool))
                        .labelsHidden()
                        .scaleEffect(0.8)
                    Text("\(isInSchool ? "学校" : "家")にあるもの")
                        .font(.system(size: 20, weight: .bold))
                }
                Spacer()
                Text("\(filteredItems.count)点")
                    .font(.system(size: 17))
            }
            .padding(.horizontal)
            .padding(.vertical, 0)
            
            Spacer()
            
            if filteredItems.isEmpty {
                Text("該当するアイテムはありません")
                Spacer()
            } else {
                FilteredItemListView(filteredItems: filteredItems, isLightMode: isLightMode)
                    .padding(.top, 0)
            }
        }
    }
}


// -------------------------------- 枠線と中身部分 ----------------------------------
struct FilteredItemListView: View {
    let filteredItems: [ItemData]
    let isLightMode: Bool
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(filteredItems) { item in
                    FilteredItemRow(item: item)
                }
            }
            .padding([.horizontal, .vertical], 7)
            .scrollIndicators(.visible)
        }
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(
                    (isLightMode)
                        ? Color(red: 200/255, green: 200/255, blue: 200/255)
                        : Color(red: 110/255, green: 110/255, blue: 110/255),
                    lineWidth: 1
                )
                .background((Color(UIColor.systemBackground)).cornerRadius(10))
        )
    }
}
// -------------------------------------------------------------------------------
// -------------------------------- 個々のアイテム名 ---------------------------------
struct FilteredItemRow: View {
    let item: ItemData
    
    var body: some View {
        Text(item.name)
            .font(.system(size: 20))
            .foregroundColor(.primary)
            .padding(.vertical, 0)
            .padding(.horizontal, 5)
    }
}
// -------------------------------------------------------------------------------
