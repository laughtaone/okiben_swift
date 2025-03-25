import SwiftUI

struct Main: View {
    @State private var selectedTab = 0
    @State private var showingDialog = false
    @State private var showModal = false
    
    
    init(){
        // TabViewの背景色の設定
        UITabBar.appearance().backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1)
    }
    

    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    // ------------ アプリ上部タイトル(=FlutterのAppBar) ------------
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
                                NavigationLink(destination: SettingsPage()) {
                                    Image(systemName: "gearshape")
                                }
                            }
                            // - - - - - - - - - - - - - - - - - - -
                        }
                        .toolbarBackground(Color(red: 240/255, green: 240/255, blue: 240/255), for: .navigationBar)   // ツールバーの背景色を灰色に設定
                        .toolbarBackground(.visible, for: .navigationBar)   // ツールバーの背景を表示
                        .frame(height: 0)
                    // -----------------------------------------------------------
                    
                    // -------- アプリ下部タブ(=FlutterのBottomNavigationBar) --------
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
                    // -----------------------------------------------------------
                }
                // -------- 画面右下のボタン(=FlutterのFloatActionButton) --------
                if (selectedTab == 0) {
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                showingDialog = true
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
                            .padding(.trailing, 20)  // 右側の余白
                            .padding(.bottom, 80)    // 下側の余白
                            .alert(isPresented: $showingDialog) {
                                Alert(
                                    title: Text("ダイアログ"),
                                    message: Text("本文"),
                                    dismissButton: .default(Text("OK"))
                                )
                            }
                        }
                    }
                }
                // -----------------------------------------------------------
                
                // --------------------- 画面下部ダイアログ ----------------------
                if (showModal) {
//                    
//                    NavigationStack {
//                        VStack {
//                            Text("SheetView")
//                        }
//                        .toolbar {
//                            Button("Close", role: .cancel){
//                                sheet.toggle()
//                            }
//                        }
//                    }.presentationDetents([.medium])
                    
                    
                    
                    /*
                    VStack {
                        Spacer()
                        VStack {
                            Text("これはダイアログです")
                                .font(.title)
                                .padding()
                            
                            Button("閉じる") {
                                showModal.toggle()
                            }
                            .padding()
                        }
                        .frame(maxWidth: .infinity) // 画面幅いっぱいに広げる
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(radius: 10)

    //                    Spacer() // これがあると中央配置される
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity) // 画面全体を覆う
                    .background(Color.black.opacity(0.3).edgesIgnoringSafeArea(.all)) // 背景オーバーレイ
                    .onTapGesture {
                        showModal.toggle() // 背景タップで閉じる
                    }
                    .transition(.move(edge: .bottom)) // 下からスライド
                    .animation(.easeInOut, value: showModal)
                    .padding(0)
                    */
                }
                // -----------------------------------------------------------
            }
        }
    }
}




#Preview {
    Main()
}
