import SwiftUI

struct Loading: View {
    @State private var isVisible = false

    var body: some View {
        if isVisible {
            Spinner()
        } else {
            Spacer()
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        isVisible = true
                    }
                }
        }
    }
}

struct Loading_Previews: PreviewProvider {
    static var previews: some View {
        Loading()
            .previewLayout(.fixed(width: 200, height: 200))
    }
}
