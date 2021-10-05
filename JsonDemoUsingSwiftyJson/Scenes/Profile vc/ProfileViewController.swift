//
//  ProfileViewController.swift
//  JsonDemoUsingSwiftyJson
//
//  Created by mac on 29/01/21.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImgView: UIImageView!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var idLabl: UILabel!
    var objProfileDataGet:Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nameLbl.text = "Name - \(objProfileDataGet?.name ?? "Nil")"
        idLabl.text  = "ID - \(objProfileDataGet?.id ?? "Nil")"
        let url = URL(string: objProfileDataGet!.artistProfile ?? "")
        load(url: url!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.title = "\(objProfileDataGet?.artistName ?? "Nil")"
    }
   
        func load(url: URL) {
                DispatchQueue.global().async { [weak self] in
                    if let data = try? Data(contentsOf: url) {
                        if let image = UIImage(data: data) {
                            DispatchQueue.main.async {
                                self?.profileImgView.image = image
                            }
                        }
                    }
                }
            }
}
