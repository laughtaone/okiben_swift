import SwiftUI


struct ViewPage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            // --------------------- 冒頭説明フィールド ---------------------
            VStack(spacing: 5) {
                HStack {
                    Image(systemName: "checkmark")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                    
                    Text("持ち物がどこにあるか一目でわかります")
                        .font(.system(size: 15))
                        .padding(.leading, 0)
                    
                    Spacer()
                }
                
                HStack {
                    Image(systemName: "checkmark")
                        .foregroundColor(.black)
                        .font(.system(size: 13))
                    
                    Text("スクロール可能です")
                        .font(.system(size: 15))
                        .padding(.leading, 0)
                    
                    Spacer()
                }
            }
                .padding(.vertical, 8)
                .padding(.horizontal, 12)
                .background(Color(hex: 0xf5f5f5))
                .cornerRadius(10)
                .padding(.top, 8)
                .padding(.bottom, 10)
            // -----------------------------------------------------------
            
            // ----------------------- 学校にあるもの ----------------------
            ComponentViewTile(isInSchool: true, itemList: [["name": "Notebook", "isOkiben": true],
                                                           ["name": "Pen", "isOkiben": true],
                                                           ["name": "Bag", "isOkiben": true]])
                .padding(.bottom, 5)
            // -----------------------------------------------------------
            
            Spacer()
            
            // ------------------------ 家にあるもの -----------------------
            ComponentViewTile(isInSchool: false, itemList: [["name": "Notebook", "isOkiben": false],
                                                           ["name": "Pen", "isOkiben": false],
                                                           ["name": "Bag", "isOkiben": false]])
                .padding(.top, 5)
            // -----------------------------------------------------------
        }
        .padding([.leading, .trailing], 15)
        .padding(.bottom, 65)
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
