import UIKit
import Flutter
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GMSServices.provideAPIKey("AIzaSyALnXNt9HZ34XlN5Qg9eOKu1aDYHOvkm5U")
    GeneratedPluginRegistrant.register(with: self)
    
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
