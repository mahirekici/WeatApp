
public protocol WeekDayNetworkServiceProtocol {
    var delegate: WeekdayDataServiceDelegate? { get set }
    func getWeekdayWeather(woeid: Int)
}

public final class WeekdayNetworkService: WeekDayNetworkServiceProtocol {
    weak public var delegate: WeekdayDataServiceDelegate?
    private let apiRequester: APIRequestProtocol

    public init(){
        self.apiRequester = APIRequest()
    }
    
    public func getWeekdayWeather(woeid: Int) {
        
        let urlString = "\(urlBase.metaWeather.rawValue)\(woeid)/"

        apiRequester.request(
            urlString: urlString,
            method: .get,
            parameters: nil,
            success: { [weak self] (response: WeatherSearchCityModel) in
                let weather = response.consolidatedWeather
                self?.delegate?.didUpdateWeather(weather ?? [])
        }) { [weak self] (error) in
            self?.delegate?.didFail(error: error)
        }
    }
}
