import SwiftUI


struct ManagePage: View {
    @State private var showModal = false
    var argIsOnPressed: (Bool) -> Void

    
    var body: some View {
        ZStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 0) {
                    // - - - - - - - アイテム数表示 - - - - - -
                    Text("全？アイテム(置き勉？点 | 家？点)")
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    // - - - - - - - - - - - - - - - - - - -
                    
                    // - - - - - - - アイテムタイル - - - - - -
                    ComponentItemTile(
                        title: "サンプルタイトル",
                        memo: "これはメモのテキストです。最大2行まで表示されます。",
                        value: true,
                        onToggle: { newValue in
                            
                        },
                        argIsOnPressed: { value in
                            argIsOnPressed(true)
                        }
                    )
                    // - - - - - - - - - - - - - - - - - - -

                    Spacer()
                }
                .padding([.leading, .trailing], 15)
                .padding(.bottom, 65)
            }
            .padding(.trailing, 0)
        }
    }
}
