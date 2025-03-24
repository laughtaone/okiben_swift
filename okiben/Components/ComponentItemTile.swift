import SwiftUI

struct ComponentItemTile: View {
    var title: String
    var memo: String
    var value: Bool
    var onToggle: (Bool) -> Void

    var body: some View {
        VStack {
            Button(action: {
                print("ボタンが押されたお")
            }) {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(title)
                            .font(.system(size: 23, weight: .bold))
                            .lineLimit(1)
                            .truncationMode(.tail)
                            .foregroundColor(.black)

                        Text(memo)
                            .font(.system(size: 13))
                            .lineLimit(2)
                            .multilineTextAlignment(.leading)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Toggle("", isOn: .constant(value))
                        .labelsHidden()
                        .scaleEffect(1.3)
                        .onChange(of: value) { newValue in
                            onToggle(newValue)
                        }
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                .background(Color.gray.opacity(0.1))
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.5), lineWidth: 1)
                )
            }
            .frame(maxWidth: .infinity, minHeight: 95)
        }
    }
}

struct ComponentItemTile_Previews: PreviewProvider {
    static var previews: some View {
        ComponentItemTile(title: "Title", memo: "Memo text goes here", value: true, onToggle: { _ in })
            .previewLayout(.sizeThatFits)
    }
}
