import SwiftUI

struct ComponentViewTile: View {
    let isInSchool: Bool
    let itemList: [[String: Any]]
    
    var filteredItems: [[String: Any]] {
        itemList.filter { item in
            let isOkibenValue = item["isOkiben"] as? Bool
            return isOkibenValue == isInSchool
        }
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
                Text("該当する持ち物はありません")
                    .padding(.top, 20)
            } else {
                FilteredItemListView(filteredItems: filteredItems)
                    .padding(.top, 0)
            }
        }
    }
}


// 枠線と中身部分
struct FilteredItemListView: View {
    let filteredItems: [[String: Any]]
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 10) {
                ForEach(filteredItems.indices, id: \.self) { index in
                    FilteredItemRow(item: filteredItems[index])
                }
            }
            .padding([.horizontal, .vertical], 7)
            .scrollIndicators(.visible)
        }
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.black.opacity(0.38), lineWidth: 1)    // 枠線
                    .background((Color(UIColor.systemBackground)).cornerRadius(10))
            )
    }
}


// 個々のアイテム名
struct FilteredItemRow: View {
    let item: [String: Any]
    
    var body: some View {
        Text((item["name"] as? String) ?? "名前なし")
            .font(.system(size: 20))
            .foregroundColor(.primary)
            .padding(.vertical, 0)
            .padding(.horizontal, 5)
    }
}
