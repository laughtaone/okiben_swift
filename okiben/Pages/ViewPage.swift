import SwiftUI


struct ViewPage: View {
    // ================================================== 変数類 =================================================
    @Binding var itemList: [ItemData]
    var isLightMode: Bool
    // ==========================================================================================================


    var body: some View {
        if (itemList.count == 0) {
            ComponentNoItemDisplay(type: 2)
        } else {
            VStack(alignment: .leading, spacing: 0) {
                // --------------------- 冒頭説明フィールド ---------------------
                VStack(spacing: 5) {
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(.primary)
                            .font(.system(size: 13))
                        
                        Text("持ち物がどこにあるか一目でわかります")
                            .foregroundColor(.primary)
                            .font(.system(size: 15))
                            .padding(.leading, 0)
                        
                        Spacer()
                    }
                    
                    HStack {
                        Image(systemName: "checkmark")
                            .foregroundColor(.primary)
                            .font(.system(size: 13))
                        
                        Text("スクロール可能です")
                            .foregroundColor(.primary)
                            .font(.system(size: 15))
                            .padding(.leading, 0)
                        
                        Spacer()
                    }
                }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background((isLightMode) ? Color(hex: 0xf5f5f5) : Color(hex: 0x303030))
                .cornerRadius(10)
                .padding(.top, 8)
                .padding(.bottom, 10)
                // -----------------------------------------------------------
                
                // ----------------------- 学校にあるもの ----------------------
                ComponentViewTile(
                    isInSchool: true,
                    itemList: itemList,
                    isLightMode: isLightMode
                )
                .padding(.bottom, 5)
                // -----------------------------------------------------------
                
                Spacer()
                
                // ------------------------ 家にあるもの -----------------------
                ComponentViewTile(
                    isInSchool: false,
                    itemList: itemList,
                    isLightMode: isLightMode
                )
                .padding(.top, 5)
                // -----------------------------------------------------------
            }
            .padding([.leading, .trailing], 15)
            .padding(.bottom, 65)
        }
    }
}



extension Color {
    init(hex: Int) {
        let red = Double((hex >> 16) & 0xFF) / 255.0
        let green = Double((hex >> 8) & 0xFF) / 255.0
        let blue = Double(hex & 0xFF) / 255.0
        self.init(red: red, green: green, blue: blue)
    }
}
