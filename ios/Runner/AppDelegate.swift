import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
          UIApplication.shared.setMinimumBackgroundFetchInterval(TimeInterval(10*60))
            let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
            let METHOD_CHANNEL_NAME = "com.ubenwa/damilare"
            let backgroundServiceChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
            
            
            backgroundServiceChannel.setMethodCallHandler({
                  (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                  switch call.method {
                    case "enableBackgroundService":
                        guard let args = call.arguments as? [String:String] else {return}
                        let token = args["token"]!
                      result(self.createNewBorn(token))
                default:
                          result(FlutterMethodNotImplemented)
                }
      
            })
      
      
    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }




private func createNewBorn(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    
    let accessToken =  token
    guard let url = URL(string: "https://ubenwa-cat-api-stage.herokuapp.com/api/v1/newborns") else {return}
        
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
    request.httpBody = try JSONEncoder.encode().encode( "data": {
          "type": "newborns",
          "attributes": {
            "name": "Alake James",
            "gestation": "6",
            "gender": "male"
          }
        })

    
   
 
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data else {
            completionHandler(.noData)
            return
        }
        guard let info = String(data: data, encoding: .utf8) else {
            completionHandler(.failed)
            return
        }
        let content = UNMutableNotificationContent()
        content.title = "Update!"
        content.body = info

        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)

        let request = UNNotificationRequest(identifier: "UpdateNotification", content: content, trigger: trigger)
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error : Error?) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        completionHandler(.newData)
    }
    
    task.resume()

}

}
