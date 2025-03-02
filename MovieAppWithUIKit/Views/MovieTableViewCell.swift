import UIKit
import SwiftUI
import SDWebImage

class MovieTableViewCell: UITableViewCell {
    
    static var reuseIdentifier: String = "MovieTableViewCell"
    
    var movieImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var playbutton : UIButton = {
        var button = UIButton()
        let image = UIImage(systemName: "play.circle",
                           withConfiguration: UIImage.SymbolConfiguration(pointSize: 30, weight: .regular))
        button.setImage(image,for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 17, weight: .bold)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(movieImageView)
        contentView.addSubview(playbutton)
        contentView.addSubview(titleLabel)
        

        NSLayoutConstraint.activate([
            // movieImageView tüm contentView'i kaplasın
            movieImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            movieImageView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 15),
            movieImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -15),
            movieImageView.widthAnchor.constraint(equalToConstant: 100),
           

            // titleLabel alta sabitlensin
            titleLabel.leadingAnchor.constraint(equalTo: movieImageView.trailingAnchor, constant: 20),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            playbutton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            playbutton.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configure(with model: Movie) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model.poster_path ?? "")") else {
            return
        }
        movieImageView.sd_setImage(with: url, completed: nil)
        titleLabel.text = model.original_title
    }
}

