import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Make window work again (in a completelly different place and with a lot more code)
        //
        // https://www.reddit.com/r/hackingwithswift/comments/cdfbcd/project_7_missing_window_variable_in_appdelegate/

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.windowScene = windowScene

        let storyboard = UIStoryboard(name: "Main", bundle: nil)

        let tabBarViewController = storyboard.instantiateViewController(withIdentifier: "TabBarController")
        window?.rootViewController = tabBarViewController

        let navViewController = storyboard.instantiateViewController(withIdentifier: "NavController")
        navViewController.tabBarItem = UITabBarItem(tabBarSystemItem: .topRated, tag: 1)

        guard let tabBarController = window?.rootViewController as? UITabBarController else { return }
        tabBarController.viewControllers?.append(navViewController)

        window?.makeKeyAndVisible()
    }
}
