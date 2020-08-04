import SwiftUI

struct Spinner: View {
    @State private var isAnimating = false

    var body: some View {
        Circle()
            .strokeBorder(
                AngularGradient(
                    gradient:
                        Gradient(stops: [
                            .init(color: .accentColor, location: 0),
                            .init(color: .clear, location: 0.7),
                        ]),
                    center: .center,
                    startAngle: .degrees(-90),
                    endAngle: .degrees(-450)
                ),
                lineWidth: 8)
            .rotationEffect(.degrees(isAnimating ? 360 : 0))
            .animation(Animation.linear
                        .repeatForever(autoreverses: false)
                        .speed(0.5))
            .frame(maxWidth: 60, maxHeight: 60)
            .onAppear { isAnimating = true }
            .onDisappear { isAnimating = false }
    }
}

struct Spinner_Previews: PreviewProvider {
    static var previews: some View {
        Spinner()
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
