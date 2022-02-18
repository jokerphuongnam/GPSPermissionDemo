import UIKit
import CoreLocation

class AuthenticationViewController: UIViewController {
    private let locationManager: CLLocationManager = AppDelegate.locationManager
    @IBOutlet fileprivate weak var agreeButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Permisstion"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        locationManager.delegate = self
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // chua cap quyen
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            fallthrough
        case .denied:
            // tu choi
            openAppInSetting()
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            // cho phep 1 lan
            // cho phep khi su dung ung dung
            fallthrough
        case .authorized:
            agreeButton.isEnabled = true
            presentMainViewController()
        default:
            break
        }
    }
    
    fileprivate func presentMainViewController() {
        let mainViewController = MainViewController()
        navigationController?.pushViewController(mainViewController, animated: true)
        navigationController?.viewControllers.removeFirst()
    }
    
    fileprivate func openAppInSetting() {
        var preferencePath: String
        if #available(iOS 11.0, *) {
            preferencePath = UIApplication.openSettingsURLString
        } else {
            preferencePath = "App-Prefs:root=General"
        }
        
        if let url = URL(string: preferencePath) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
}

// MARK: Button tap
extension AuthenticationViewController {
    @IBAction fileprivate func agreeHandle(_ sender: UIButton, forEvent event: UIEvent) {
        presentMainViewController()
    }
    
    @IBAction fileprivate func cancelHandle(_ sender: UIButton, forEvent event: UIEvent) {
        exit(0)
    }
}

// MARK: - CLLocationManagerDelegate
extension AuthenticationViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
            fallthrough
        case .denied:
            // tu choi
            openAppInSetting()
        case .authorizedAlways:
            fallthrough
        case .authorizedWhenInUse:
            // cho phep 1 lan
            // cho phep khi su dung ung dung
            fallthrough
        case .authorized:
            agreeButton.isEnabled = true
        default:
            break
        }
    }
}
