import SwiftUI

struct ComponentNoItemDisplay: View {
    let type: Int

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
            Spacer()
            Text("🫥").font(.system(size: 55))
            Text("アイテムがありません").font(.system(size: 25, weight: .bold))
            Spacer().frame(height: 10)
            Text(
                (type == 1)
                    ? "右下の+ボタンを押して"
                    : (type == 2)
                        ? "置き勉管理タブの+ボタンを押して"
                        : ""
            ).font(.system(size: 15))
            Text("アイテムを追加してください").font(.system(size: 15))
            Spacer()
        }
    }
}
