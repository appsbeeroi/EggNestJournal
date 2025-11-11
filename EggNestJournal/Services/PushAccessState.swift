import UserNotifications

enum PushAccessState {
    case granted
    case declined
    case notRequested
}

final class PushPermissionService {
    
    static let instance = PushPermissionService()
    
    private init() {}
    
    var status: PushAccessState {
        get async {
            let notificationCenter = UNUserNotificationCenter.current()
            let settings = await notificationCenter.notificationSettings()
            
            switch settings.authorizationStatus {
            case .authorized, .provisional:
                return .granted
            case .denied:
                return .declined
            case .notDetermined:
                return .notRequested
            default:
                return .declined
            }
        }
    }
    
    @discardableResult
    func askForPermission() async -> Bool {
        let notificationCenter = UNUserNotificationCenter.current()
        do {
            let isGranted = try await notificationCenter.requestAuthorization(
                options: [.alert, .sound, .badge]
            )
            return isGranted
        } catch {
            debugPrint("❌ Ошибка при запросе разрешения на уведомления: \(error)")
            return false
        }
    }
}
