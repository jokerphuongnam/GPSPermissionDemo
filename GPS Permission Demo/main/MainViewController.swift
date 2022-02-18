import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Main"
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
    }
    
    @IBAction fileprivate func cancelHandle(_ sender: UIButton, forEvent event: UIEvent) {
        if navigationController?.popViewController(animated: true) == nil {
            exit(0)
        }
    }
}
