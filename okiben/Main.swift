import SwiftUI

struct Main: View {
    @State private var selectedTab = 0
    @State private var showingDialog = false
    @State private var showModal = false
    @State private var isDisplaySettingPage = false
    @State private var isDisplayAddPage = false
    @State var inputNewItemName = ""
    
    
    init(){
        // TabViewの背景色の設定
        UITabBar.appearance().backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    

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
                                }
                            }
                            // - - - - - - - - - - - - - - - - - - -
                        }
                        .toolbarBackground(Color(red: 240/255, green: 240/255, blue: 240/255), for: .navigationBar)   // ツールバーの背景色を灰色に設定
                        .toolbarBackground(.visible, for: .navigationBar)   // ツールバーの背景を表示
                        .frame(height: 0)
                    // -------------------------------------------------------------------------------
                    
                    // ------------------ アプリ下部タブ(=FlutterのBottomNavigationBar) ------------------
                    TabView(selection: $selectedTab) {
                        // 置き勉管理ページ
                        ManagePage(
                            argIsOnPressed: { value in
                                showModal = true
                            }
                        )
                            .tabItem {
                                Image(systemName: "slider.horizontal.3")
                                Text("置き勉管理")
                            }
                            .tag(0)
                        
                        // ビューページ
                        ViewPage()
                            .tabItem {
                                Image(systemName: "map")
                                Text("ビュー")
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
                        }
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
                                    .background(Color.black)
                                    .foregroundColor(.white)
                                    .clipShape(Circle())
                                    .shadow(radius: 5)
                            }
                            .padding(.trailing, 20)
                            .padding(.bottom, 80)
                            .sheet(isPresented: $isDisplayAddPage) {
                                ComponentUpDialog(
                                    showModal: .constant(true),
                                    title: "📚 アイテム追加",
                                    argIsOnPressed: {
                                        isDisplayAddPage = false
                                    },
                                    content: {
                                        VStack(alignment: .leading) {
                                            // - - - - - - -　元の名前案内 - - - - - -
                                            ComponentTargetDisplayView(title: "元の名前", displayText: "サンプルタイトル")
                                            // - - - - - - - - - - - - - - - - - - -
                                            
                                            Spacer().frame(height: 40)
                                            
                                            Text("↓ 追加するアイテム名を入力")
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
