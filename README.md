# FastAppLibrary

| ![FastAppLibrary github](https://img.shields.io/badge/Swift-5.9-orange.svg)             |   ![FastAppLibrary github](https://img.shields.io/badge/UI-SwiftUI-green.svg)                                                              |
| ----------------- | ------------------------------------------------------------------ |


### Description
FastAppLibrary is a set of ready-to-use SwiftUI components for rapid iOS application development. The package includes pre-made screens, UI elements, and various extensions in an Apple-like design, supporting different screen sizes, dark and light themes.

## Installation

Install the package with SPM:

```bash
  .package(url: "https://github.com/udevwork/FastApp.git", branch: "main")
```

## Setup

To work with the library, perform the following setup:

```swift
import FastAppLibrary

func application(didFinishLaunchingWithOptions) {
        
    let settings = FastAppSettings(
        appName: "APP NAME",
        companyName: "TEST COMPANY",
        companyEmail: "test@email.com",
        revenueCatAPI: "appl_wudhAj...MlggW",
        paywallBenefits: [
            .init(systemIcon: "message.circle.fill",
                  title: "Exclusive!",
                  subtitle: "Access to exclusive workouts")
        ],
        onboardingItems: [
            .init(image: "img", title: "Welcome", subTitle: "Discover new features")
        ]
    )
        
    FastApp.shared.setup(settings)
        
    ...
}

```

Add the modifier .fastAppDefaultWrapper() to your root screen. This is necessary for the correct display of screens and alerts:

```swift
@main
struct NoAlgoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().fastAppDefaultWrapper()
        }
    }
}

```

## Paywall

| ![SwiftUI Paywall github](https://github.com/udevwork/FastApp/blob/main/images/1.PNG?raw=true)             |  ![alt text](https://github.com/udevwork/FastApp/blob/main/images/2.PNG?raw=true)                                                           |
| ----------------- | ------------------------------------------------------------------ |


To ensure proper functionality, configure your app's subscriptions in App Store Connect and link them with RevenueCat. Then, create Offers in RevenueCat. There can be any number of subscriptions, including introductory offers like trials.

Make sure you have filled out the paywallBenefits in the initial settings.

Privacy and Terms documents are generated on the fly, no need to add anything extra. The data is taken from the settings you made at the app's start. No additional settings are required; the viewer buttons and the viewer itself work out of the box.

To call the paywall:

```swift
FastApp.subscriptions.showPaywallScreen()
```

This will work anywhere. It can be called from a View or ViewModel, for example.

To track user subscriptions, use the @Published Bool variable:

```swift
FastApp.subscriptions.isSubscribed
```
FastApp handles updating this field, but if you need to update it additionally:

```swift
FastApp.subscriptions.checkSubscriptionStatus()
```
To find out the subscription expiration date:

```swift
FastApp.subscriptions.fetchExpirationDate()
```

## Onboarding

![SwiftUI Onboarding github](https://github.com/udevwork/FastApp/blob/main/images/3.PNG?raw=true)

The onboarding takes data from onboardingItems in the settings you made at the start of the app. It will automatically be shown on the first launch of the app, remember this, and will not be shown on subsequent launches.

## Alerts

The library includes various alerts. Example of calling an alert:

```swift
FastApp.alerts.show(
        title: "Download",
        displayMode: .alert,
        type: .complete(.green),
        sdubTitle: "success!"
    )
```
Available types: complete, error, systemImage, image, loading, regular, and custom design.

## UI и Extension

The library includes customizable:

1. Enhanced TextField with placeholder and animation.

![SwiftUI reusable ui github](https://github.com/udevwork/FastApp/blob/main/images/6.png?raw=true)

```swift
FloatingTextField(text: $text, placehopder: "Enter name")
```

2. Button styles with 11 built-in colors.

![SwiftUI buttons github](https://github.com/udevwork/FastApp/blob/main/images/4.png?raw=true)

```swift
Button(action: {}, label: {
    Text("Success")
}).buttonStyle(LargeButtonStyle(color: .success))
```

3. Badges.

![SwiftUI bages github](https://github.com/udevwork/FastApp/blob/main/images/7.png?raw=true)

```swift
Text("green").coloredBageStyle(color: .green)
```

4. Horizontal gallery with any content and pagination.

![SwiftUI gallery github](https://github.com/udevwork/FastApp/blob/main/images/8.png?raw=true)

```swift
HorizontalSnapGalleryView(data: $data, content: { currentData in
    ZStack {
        Rectangle().foregroundStyle(Color.blue.gradient)
        Text("\(currentData.text)")
            .titleStyle()
            .foregroundStyle(.white)
        
    }
})
```

5. Color extension with 36 adaptive colors for themes.

![SwiftUI Color extension github](https://github.com/udevwork/FastApp/blob/main/images/5.png?raw=true)

```swift
Color.systemGray3
Color.systemBackground
Color.systemTeal
...
```

6. Haptic extension for convenient use.

```swift
Haptic.impact()
Haptic.impact(style: .heavy)
Haptic.notify(style: .success)
Haptic.selection()
```

7. Convenient logger based on OSLog to filter in the console, displaying time, class, method, and line of code where it worked. Supports many input parameters, and if there are structures or objects among them, a dump of the objects will be printed.

```swift
log(.Error, subscriptions.isSubscribed, "log test", ObjectDTO())
```

8. 8 ready-made styles for Text() from title to footer.

```swift
Text("Title").titleStyle()
Text("Subtitle").subtitleStyle()
Text("Headline text").headlineStyle()
Text("Subheadline text").subheadlineStyle()
            ...
```

9. Video player with easy frame setting, looping, and without control buttons.ё

```swift
LoopPlayerView {
    Settings {
        FileName("videoBG4")
        Ext("mov")
        Gravity(.resizeAspectFill)
    }
}
.frame(height: 70)
.saturation(3.0)
.brightness(0.20)
.mask(
    Text("0.1lab")
        .font(.system(size: 75, weight: .black, design: .default))
        .multilineTextAlignment(.leading)
)
```
