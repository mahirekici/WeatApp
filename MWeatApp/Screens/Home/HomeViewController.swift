

import UIKit

final class HomeViewController: BaseViewController {
    
    @IBOutlet private weak var tableView: UITableView?
    
    private let spinner = LoadingController()
    private let presenter: HomePresenter
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.attachView(self)
        setupTableView()
        setupNavigationBar()
        navigationBarTitle()
    }
    
    private func setupTableView() {
        tableView?.delegate = self
        tableView?.dataSource = self
        
        tableView?.register(HomeTableViewCell.nib,forCellReuseIdentifier: HomeTableViewCell.identifier)
    }

    
    private func setupNavigationBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        setBackButton(title: localizable.welcomePage.title.localized)
    }
    
    private func navigationBarTitle() {
        let t = localizable.welcomePage.title.localized
        self.title = t

    }
}



extension HomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        
        guard let cell = tableView.dequeueReusableCell( withIdentifier: HomeTableViewCell.identifier, for: indexPath) as? HomeTableViewCell else { return UITableViewCell() }
        let city = presenter.dataSource[indexPath.row]
       
        cell.cityLabel!.text  = city.title
             
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.rowDidTap(indexPath.row)
    }
}


extension HomeViewController: HomePresenterDelegate {
    
    
    func showAlert(message: String, buttonTitle: String, title: String) {
        let dialogMessage = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        
        let tryAgainButton = UIAlertAction(
            title: buttonTitle,
            style: .default,
            handler: { [weak self] _ -> Void in
                self?.presenter.tryAgainButtonDidTap()
        })
        
        dialogMessage.addAction(tryAgainButton)
        
        DispatchQueue.main.async { [weak self] in
            self?.present(dialogMessage, animated: true, completion: nil)
        }
    }
    
    func showLoading() {
        spinner.show()
        addChild(spinner)
        view.addSubview(spinner.view)
    }
    
    func hideLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.spinner.hide()
        }
    }
    
    func reloadData() {
        DispatchQueue.main.async { [weak self] in
            self?.tableView?.reloadData()
        }
    }
}
