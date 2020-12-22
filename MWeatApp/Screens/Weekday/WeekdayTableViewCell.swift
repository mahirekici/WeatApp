

import UIKit

final class WeekdayTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var imageViewIcon: UIImageView?
    @IBOutlet private weak var dateLabel: UILabel?
    @IBOutlet private weak var temperatureLabel: UILabel?
    
    static let identifier = "WeekCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    static var nib: UINib {
        return UINib(nibName: String(describing: self), bundle: nil)
    }
    
    func configure(presenter: WeekdayCellPresenter) {
        presenter.attachView(self)
    }
}

extension WeekdayTableViewCell: WeekdayCellPresenterDelegate {
    
    func setupCell(imageIcon: String, temperature: String, date: String) {
        self.imageViewIcon?.image = UIImage(named: imageIcon) ?? UIImage()
        self.temperatureLabel?.text = temperature
        self.dateLabel?.text = date
    }
}
