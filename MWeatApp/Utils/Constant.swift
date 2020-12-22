

enum localizable {
    
    enum welcomePage: String, LocalizableDelegate {
        case title = "welcomeTitle"
        case searchBar = "placeholder"
        case test = "inAppButtonError"
    }
    enum inAppError: String, LocalizableDelegate {
        case title = "inAppTitleError"
        case button = "inAppButtonError"
        case generic = "inAppGenericError"
        case noInternet = "inAppNoInternet"
        case noLocationFound = "inAppNoLocation"
    }
}


