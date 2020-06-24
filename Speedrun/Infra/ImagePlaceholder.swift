import SwiftUI

struct ImagePlaceholder: View {
    var body: some View {
        Image(systemName: "photo")
            .font(.system(size: 40))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .foregroundColor(Color(white: 0.4))
            .background(Color(white: 0.8))
            .cornerRadius(8)
    }
}

struct ImagePlaceholder_Previews: PreviewProvider {
    static var previews: some View {
        List {
            HStack {
                ImagePlaceholder()
                    .aspectRatio(1.0, contentMode: .fit)
                    .frame(width: 80)
                Text("Link's Awakening (2019)")
                    .font(.headline)
            }
        }
    }
}
