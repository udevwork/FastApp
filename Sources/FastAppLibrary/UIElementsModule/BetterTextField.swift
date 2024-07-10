import SwiftUI

struct FloatingPromptScaleKey: EnvironmentKey {
    static var defaultValue: Double = 0.65
}

struct FloatingPromptSpacingKey: EnvironmentKey {
    static var defaultValue: Double = 5
}

struct PromptLeadingMarginKey: EnvironmentKey {
    static var defaultValue: Double = 0
}

struct AnimateFloatingPromptHeightKey: EnvironmentKey {
    static var defaultValue = false
}

extension EnvironmentValues {
    
    var floatingPromptScale: Double {
        get { self[FloatingPromptScaleKey.self] }
        set { self[FloatingPromptScaleKey.self] = newValue }
    }
    
    var promptLeadingMargin: Double {
        get { self[PromptLeadingMarginKey.self] }
        set { self[PromptLeadingMarginKey.self] = newValue }
    }
    
    var floatingPromptSpacing: Double {
        get { self[FloatingPromptSpacingKey.self] }
        set { self[FloatingPromptSpacingKey.self] = newValue }
    }
    
    var animateFloatingPromptHeight: Bool {
        get { self[AnimateFloatingPromptHeightKey.self] }
        set { self[AnimateFloatingPromptHeightKey.self] = newValue }
    }
}

/// A text input control with a prompt that moves or "floats" when it
/// becomes focused, and for as long as the input text is not empty.
 struct FloatingPromptTextField<Prompt: View, FloatingPrompt: View, TextFieldStyle: ShapeStyle>: View {
    
    enum PromptState {
        case normal
        case floating
    }
    
    @FocusState var isFocused: Bool
    
    private var text: Binding<String>
    private let textFieldStyle: TextFieldStyle
    private let prompt: Prompt
    private let floatingPrompt: FloatingPrompt
    
    @Environment(\.floatingPromptScale) var floatingPromptScale
    @Environment(\.floatingPromptSpacing) var floatingPromptSpacing
    @Environment(\.promptLeadingMargin) var promptLeadingMargin
    @Environment(\.animateFloatingPromptHeight) var animateFloatingPromptHeight
    
    @State private var promptState: PromptState
    @State private var promptHeight: Double = 0
    
    private var floatingOffset: Double { floatingPromptSpacing + promptHeight * floatingPromptScale }
    private var topMargin: Double { animateFloatingPromptHeight && promptState == .normal ? 0 : floatingOffset }
    
    fileprivate init(text: Binding<String>,
                     textFieldStyle: TextFieldStyle,
                     @ViewBuilder prompt: () -> Prompt,
                     @ViewBuilder floatingPrompt: () -> FloatingPrompt) {
        self.text = text
        self.prompt = prompt()
        self.floatingPrompt = floatingPrompt()
        
        self.textFieldStyle = textFieldStyle
        
        _promptState = State(initialValue: text.wrappedValue.isEmpty ? .normal : .floating)
    }
    
     var body: some View {
        ZStack(alignment: .leading) {
            TextField("", text: text)
                .foregroundStyle(textFieldStyle)
                .focused($isFocused)
            ZStack(alignment: .leading) {
                prompt
                    .opacity(promptState == .normal ? 1 : 0)
                floatingPrompt
                    .background(
                        GeometryReader { proxy in
                            Color.clear
                                .preference(key: HeightPreferenceKey.self, value: proxy.size.height)
                        }
                    )
                    .opacity(promptState == .floating ? 1 : 0)
            }
            .padding(.leading, promptLeadingMargin)
            .scaleEffect(promptState == .floating ? floatingPromptScale : 1, anchor: .topLeading)
            .offset(x: 0, y: promptState == .floating ? -floatingOffset : 0)
        }
        .padding(.top, topMargin)
        .onChange(of: text.wrappedValue) { updateState() }
        .onChange(of: isFocused) { updateState() }
        .onPreferenceChange(HeightPreferenceKey.self) { height in
            promptHeight = height
        }
        .onTapGesture { isFocused = true }
        .accessibilityRepresentation {
            TextField(text: text, prompt: nil) {
                switch promptState {
                case .normal:
                    prompt
                case .floating:
                    floatingPrompt
                }
            }
        }
    }
    
    func updateState() {
        withAnimation {
            promptState = (!text.wrappedValue.isEmpty || isFocused) ? .floating : .normal
        }
    }
}

extension FloatingPromptTextField where TextFieldStyle == HierarchicalShapeStyle {
    init(text: Binding<String>,
         @ViewBuilder prompt: () -> Prompt,
         @ViewBuilder floatingPrompt: () -> FloatingPrompt) {
        self.init(text: text,
                  textFieldStyle: .primary,
                  prompt: prompt,
                  floatingPrompt: floatingPrompt)
    }
}

extension FloatingPromptTextField where Prompt == FloatingPrompt {
    init(text: Binding<String>,
         textFieldStyle: TextFieldStyle,
         @ViewBuilder prompt: () -> Prompt) {
        self.init(text: text,
                  textFieldStyle: textFieldStyle,
                  prompt: prompt,
                  floatingPrompt: prompt)
    }
}

extension FloatingPromptTextField where TextFieldStyle == HierarchicalShapeStyle, Prompt == FloatingPrompt {
    /// Creates a FloatingPromptTextField with a string binding and a view that will be used
    /// as the prompt.
    ///
    /// - Parameters:
    ///   - text: A binding to the text to display and edit.
    ///   - prompt: A view that will be used as a prompt when the text field
    ///   is empty, and as a floating prompt when it's focused or not empty,
    init(text: Binding<String>,
         @ViewBuilder prompt: () -> Prompt) {
        self.init(text: text,
                  textFieldStyle: .primary,
                  prompt: prompt,
                  floatingPrompt: prompt)
    }
}

extension FloatingPromptTextField where TextFieldStyle == HierarchicalShapeStyle, Prompt == Text, FloatingPrompt == Text {
    /// Creates a FloatingPromptTextField with a string binding and a Text view that will be
    /// used as the prompt.
    ///
    /// - Parameters:
    ///   - text: A binding to the text to display and edit.
    ///   - prompt: A Text view that will be used as a prompt when the text field
    ///   is empty, and as a floating prompt when it's focused or not empty.
    init(text: Binding<String>, prompt: Text) {
        self.init(text: text,
                  textFieldStyle: .primary,
                  prompt: { prompt.foregroundColor(.secondary) },
                  floatingPrompt: { prompt.foregroundColor(.accentColor) })
    }
}

extension FloatingPromptTextField {
    /// A `View` to be used as the floating prompt when the text field is focused
    /// or not empty.
    ///
    /// - Parameter floatingPrompt: The view that will be used as the floating
    /// prompt when the text field is focused or not empty.
    func floatingPrompt<FloatingPromptType: View>(_ floatingPrompt: () -> FloatingPromptType) -> FloatingPromptTextField<Prompt, FloatingPromptType, TextFieldStyle> {
        FloatingPromptTextField<Prompt, FloatingPromptType, TextFieldStyle>(
            text: text,
            textFieldStyle: textFieldStyle,
            prompt: { prompt },
            floatingPrompt: { floatingPrompt() }
        )
    }
    
    /// Sets the style for the text field. You can use this to set the color of the
    /// text in the text field.
    func textFieldForegroundStyle<Style: ShapeStyle>(_ style: Style) -> FloatingPromptTextField<Prompt, FloatingPrompt, Style> {
        FloatingPromptTextField<Prompt, FloatingPrompt, Style>(
            text: text,
            textFieldStyle: style,
            prompt: { prompt },
            floatingPrompt: { floatingPrompt }
        )
    }
}

struct HeightPreferenceKey: PreferenceKey {
    static let defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}

extension View {
    /// Sets the scale at which the prompt will be displayed when floating
    /// over the text field.
    func floatingPromptScale(_ scale: Double) -> some View {
        environment(\.floatingPromptScale, scale)
    }
    
    /// Sets the spacing between the floating prompt and the text field.
    func floatingPromptSpacing(_ spacing: Double) -> some View {
        environment(\.floatingPromptSpacing, spacing)
    }
    
    /// Sets the leading margin for the prompt in both floating and regular states
    func promptLeadingMargin(_ margin: Double) -> some View {
        environment(\.promptLeadingMargin, margin)
    }
    
    /// Sets whether or not the view will animate its height to accommodate the
    /// floating prompt, or if the height of the floating prompt will
    /// always be calculated into the height's view.
    func animateFloatingPromptHeight(_ animate: Bool) -> some View {
        environment(\.animateFloatingPromptHeight, animate)
    }
}


public struct FloatingTextField: View {

    @Binding public var text: String
    public var placehopder: String

    public init(text: Binding<String>, placehopder: String) {
        self._text = text
        self.placehopder = placehopder
    }
    
    public var body: some View {
        FloatingPromptTextField(text: $text, prompt: Text(placehopder))
            .textFieldForegroundStyle(Color.label)
        //                .floatingPrompt {
        //                    Label("Name:", systemImage: "pencil.circle.fill")
        //                        .foregroundStyle(Color.blue)
        //                }
            .floatingPromptSpacing(10)
            .floatingPromptScale(0.8)
            .animateFloatingPromptHeight(true)
            .padding()
            .background(Color.systemGray6)
            .clipShape(RoundedRectangle(cornerRadius: 14))
    }
}

#Preview {
    @State var text = ""
    return FloatingTextField(text: $text, placehopder: "Enter name")
}
