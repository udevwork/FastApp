import SwiftUI

public struct HorizontalSnapGalleryView<Data, Content>: View where Data : RandomAccessCollection, Content: View, Data.Element : Identifiable {
   
    var containerWidth:CGFloat = UIScreen.main.bounds.width
    var galleryHeight:CGFloat
    var elementSpacing: CGFloat
    var elemetsEgesOffes: CGFloat
    @Binding var data: Data
    let content: (Data.Element) -> Content
    
    public init(
        containerWidth:CGFloat = UIScreen.main.bounds.width,
        galleryHeight:CGFloat = 150,
        elementSpacing: CGFloat = 20,
        elemetsEgesOffes: CGFloat = 40,
        data: Binding<Data>,
        content: @escaping (Data.Element) -> Content
    ) {
        self.content = content
        self._data = data
        self.containerWidth = containerWidth
        self.galleryHeight = galleryHeight
        self.elementSpacing = elementSpacing
        self.elemetsEgesOffes = elemetsEgesOffes
    }
    
    public var body: some View {
        ScrollView(.horizontal) {
            
            LazyHStack(spacing: elementSpacing) {
                ForEach(data) { element in
                    content(element)
                }
                .frame(width: containerWidth - elemetsEgesOffes*2)
                .frame(height: galleryHeight)
                //.clipShape(RoundedRectangle(cornerRadius: 10))
            }
            .scrollTargetLayout()
        }
        .scrollTargetBehavior(.viewAligned)
        .scrollIndicators(.never)
        .safeAreaPadding(.horizontal, elemetsEgesOffes)
        .frame(height: galleryHeight)
    }
}

struct HorizontalSnapGalleryViewTestItem: Identifiable {
    var id = UUID()
    var text: String
}

#Preview {
    
    @State var data:[HorizontalSnapGalleryViewTestItem] = [
        .init(text: "one"),
        .init(text: "two"),
        .init(text: "hello")
    ]
    
    return 
    HorizontalSnapGalleryView(data: $data, content: { currentdata in
        ZStack {
            Rectangle().foregroundStyle(Color.blue.gradient)
            Text("\(currentdata.text)")
                .titleStyle()
                .foregroundStyle(.white)
            
        }
    })
}
