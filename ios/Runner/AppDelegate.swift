import Flutter
import GoogleMaps
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
  /// Same channel as Android's FLAG_SECURE (lib/core/security/screen_security.dart).
  private let securityChannelName = "com.malabak.app/security"

  /// True while a sensitive screen (receipt upload, deposit details,
  /// sessions) is open.
  private var secureEnabled = false
  private var privacyCover: UIView?

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    // The key comes from ios/Flutter/Secrets.xcconfig, which is not in git.
    if let key = Bundle.main.object(forInfoDictionaryKey: "GMSApiKey") as? String, !key.isEmpty {
      GMSServices.provideAPIKey(key)
    }
    GeneratedPluginRegistrant.register(with: self)
    registerScreenSecurityChannel()
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: - Screen security
  //
  // iOS has no FLAG_SECURE: a screenshot cannot be blocked. While a sensitive
  // screen is open the app instead hides its content from the app switcher
  // snapshot and from screen recording / mirroring.

  private func registerScreenSecurityChannel() {
    guard let registrar = self.registrar(forPlugin: "MalabakScreenSecurity") else { return }
    let channel = FlutterMethodChannel(
      name: securityChannelName,
      binaryMessenger: registrar.messenger()
    )
    channel.setMethodCallHandler { [weak self] call, result in
      guard call.method == "setSecure" else {
        result(FlutterMethodNotImplemented)
        return
      }
      let arguments = call.arguments as? [String: Any]
      self?.setSecure(arguments?["secure"] as? Bool ?? false)
      result(true)
    }
    NotificationCenter.default.addObserver(
      self,
      selector: #selector(screenCaptureChanged),
      name: UIScreen.capturedDidChangeNotification,
      object: nil
    )
  }

  private func setSecure(_ secure: Bool) {
    secureEnabled = secure
    if secure && UIScreen.main.isCaptured {
      showPrivacyCover()
    } else if !secure {
      hidePrivacyCover()
    }
  }

  @objc private func screenCaptureChanged() {
    if secureEnabled && UIScreen.main.isCaptured {
      showPrivacyCover()
    } else {
      hidePrivacyCover()
    }
  }

  override func applicationWillResignActive(_ application: UIApplication) {
    super.applicationWillResignActive(application)
    if secureEnabled {
      showPrivacyCover()
    }
  }

  override func applicationDidBecomeActive(_ application: UIApplication) {
    super.applicationDidBecomeActive(application)
    if !(secureEnabled && UIScreen.main.isCaptured) {
      hidePrivacyCover()
    }
  }

  private func showPrivacyCover() {
    guard privacyCover == nil, let window = self.window else { return }
    let cover = UIVisualEffectView(effect: UIBlurEffect(style: .systemThickMaterialDark))
    cover.frame = window.bounds
    cover.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    window.addSubview(cover)
    privacyCover = cover
  }

  private func hidePrivacyCover() {
    privacyCover?.removeFromSuperview()
    privacyCover = nil
  }
}
