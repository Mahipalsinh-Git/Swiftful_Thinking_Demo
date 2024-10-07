//
//  11_Local_Push_Notification.swift
//  ContinuedLearning
//
//  Created by Codzgarage on 10/7/24.
//

import SwiftUI
import UserNotifications
import CoreLocation

class NotificationManager {
    static let instance = NotificationManager() // Singleton
    var manager = CLLocationManager()

    func requestAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in

            if let error = error {
                print("Error: \(error)")
            } else {
                print("Success")
            }
        }
    }

    func checkLocationAuthorization() {

//        manager.delegate = self
//        manager.startUpdatingLocation()

        switch manager.authorizationStatus {
            case .notDetermined://The user choose allow or denny your app to get the location yet
                manager.requestWhenInUseAuthorization()
            case .restricted://The user cannot change this app’s status, possibly due to active restrictions such as parental controls being in place.
                print("Location restricted")
            case .denied://The user dennied your app to get location or disabled the services location or the phone is in airplane mode
                print("Location denied")

            case .authorizedAlways://This authorization allows you to use all location services and receive location events whether or not your app is in use.
                print("Location authorizedAlways")

            case .authorizedWhenInUse://This authorization allows you to use all location services and receive location events only when your app is in use
                print("Location authorized when in use")
            @unknown default:
                print("Location service disabled")

        }
    }

    func scheduleTimeNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Time notification"
        content.subtitle = "Time notification demo"
        content.sound = .default
        content.badge = 1

        // Trigger type
        // 1. Time
        let timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: timeTrigger)

        UNUserNotificationCenter.current().add(request)
    }

    func scheduleCalendarNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Calendar notification"
        content.subtitle = "Calendar notification demo"
        content.sound = .default
        content.badge = 2

        var dateComponents = DateComponents()
        dateComponents.hour = 12
        dateComponents.minute = 50

        // 2. Calendar
        let calendarTrigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: calendarTrigger)

        UNUserNotificationCenter.current().add(request)
    }

    func scheduleLocationNotification() {
        
//        checkLocationAuthorization()

        let content = UNMutableNotificationContent()
        content.title = "Location notification"
        content.subtitle = "Location notification demo"
        content.sound = .default
        content.badge = 3

        // 3. Location
        let coordinates = CLLocationCoordinate2D(latitude: 37.33445,
                                                 longitude: 122.04521)

        let region = CLCircularRegion(center: coordinates,
                                      radius: 50,
                                      identifier: UUID().uuidString)
        region.notifyOnEntry = true
        region.notifyOnExit = true

        let locationTrigger = UNLocationNotificationTrigger(region: region, repeats: false)
        let request = UNNotificationRequest(identifier: UUID().uuidString,
                                            content: content,
                                            trigger: locationTrigger)

        UNUserNotificationCenter.current().add(request)
    }

    func cancelNotificaion() {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
}

struct LocalPushNotificationDemo: View {
    var body: some View {
        VStack(spacing: 40) {
            Button("Request permission") {
                NotificationManager.instance.requestAuthorization()
            }

            Divider()

            Button("Time notification") {
                NotificationManager.instance.scheduleTimeNotification()
            }

            Button("Schedule notification") {
                NotificationManager.instance.scheduleCalendarNotification()
            }

            Button("Location notification") {
                NotificationManager.instance.scheduleLocationNotification()
            }

            Button("Cancle notification") {
                NotificationManager.instance.cancelNotificaion()
            }
        }
    }
}

#Preview {
    LocalPushNotificationDemo()
}
