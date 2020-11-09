//
//  DetailsViewController.swift
//  Movies
//
//  Created by Mrunalini on 07/11/20.
//  Copyright © 2020 Mrunalini. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet private weak var imgView: UIImageView!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var desc: UILabel!
    var movie: Movie!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        name?.text = movie.name
        desc?.text = movie.desc
        if let imgUrl = URL(string: movie.url) {
            imgView.kf.setImage(with: imgUrl)
        }
    }
}
