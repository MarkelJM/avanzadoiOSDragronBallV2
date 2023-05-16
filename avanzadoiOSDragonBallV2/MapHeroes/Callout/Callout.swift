//
//  Callout.swift
//  avanzadoiOSDragonBallV2
//
//  Created by Markel Juaristi on 7/4/23.
//

import UIKit
import Kingfisher

class CallOut: UIView {
    var heroNameLabel: UILabel!
    var heroImageView: UIImageView!
    var detailButton: UIButton!
    var onDetailButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with annotation: Annotation) {
        heroNameLabel.text = annotation.name
        // Aquí debes cargar la imagen del héroe
        let url = URL(string: annotation.image)
        heroImageView.kf.setImage(with: url)
    }

    private func setupViews() {
        heroNameLabel = UILabel()
        heroNameLabel.translatesAutoresizingMaskIntoConstraints = false

        heroImageView = UIImageView()
        heroImageView.translatesAutoresizingMaskIntoConstraints = false

        detailButton = UIButton()
        detailButton.setTitle("Details", for: .normal)
        detailButton.addTarget(self, action: #selector(showDetails), for: .touchUpInside)
        detailButton.translatesAutoresizingMaskIntoConstraints = false

        addSubview(heroNameLabel)
        addSubview(heroImageView)
        addSubview(detailButton)

        NSLayoutConstraint.activate([
            heroNameLabel.topAnchor.constraint(equalTo: topAnchor),
            heroNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor),

            heroImageView.topAnchor.constraint(equalTo: heroNameLabel.bottomAnchor),
            heroImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            heroImageView.trailingAnchor.constraint(equalTo: trailingAnchor),

            detailButton.topAnchor.constraint(equalTo: heroImageView.bottomAnchor),
            detailButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            detailButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }

    @objc func showDetails() {
        onDetailButtonTapped?()
    }
}


/*
class CallOut: UIView{
    private let titleLabel = UILabel(frame: .zero)
    private let subtitleLabel = UILabel(frame: .zero)
    private let imageView = UIImageView(frame: .zero)
    private let annotation: Annotation
    
    init(annotation: Annotation) {
            self.annotation = annotation
            super.init(frame: .zero)
            setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        setupTitle()
        setupSubtitle()
        setupImageView()
    }
    
    
    private func setupTitle() {
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.text = annotation.name
            addSubview(titleLabel)
            titleLabel.translatesAutoresizingMaskIntoConstraints = false
            titleLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    private func setupSubtitle() {
        subtitleLabel.font = UIFont.systemFont(ofSize: 14)
        subtitleLabel.textColor = .gray
        //subtitleLabel.text = "subtitle"
    
        subtitleLabel.text = "ver detalle"
        subtitleLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(showDetails)))

        addSubview(subtitleLabel)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8).isActive = true
        subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        }
    
    @objc func showDetails(){
        debugPrint("Mostrando los detalles")
    }
    
    private func setupImageView() {
            imageView.kf.setImage(with: URL(string: annotation.image))
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 8).isActive = true
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
            imageView.heightAnchor.constraint(equalToConstant: 200).isActive = true
            imageView.widthAnchor.constraint(equalToConstant: 280).isActive = true
        }
}
*/
