struct CardBackgroundModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .background {
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray5))
            }
    }
}

extension View {
    var cardBackground: some View {
        modifier(CardBackgroundModifier())
    }
}