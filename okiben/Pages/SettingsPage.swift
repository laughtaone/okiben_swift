import SwiftUI

struct SettingsPage: View {
    // ================================================== 変数類 =================================================
    var argIsOnPressed: () -> Void
    @State private var isDarkMode = false
    @State private var notificationsEnabled = true
    @State private var selectedLanguage = "日本語"
    let languages = ["日本語", "English", "Español"]
    
//    @State private var nowDisplayMode = "system"
//    let displayModeList = ["system", "light", "dark"]
    @AppStorage("appearanceMode") private var nowDisplayMode = "system"
    let displayModeList = ["system", "light", "dark"]
    
    
    @State private var showGitHub = false
    @State private var showX = false
    @State private var showAppStore = false
    @State private var showBugReportForm = false
    @State private var showOtherReportForm = false
    @State private var showTermsOfService = false
    @State private var showPrivacyPolicy = false
    @State private var showUsePackages = false
    @State private var showAppVersion = false
    
    @State private var isDisplayAllDeleteDialog = false
    @State private var isUnlockedAllDelete = false
    
    let feedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    
    var argListClear: () -> Void
    
    var isLightMode: Bool
    let betweenIconTextSpacing: CGFloat = 12
    // ==========================================================================================================
    

    var body: some View {
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
                        HStack(spacing: 10) {
                            Image(systemName: "sun.max")
                            Picker("外観モード", selection: $nowDisplayMode) {
                                ForEach(displayModeList, id: \.self) { displayMode in
                                    Text(displayModeText(displayMode)).tag(displayMode)
                                }
                            }
                            .pickerStyle(MenuPickerStyle())
                            .onChange(of: nowDisplayMode) {
                                applyAppearanceMode(nowDisplayMode)
                            }
                        }
                    }
                    .onAppear {
                        applyAppearanceMode(nowDisplayMode)
                    }
                    // -------------------------------------------------------------------------------
                    
                    // ---------------------------------- アプリ使い方 ---------------------------------
                    Section(header: Text("このアプリの使い方")) {
                        HStack(alignment: .top, spacing: betweenIconTextSpacing) {
                            Image(systemName: "1.square")
                                .padding(.top, 2)
                            Text("アイテムを「置き勉管理」タブの右下の+ボタンから追加します")
                        }
                        HStack(alignment: .top, spacing: betweenIconTextSpacing) {
                            Image(systemName: "2.square")
                                .padding(.top, 2)
                                .foregroundColor(.primary)
                            VStack(alignment: .leading) {
                                Text("追加したアイテムを")
                                Toggle("・置き勉したら", isOn: .constant(true))
                                Toggle("・置き勉しなかったら", isOn: .constant(false))
                                Text("にします")
                            }
                        }
                        HStack(alignment: .top, spacing: betweenIconTextSpacing) {
                            Image(systemName: "3.square")
                                .padding(.top, 2)
                                .foregroundColor(.primary)
                            Text("各アイテムをタップすると「編集」「メモ」「削除」の操作ができます")
                        }
                        HStack(alignment: .top, spacing: betweenIconTextSpacing) {
                            Image(systemName: "4.square")
                                .padding(.top, 2)
                                .foregroundColor(.primary)
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
                            HStack(spacing: betweenIconTextSpacing) {
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
                                            onPressed: (isUnlockedAllDelete)
                                                ? {
                                                    print("完全に削除ボタンが押されました")
                                                    argListClear()
                                                    isDisplayAllDeleteDialog = false
                                                }
                                                : nil,
                                            customButtonColor: (isUnlockedAllDelete)
                                                ? Color(red: 230/255, green: 100/255, blue: 100/255)
                                                : Color(red: 250/255, green: 200/255, blue: 200/255),
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
                                            .foregroundColor((isLightMode) ? Color.black : Color.white).opacity((isUnlockedAllDelete) ? 0.2 : 1)
                                            .padding(10)
                                            .background((isUnlockedAllDelete)
                                                ? (isLightMode)
                                                    ? Color(red: 251/255, green: 251/255, blue: 251/255)
                                                    : Color(red: 50/255, green: 50/255, blue: 50/255)
                                                : (isLightMode)
                                                    ? Color(red: 224/255, green: 224/255, blue: 224/255)
                                                    : Color(red: 115/255, green: 115/255, blue: 115/255)
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
                                },
                                isLightMode: isLightMode
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
                            HStack(spacing: betweenIconTextSpacing) {
                                Text(String.FontAwesome(unicode: "f09b"))
                                    .font(.custom(CustomFonts.FABrandsRegular, size: 22))
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 4)
                                Text("GitHub").foregroundColor(.primary)
                                Spacer()
                                Text("@laughtaone").foregroundColor(.gray)
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
                            HStack(spacing: betweenIconTextSpacing) {
                                Text(String.FontAwesome(unicode: "e61b"))
                                    .font(.custom(CustomFonts.FABrandsRegular, size: 22))
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 4)
                                Text("X").foregroundColor(.primary)
                                Spacer()
                                Text("@laughtaone").foregroundColor(.gray)
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
                            HStack(spacing: betweenIconTextSpacing) {
                                Text(String.FontAwesome(unicode: "f370"))
                                    .font(.custom(CustomFonts.FABrandsRegular, size: 22))
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 4)
                                Text("開発者 その他アプリ").foregroundColor(.primary)
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
                    
                    // ----------------------------------- 報告フォーム ---------------------------------
                    Section(header: Text("報告フォーム")) {
                        // - - - - - - - - バグ報告 - - - - - - - -
                        Button {
                            showBugReportForm.toggle()
                        } label: {
                            HStack(spacing: betweenIconTextSpacing) {
                                Image(systemName: "ladybug").foregroundColor(.gray)
                                Text("バグ報告フォーム").foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showBugReportForm) {
                            SafariView(url: URL(string: "https://forms.gle/EmXnYPVgnmDq5nwe8")!)
                        }
                        // - - - - - - - - - - - - - - - - - - - -
                        // - - - - - - - - その他報告 - - - - - - - -
                        Button {
                            showOtherReportForm.toggle()
                        } label: {
                            HStack(spacing: betweenIconTextSpacing) {
                                Image(systemName: "paperplane").foregroundColor(.gray)
                                Text("その他報告・お問い合わせ").foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showOtherReportForm) {
                            SafariView(url: URL(string: "https://forms.gle/FSJocHE4cvE3LPkF8")!)
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
                            HStack(spacing: betweenIconTextSpacing) {
                                Image(systemName: "text.document").foregroundColor(.gray)
                                Text("利用規約").foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showTermsOfService) {
                            SafariView(url: URL(string: "https://laughtaone.notion.site/okiben-1b0b5b93908181ff9708cf490a5226ed?pvs=4")!)
                        }
                        // - - - - - - - - - - - - - - - - - - -
                        // - - - - - プライバシーポリシー - - - - -
                        Button {
                            print("プライバシーポリシーボタンが押されたお")
                            showPrivacyPolicy.toggle()
                        } label: {
                            HStack(spacing: betweenIconTextSpacing) {
                                Image(systemName: "text.document").foregroundColor(.gray)
                                Text("プライバシーポリシー").foregroundColor(.primary)
                                Spacer()
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showPrivacyPolicy) {
                            SafariView(url: URL(string: "https://laughtaone.notion.site/okiben-1b0b5b93908181f983eaff351ba2d06b?pvs=4")!)
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
                            HStack(spacing: betweenIconTextSpacing) {
                                Image(systemName: "number").foregroundColor(.gray)
                                Text("アプリバージョン").foregroundColor(.primary)
                                Spacer()
                                Text("1.1").foregroundColor(.gray)
                                Image(systemName: "chevron.forward").foregroundColor(.gray)
                            }
                        }
                        .sheet(isPresented: $showAppVersion) {
                            SafariView(url: URL(string: "https://laughtaone.notion.site/okiben-1b0b5b93908181d0b8e7e7d71066e384?pvs=4")!)
                        }
                    }
                    // -------------------------------------------------------------------------------
                }
            },
            isLightMode: isLightMode
        )
    }
    
    
    // ============================================= 外観モードの変更 =============================================
    // 表示するテキストを返す
    private func displayModeText(_ mode: String) -> String {
        switch mode {
        case "system": return "端末に合わせる"
        case "light": return "ライトモード"
        case "dark": return "ダークモード"
        default: return "不明"
        }
    }

    // 外観モードを適用
    private func applyAppearanceMode(_ mode: String) {
        guard let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = scene.windows.first else { return }

        // 外観モードを保存
        UserDefaults.standard.set(mode, forKey: "appearanceMode")

        switch mode {
        case "light":
            window.overrideUserInterfaceStyle = .light
        case "dark":
            window.overrideUserInterfaceStyle = .dark
        default:
            window.overrideUserInterfaceStyle = .unspecified
        }
    }

    // ==========================================================================================================
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

