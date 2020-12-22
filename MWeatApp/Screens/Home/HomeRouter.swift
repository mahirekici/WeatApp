
import UIKit
import WeatNetwork


protocol Routerable {
    func makeViewController() -> UIViewController
}

protocol HomeRouterProtocol: AnyObject {
    func navigateToWeekScene(model: WeatherSearchCityModel)
}

final class HomeRouter: Routerable {
    private var navigation: UINavigationController
    
    init(navigation: UINavigationController) {
        self.navigation = navigation
    }
    
    func makeViewController() -> UIViewController {
        let presenter = HomePresenter(router: self)
        let viewController = HomeViewController(presenter: presenter)
        return viewController
    }
}

extension HomeRouter: HomeRouterProtocol {
    func navigateToWeekScene(model: WeatherSearchCityModel) {
        
        let router = WeekdayRouter(navigation: navigation, search: model)
        let vc = router.makeViewController()
        navigation.pushViewController(vc, animated: true)
    }
}
