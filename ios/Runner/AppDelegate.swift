import UIKit
import Flutter
import BackgroundTasks

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
            let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
            let METHOD_CHANNEL_NAME = "com.ubenwa/damilare"
            let bkgdServiceChannel = FlutterMethodChannel(name: METHOD_CHANNEL_NAME, binaryMessenger: controller.binaryMessenger)
      
      
      bkgdServiceChannel.setMethodCallHandler({
            (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
            switch call.method {
              case "enableBackgroundService":
                  guard let args = call.arguments as? [String:String] else {return}
                  let token = args["token"]!
                result(self.createNewBorn(token:token))
          default:
                    result(FlutterMethodNotImplemented)
          }
      } )
      
    GeneratedPluginRegistrant.register(with: self)

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    
    func createNewBorn(token:String) {

       guard let url = URL(string: "https://ubenwa-cat-api-stage.herokuapp.com/api/v1/newborns") else {return}

let token = ""
       var request = URLRequest(url: url)
       request.httpMethod = "POST"
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let json: [String: Any] = ["type": "newborns",
                                   "attributes": [ "name": "Alake James", "gestation": "6", "gender": "male"]]

        let jsonData = try? JSONSerialization.data(withJSONObject: json)
        

             let task = URLSession.shared.dataTask(with: request) {(data, response, error) in
                 // Check For Errors
                 let errorRes = error


                 // Check HTTP Response
                 if let httpResponse = response as? HTTPURLResponse {
                     print("The Response Code is: \(httpResponse.statusCode)")
                 }

                 // Extract JSON From Request & Convert To Array or String Based On Nature of The JSON Response
                 var jsonResponseObject: Any? = nil
                 do {
                     if let data = data {
                         jsonResponseObject = try JSONSerialization.jsonObject(with: data, options: [])
                     }
                 } catch {
                 }

                 let jsonResponseObjectDictionary = jsonResponseObject as? [AnyHashable : Any]
                 print("DATAAA \(jsonResponseObjectDictionary)")
                 if(jsonResponseObjectDictionary != nil){
                     //                    adDictionaryManagement(jsonResponseObjectDictionary)
                 }else{
                     //                    adDictionaryManagement(jsonResponseObjectDictionary)
                print(errorRes)
                 }

             }

       task.resume()

   }

  
    
    
    override func applicationDidEnterBackground(_ application: UIApplication) {
        scheduleAppRefresh()
        // scheduleDatabaseCleaningIfNeeded()
    }
    
    func scheduleAppRefresh() {
        if #available(iOS 13.0, *) {
            let request = BGAppRefreshTaskRequest(identifier: "com.ubenwa/damilare")
            request.earliestBeginDate = Date(timeIntervalSinceNow: 10 * 60) // Fetch no earlier than 15 minutes from now
            do {
                try BGTaskScheduler.shared.submit(request)
            } catch {
                print("Could not schedule app refresh: \(error)")
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
    
    @available(iOS 13.0, *)
    func handleAppRefresh(task: BGAppRefreshTask) {
        scheduleAppRefresh()
        
        //                   let operation = RefreshAppContentsOperation()
        
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        
        task.expirationHandler = {
            // After all operations are cancelled, the completion block below is called to set the task to complete.
            queue.cancelAllOperations()
        }
        
        print("=================== HANDLER APP REFRESH CALLED ====================")
        
    }
    
    override func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

}








                   
//
