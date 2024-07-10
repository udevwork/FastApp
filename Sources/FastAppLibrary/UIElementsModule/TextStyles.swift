import Foundation
import SwiftUI

extension Text {
    /// Applies a style for main titles.
    /// Use this style for the primary headings on a page or in an app.
    func titleStyle() -> some View {
        self.font(.system(size: 29, weight: .bold, design: .rounded))
    }
    
    /// Applies a style for subtitles.
    /// Suitable for secondary headings or subtitles.
    func subtitleStyle() -> some View {
        self.font(.system(size: 28, weight: .semibold, design: .rounded))
    }
    
    /// Applies a style for body text.
    /// Use this style for the main content or longer text.
    func bodyStyle() -> some View {
        self.font(.system(size: 20, weight: .regular, design: .rounded))
    }
    
    /// Applies a style for captions.
    /// Ideal for small explanatory text or image captions.
    func captionStyle() -> some View {
        self.font(.system(size: 15, weight: .light, design: .rounded))
    }
    
    /// Applies a style for footnotes.
    /// Suitable for small notes or additional comments.
    func footnoteStyle() -> some View {
        self.font(.system(size: 13, weight: .thin, design: .rounded))
    }
    
    /// Applies a style for callouts.
    /// Good for highlighting important messages or quotes.
    func calloutStyle() -> some View {
        self.font(.system(size: 17, weight: .medium, design: .rounded))
    }
    
    /// Applies a style for headlines.
    /// Suitable for important headings that need to draw attention.
    func headlineStyle() -> some View {
        self.font(.system(size: 24, weight: .bold, design: .rounded))
    }
    
    /// Applies a style for subheadlines.
    /// Use this for subheadings that are less important than main headlines.
    func subheadlineStyle() -> some View {
        self.font(.system(size: 20, weight: .regular, design: .rounded))
    }
}

struct TextDesignView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Title").titleStyle()
            Text("Subtitle").subtitleStyle()
            Text("Headline text").headlineStyle()
            Text("Subheadline text").subheadlineStyle()
            Text("Callout text").calloutStyle()
            Text("Body text").bodyStyle()
            Text("Caption text").captionStyle()
            Text("Footnote text").footnoteStyle()
        }
        .padding(40)
    }
}

#Preview {
    TextDesignView()
}
