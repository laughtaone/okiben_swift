import SwiftUI

struct SettingsPage: View {
    var argIsOnPressed: () -> Void
    @State private var isDarkMode = false
    @State private var notificationsEnabled = true
    @State private var selectedLanguage = "日本語"
    let languages = ["日本語", "English", "Español"]
    
    @State private var nowDisplayMode = "system"
    let displayModeList = ["system", "light", "dark"]
    
    
    @State private var showGitHub = false
    @State private var showX = false
    @State private var showAppStore = false
    @State private var showTermsOfService = false
    @State private var showPrivacyPolicy = false
    @State private var showUsePackages = false
    @State private var showAppVersion = false
    
    @State private var isDisplayAllDeleteDialog = false
    @State private var isUnlockedAllDelete = false
    
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    
    

    var body: some View {
        // ------------ アプリ上部タイトル(=FlutterのAppBar) ------------
        
        // -----------------------------------------------------------
        
        ComponentUpDialog(
            showModal: .constant(true),
            title: "🔧 設定",
            argIsOnPressed: argIsOnPressed,
            isNeedLRPadding: false,
            content: {
                List {
                    // ----------------------------------- 外観モード ----------------------------------
                    Section(
                        header: Text("外観モード"),
                        footer: Text("画面全体の配色をカスタマイズできます。")
                    ) {
                        HStack {
                            Image(systemName: "sun.max")
                            Picker("外観モード", selection: $nowDisplayMode) {
                                ForEach(displayModeList, id: \.self) { displayMode in
                                    Text((displayMode == "system")
                                        ? "端末に合わせる"
                                        : (displayMode == "light")
                                            ? "ライトモード"
                                            : (displayMode == "dark")
                                                ? "ダークモード"
                                                : "不明"
                                    )
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                        }
                    }
                    
                    // -------------------------------------------------------------------------------
                    
                    // ---------------------------------- アプリ使い方 ---------------------------------
                    Section(header: Text("このアプリの使い方")) {
                        HStack(alignment: .top) {
                            Image(systemName: "1.square")
                                .padding(.top, 2)
                                .foregroundColor(.black)
                            Text("アイテムを「置き勉管理」タブの右下の+ボタンから追加します")
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "2.square")
                                .padding(.top, 2)
                                .foregroundColor(.black)
                            VStack(alignment: .leading) {
                                Text("追加したアイテムを")
                                Toggle("・置き勉したら", isOn: .constant(true))
                                Toggle("・置き勉しなかったら", isOn: .constant(false))
                                Text("にします")
                            }
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "3.square")
                                .padding(.top, 2)
                                .foregroundColor(.black)
                            Text("各アイテムをタップすると「編集」「メモ」「削除」の操作ができます")
                        }
                        HStack(alignment: .top) {
                            Image(systemName: "4.square")
                                .padding(.top, 2)
                                .foregroundColor(.black)
                            Text("各アイテムの置き勉状況は「ビュー」タブから一覧で見ることができます")
                        }
                    }
                    // -------------------------------------------------------------------------------
                    
                    // ---------------------------------- Danger Zone --------------------------------
                    Section(
                        header: Text("Danger Zone (!操作に要注意!)"),
                        footer: Text("この操作を実行すると、登録されている全てのアイテムが一括削除されます。")
                    ) {
                        Button {
                            print("一括削除ボタンが押されたお")
                            isDisplayAllDeleteDialog = true
                            isUnlockedAllDelete = false
                        } label: {
                            HStack {
                                Image(systemName: "flame").foregroundColor(.red)
                                Text("登録中のアイテムを一括削除").foregroundColor(.red)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.red)
                            }
                        }
                        .sheet(isPresented: $isDisplayAllDeleteDialog) {
                            ComponentUpDialog(
                                showModal: .constant(true),
                                title: "🚨 警告",
                                argIsOnPressed: {
                                    isDisplayAllDeleteDialog = false
                                },
                                content: {
                                    VStack(alignment: .leading) {
                                        // - - - - - -　削除確認メッセージ - - - - -
                                        Text("全て完全に削除")
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                            .underline()
                                        + Text("されます")
                                        
                                        Text("実行後の")
                                        + Text("取り消しはできません")
                                            .fontWeight(.bold)
                                            .foregroundColor(.red)
                                            .underline()
                                        
                                        Text("本当に削除しますか？")
                                            .padding(.bottom, 7)
                                        
                                        Text("(下のボタンを押すと確認なしに削除を実行します)")
                                            .font(.system(size: 13))
                                        // - - - - - - - - - - - - - - - - - - -
                                        
                                        Spacer().frame(height: 40)
                                        
                                        // - - - - - - - 完全に削除ボタン - - - - -
                                        ComponentCommonButton(
                                            buttonText: "完全に削除",
                                            onPressed: { print("完全に削除ボタンが押されました") },
                                            customButtonColor: (isUnlockedAllDelete)
                                                ? Color(red: 204/255, green: 61/255, blue: 61/255)
                                                : Color(red: 237/255, green: 187/255, blue: 187/255),
                                            customWidth: 230,
                                            customFontSize: 20
                                        )
                                        .padding(.horizontal)
                                        .frame(maxWidth: .infinity)
                                        // - - - - - - - - - - - - - - - - - - -
                                        
                                        Spacer().frame(height: 25)
                                        
                                        // - - - - - - - ロック解除ボタン - - - - -
                                        HStack {
                                            Image(systemName: "lock.open")
                                            Text("ロック解除 (長押し)")
                                        }
                                            .font(.system(size: 15))
                                            .foregroundColor(Color.black).opacity((isUnlockedAllDelete) ? 0.2 : 1)
                                            .padding(10)
                                            .background((isUnlockedAllDelete)
                                                ? Color(red: 251/255, green: 251/255, blue: 251/255)
                                                : Color(red: 224/255, green: 224/255, blue: 224/255)
                                            )
                                            .cornerRadius(10)
                                            .frame(maxWidth: .infinity)
                                            .onLongPressGesture(minimumDuration: 0.7) {
                                                print("ロック解除ボタンが長押しされました")
                                                isUnlockedAllDelete = true
                                                feedbackGenerator.prepare()
                                                feedbackGenerator.impactOccurred()
                                            }
                                        // - - - - - - - - - - - - - - - - - - -
                                        
                                        Spacer()
                                    }
                                }
                            )
                        }

                    }
                    // -------------------------------------------------------------------------------
                    
                    // ---------------------------------- 開発者について---------------------------------
                    Section(header: Text("開発者について")) {
                        // - - - - - - - - GitHub - - - - - - - -
                        Button {
                            print("GitHubボタンが押されたお")
                            showGitHub.toggle()
                        } label: {
                            HStack {
                                Text(String.FontAwesome(unicode: "f09b"))
                                    .font(.custom(CustomFonts.FABrandsRegular, size: 22))
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 4)
                                Text("GitHub").foregroundColor(.black)
                                Spacer()
                                Text("@laughtaone")
                                    .foregroundColor(.gray)
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showGitHub) {
                            SafariView(url: URL(string: "https://www.github.com/laughtaone/")!)
                        }
                        // - - - - - - - - - - - - - - - - - - -
                        // - - - - - - - - - X - - - - - - - - -
                        Button {
                            print("Xボタンが押されたお")
                            showX.toggle()
                        } label: {
                            HStack {
                                Text(String.FontAwesome(unicode: "e61b"))
                                    .font(.custom(CustomFonts.FABrandsRegular, size: 22))
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 4)
                                Text("X").foregroundColor(.black)
                                Spacer()
                                Text("@laughtaone")
                                    .foregroundColor(.gray)
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showX) {
                            SafariView(url: URL(string: "https://x.com/laughtaone/")!)
                        }
                        // - - - - - - - - - - - - - - - - - - -
                        // - - - - - - - AppStore - - - - - - - -
                        Button {
                            print("AppStoreボタンが押されたお")
                            showAppStore.toggle()
                        } label: {
                            HStack {
                                Text(String.FontAwesome(unicode: "f370"))
                                    .font(.custom(CustomFonts.FABrandsRegular, size: 22))
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 4)
                                Text("開発者 その他アプリ").foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showAppStore) {
                            SafariView(url: URL(string: "https://apps.apple.com/us/developer/taichi-usuba/id1798659459")!)
                        }
                        // - - - - - - - - - - - - - - - - - - -
                    }
                    // -------------------------------------------------------------------------------
                    
                    // ---------------------------------- アプリについて --------------------------------
                    Section(header: Text("アプリについて")) {
                        // - - - - - - - - 利用規約 - - - - - - - -
                        Button {
                            print("利用規約ボタンが押されたお")
                            showTermsOfService.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "text.document").foregroundColor(.gray)
                                Text("利用規約").foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showTermsOfService) {
                            SafariView(url: URL(string: "https://laughtaone.notion.site/okiben-Swift-1c2b5b9390818105bedff6564a185f55?pvs=4")!)
                        }
                        // - - - - - - - - - - - - - - - - - - -
                        // - - - - - プライバシーポリシー - - - - -
                        Button {
                            print("プライバシーポリシーボタンが押されたお")
                            showPrivacyPolicy.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "text.document").foregroundColor(.gray)
                                Text("プライバシーポリシー").foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showPrivacyPolicy) {
                            SafariView(url: URL(string: "https://laughtaone.notion.site/okiben-Swift-1c2b5b9390818105bedff6564a185f55?pvs=4")!)
                        }
                        // - - - - - - - - - - - - - - - - - - -
                        // - - - - - - 使用パッケージ - - - - - - -
                        Button {
                            print("使用パッケージボタンが押されたお")
                            showUsePackages.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "book.closed").foregroundColor(.gray)
                                Text("使用パッケージ").foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showUsePackages) {
                            SafariView(url: URL(string: "https://laughtaone.notion.site/okiben-Swift-1c2b5b9390818105bedff6564a185f55?pvs=4")!)
                        }
                        // - - - - - - - - - - - - - - - - - - -
                    }
                    // -------------------------------------------------------------------------------

                    
                    // --------------------------------- アプリバージョン -------------------------------
                    Section(header: Text("アプリバージョン")) {
                        Button {
                            print("アプリバージョンボタンが押されたお")
                            showAppVersion.toggle()
                        } label: {
                            HStack {
                                Image(systemName: "number").foregroundColor(.gray)
                                Text("アプリバージョン").foregroundColor(.black)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showAppVersion) {
                            SafariView(url: URL(string: "https://laughtaone.notion.site/okiben-Swift-1c2b5b9390818105bedff6564a185f55?pvs=4")!)
                        }
                    }
                    // -------------------------------------------------------------------------------
                }
            }
        )
    }
}







// ============================================= FontAwesome用 ==============================================
struct CustomFonts {
    static let FABrandsRegular = "FontAwesome6Brands-Regular"
    static let FAFreeRegular = "FontAwesome6Free-Regular"
    static let FAFreeSolid = "FontAwesome6Free-Solid"
}

extension String {
    static func FontAwesome(unicode: String) -> String {
        guard let unicode = Int(unicode, radix: 16) else { return String(format: "%C", 0x0000) }
        return String(format: "%C", unicode)
    }
}
// ==========================================================================================================


// =========================================== URLをアプリ内で開く ============================================
struct SafariView: View {
    let url: URL
    
    var body: some View {
        SafariViewControllerWrapper(url: url)
            .edgesIgnoringSafeArea(.all)
    }
}

import SafariServices

struct SafariViewControllerWrapper: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        return SFSafariViewController(url: url)
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Update the view controller if needed
    }
}
// ==========================================================================================================
