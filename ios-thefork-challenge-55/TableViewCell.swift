import UIKit

class TableViewCell: UITableViewCell {
    
    static var identifier = "thereisonlyonecelltype"
    
    weak var coverView: UIImageView!
    weak var titleLabel: UILabel!
    weak var addressLabel: UILabel!
    weak var ratingLabel: UILabel!
    weak var heartIcon: UIImageView!
        
    var favourite = false {
        didSet {
            if self.favourite {
                self.heartIcon.image = UIImage(named: "filled-heart")
            } else {
                self.heartIcon.image = UIImage(named: "empty-heart")
            }
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        self.setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        self.setupView()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        self.coverView.image = UIColor.gray.imageWithColor(width: 1, height: 1)
        self.titleLabel.text = ""
        self.addressLabel.text = ""
        self.ratingLabel.text = ""
        self.favourite = false
    }

    func setupView() {
        let coverView = UIImageView(frame: CGRect(x: 0, y: 0, width: 128, height: 256))
        coverView.layer.cornerRadius = 12
        coverView.layer.borderWidth = 4
        coverView.layer.borderColor = CGColor.init(gray: 1, alpha: 1)
        coverView.clipsToBounds = true
        coverView.translatesAutoresizingMaskIntoConstraints = false
        self.coverView = coverView
        self.contentView.addSubview(coverView)

        let titleLabel = UILabel(frame: .zero)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.numberOfLines = 0
        self.titleLabel = titleLabel
        self.contentView.addSubview(titleLabel)
        
        let addressLabel = UILabel (frame: .zero)
        addressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addressLabel = addressLabel
        self.contentView.addSubview(addressLabel)
        
        let ratingIcon = UIImageView(frame: .zero)
        ratingIcon.translatesAutoresizingMaskIntoConstraints = false
        ratingIcon.frame.size = CGSize(width: 16, height: 16)
        ratingIcon.image = UIImage(named: "tf-logo")
        self.contentView.addSubview(ratingIcon)
        
        let ratingLabel = UILabel (frame: .zero)
        ratingLabel.translatesAutoresizingMaskIntoConstraints = false
        self.ratingLabel = ratingLabel
        self.contentView.addSubview(ratingLabel)
        
        let heartIcon = UIImageView(frame: .zero)
        heartIcon.translatesAutoresizingMaskIntoConstraints = false
        heartIcon.frame.size = CGSize(width: 16, height: 16)
        heartIcon.backgroundColor = .white
        heartIcon.layer.cornerRadius = 4
        heartIcon.image = UIImage(named: "empty-heart")
        self.heartIcon = heartIcon
        self.contentView.addSubview(heartIcon)

        NSLayoutConstraint.activate([
            self.coverView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            self.coverView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            self.coverView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            self.coverView.bottomAnchor.constraint(equalTo: self.contentView.centerYAnchor, constant: 40.0),
            self.titleLabel.topAnchor.constraint(equalTo: self.coverView.bottomAnchor),
            self.titleLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8.0),
            self.titleLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -32.0),
            self.addressLabel.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor),
            self.addressLabel.leadingAnchor.constraint(equalTo: self.titleLabel.leadingAnchor),
            self.ratingLabel.topAnchor.constraint(equalTo: self.coverView.bottomAnchor, constant: 8.0),
            self.ratingLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
            ratingIcon.topAnchor.constraint(equalTo: self.coverView.bottomAnchor, constant: 4.0),
            ratingIcon.trailingAnchor.constraint(equalTo: self.ratingLabel.leadingAnchor, constant: -8.0),
            self.heartIcon.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8.0),
            self.heartIcon.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8.0),
        ])

        self.titleLabel.font = UIFont.systemFont(ofSize: 24)
    }

}
