
public protocol SearchNetworkServiceProtocol {
    var delegate: SearchServiceDelegate? { get set }
    func citySearch(query: String)
}

public final class SearchNetworkService: SearchNetworkServiceProtocol {
    weak public var delegate: SearchServiceDelegate?
    private let apiRequester: APIRequestProtocol
    
    public init() {
       
        self.apiRequester = APIRequest()
        
    }
    
    public func citySearch(query: String) {
        
        let searchLatLog = "\(urlBase.searchLatLog.rawValue)\(query)"
        let urlString = "\(urlBase.metaWeather.rawValue)\(searchLatLog)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        
        apiRequester.request(
            urlString: urlString,
            method: .get,
            parameters: nil,
            success: { [weak self] (response: [WeatherSearchCityModel]) in
                self?.delegate?.didFindCities(response)
        }) { [delegate] (error) in
            delegate?.didFail(error: error)
        }
    }
}
