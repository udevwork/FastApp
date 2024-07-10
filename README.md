# FastAppLibrary

### Описание
FastAppLibrary - это набор готовых к использованию компонентов SwiftUI для быстрой разработки iOS приложений. Пакет включает в себя готовые экраны, ui элементы и различные расширения в Apple-like дизайне c поддержкой разных размеров экранов, черной и светлой темы.

## Installation

Install package with SPM

```bash
  .package(url: "https://github.com/udevwork/FastApp.git", branch: "main")
```

## Setup

Вам нужно провести настройки для работы библиотеки

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

Добавте модификатор .fastAppDefaultWrapper() на ваш рутовый экран. Это нужно для корректной работы показа экранов и алертов

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

Для коректной работы настройте подписки вашего приложения в Appstore Connect и свяжите их с RevenueCat.
Далее, в RevenueCat, создайте один Offers. Подписок может быть сколько угодно, а так же содержать introductory offer в виде триала

Проверьте что вы заполнили paywallBenefits в стартовых настройках.

Документы Privacy и Terms генерируются налету, ничего добавлять не надо. Данные берутся из настроек которые вы сделали на страте приложения. Дополнительных настроек не требуется, кнопки показа просмотрщика и сам просмотщик работают из коробки.  

Для вызова пэйвола:

```swift
FastApp.subscriptions.showPaywallScreen()
```

Это сработает в любом месте. Можно вызывать как из View, так и из ViewModel, например.

Для отслеживания подписки пользователя @Published Bool переменная:

```swift
FastApp.subscriptions.isSubscribed
```
Обновлением этого поля полностью занимается FastApp, но если вам требуется дополнительно обновить его:  

```swift
FastApp.subscriptions.checkSubscriptionStatus()
```
Узнать дату окончания подписки:
```swift
FastApp.subscriptions.fetchExpirationDate()
```

## Onboarding

Онбординг берет данные из onboardingItems в настройках которые вы сделали на страте приложения. Он автоматически вызовется при первом запуске приложения, сам запомнит это и на следующих стартах показываться не будет.

## Alerts

В библиотеку вшиты различные алерты.
Пример вызова алерта:
```swift
FastApp.alerts.show(
        title: "Download",
        displayMode: .alert,
        type: .complete(.green),
        sdubTitle: "success!"
    )
```
Доступные типы: complete, error, systemImage, image, loading, regular, а так же кастомизация дизайна. 

## UI и Extension

В библиотеку добавлены кастомизируемые:
1. Улучшеный TextField с плейсхолдером и анимацией
2. Стили для Button() 
3. Бейджи
4. Горизотальная галлерея с любым контентом и пагинацией
5. Расширение для Color с большой палитрой адаптивных под тему цветов
6. Расширение Haptic для удобного использования
7. Удобный логгер, основанн на OSLog для возможности фильтровать их в консоли, выводом времени, класса, метода и строчки кода где он сработал. Поддерживает множество входных параметров + если из них есть структуры или объекты - будет распечатан дамп объектов.
8. Готовые стили для Text() от футера до заголовка
9. Видеоплеер с удобной настройка frame'а, зацикливанием и без кнопок управления. 
