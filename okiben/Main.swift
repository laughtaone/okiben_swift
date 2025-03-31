import SwiftUI

struct Main: View {
    // ================================================== 変数類 =================================================
    @State private var selectedTab = 0
    @State private var isDisplaySettingPage = false
    @State private var isDisplayAddPage = false
    @State var inputNewItemName = ""

    @State private var itemList: [ItemData] = [
        ItemData(name: "数学の教科書", memo: "Aくんに貸した", isOkiben: true),
        ItemData(name: "英語の教科書", memo: "来週の授業で必要！", isOkiben: false)
    ]
    
    // ライトモードかどうかの真偽値
    @Environment(\.colorScheme) var colorScheme
    var isLightMode: Bool {
        colorScheme == .light
    }
    
    init(){
        // TabViewの背景色の設定
        UITabBar.appearance().backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
        
        let appearance = UITabBarAppearance()
        if #available(iOS 13.0, *) {
            appearance.backgroundColor = UIColor { traitCollection in
                (traitCollection.userInterfaceStyle == .light)
                    ? UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
                    : UIColor(red: 58/255, green: 58/255, blue: 58/255, alpha: 1)
            }
        }
        UITabBar.appearance().scrollEdgeAppearance = appearance
        UITabBar.appearance().standardAppearance = appearance
    }
    // ==========================================================================================================


    

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // ----------------------- アプリ上部タイトル(=FlutterのAppBar) ----------------------
                    Text("")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            // - - - - - - 真ん中のタイトル - - - - - -
                            ToolbarItem(placement: .principal) {
                                HStack {
                                    Image(systemName: (selectedTab == 0) ? "slider.horizontal.3" : "map")
                                    Text((selectedTab == 0) ? "置き勉管理" : "ビュー")
                                }
                            }
                            // - - - - - - - - - - - - - - - - - - -
                            // - - - - - - - 設定ボタン - - - - - - -
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button(action: {
                                    isDisplaySettingPage.toggle()
                                }) {
                                    Image(systemName: "gearshape")
                                        .foregroundColor(.primary)
                                }
                            }
                            // - - - - - - - - - - - - - - - - - - -
                        }
                        .toolbarBackground(
                            (isLightMode)
                                ? Color(red: 240/255, green: 240/255, blue: 240/255)
                                : Color(red: 58/255, green: 58/255, blue: 58/255),
                            for: .navigationBar
                        )
                        .toolbarBackground(.visible, for: .navigationBar)   // ツールバーの背景を表示
                        .frame(height: 0)
                    // -------------------------------------------------------------------------------
                    
                    // ------------------ アプリ下部タブ(=FlutterのBottomNavigationBar) ------------------
                    TabView(selection: $selectedTab) {
                        // 置き勉管理ページ
                        ManagePage(
                            itemList: $itemList,
                            argListChanged: { newList in
                                itemList = newList
                            },
                            isLightMode: isLightMode
                        )
                            .tabItem {
                                Image(systemName: "slider.horizontal.3")
                                Text("置き勉管理")
                            }
                            .tag(0)
                        
                        // ビューページ
                        ViewPage(
                            itemList: $itemList,
                            isLightMode: isLightMode
                        )
                            .tabItem {
                                Image(systemName: "map")
                                    .foregroundColor(.primary)
                                Text("ビュー")
                                    .foregroundColor(.primary)
                            }
                            .tag(1)
                    }
                    .frame(maxHeight: .infinity) // TabViewの高さを最大化
                    // -------------------------------------------------------------------------------
                }
                .sheet(isPresented: $isDisplaySettingPage) {
                    SettingsPage(
                        argIsOnPressed: {
                            isDisplaySettingPage = false
                        },
                        argListClear: {
                            itemList.removeAll()
                        },
                        isLightMode: isLightMode
                    )
                        .presentationDetents([.large]) // .largeでフルスクリーン表示
                        .presentationDragIndicator(.visible)
                }

                // ------------------ 画面右下のボタン(=FlutterのFloatActionButton) -------------------
                if (selectedTab == 0) {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                isDisplayAddPage = true
                                print("右下の+ボタンが押されたお")
                            }) {
                                Image(systemName: "plus")
                                    .font(.system(size: 24))
                                    .padding()
                                    .background((isLightMode)
                                        ? Color(red: 64/255, green: 64/255, blue: 64/255)
                                        : Color(red: 224/255, green: 224/255, blue: 224/255))
                                    .foregroundColor((isLightMode) ? .white : .black)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding(.trailing, 20)
                            .padding(.bottom, 80)
                            .sheet(
                                isPresented: $isDisplayAddPage,
                                onDismiss: {
                                    inputNewItemName = ""
                                }
                            ) {
                                ComponentUpDialog(
                                    showModal: .constant(true),
                                    title: "📚 アイテム追加",
                                    argIsOnPressed: {
                                        isDisplayAddPage = false
                                    },
                                    content: {
                                        VStack(alignment: .leading) {
                                            Spacer().frame(height: 15)
                                            
                                            // - - - -　アイテム名入力フィールド - - - -
                                            Text("↓ 追加するアイテム名を入力")
                                                .font(.system(size: 14))
                                            TextField("", text: $inputNewItemName)
                                                .font(.system(size: 16))
                                                .padding()
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 8)
                                                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                                                )
                                            // - - - - - - - - - - - - - - - - - - -
                                            
                                            Spacer().frame(height: 40)
                                            
                                            // - - - - - - -　保存ボタン - - - - - - -
                                            ComponentCommonButton(
                                                buttonText: "保存",
                                                onPressed: (inputNewItemName != "")
                                                    ? {
                                                        print("保存ボタンが押されました")
                                                        itemList.append(ItemData(name: inputNewItemName, memo: "", isOkiben: false))
                                                        inputNewItemName = ""
                                                        isDisplayAddPage = false
                                                    }
                                                    : nil,
                                                customButtonColor: (inputNewItemName != "")
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
                            }
                        }
                    }
                }
                // -------------------------------------------------------------------------------
                
            }
        }
    }
}




#Preview {
    Main()
}



struct ItemData: Identifiable {
    var id = UUID()
    var name: String
    var memo: String
    var isOkiben: Bool
}
