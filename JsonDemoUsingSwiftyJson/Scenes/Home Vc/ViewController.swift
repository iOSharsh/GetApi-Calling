//
//  ViewController.swift
//  JsonDemoUsingSwiftyJson
//
//  Created by mac on 29/01/21.
//

import UIKit
import Alamofire
import SwiftyJSON
class ViewController: UIViewController {

    var arrData:[Result]?
    var dicData:Feed?
    @IBOutlet weak var tablviewVc: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        getData()
    }

    func getData()
    {
     
        let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/apple-music/coming-soon/all/10/explicit.json")
        Alamofire.request(url!, method: .get, encoding: JSONEncoding.default).responseJSON { (response) in
            do {
                let myProfiledata = try JSONSerialization.jsonObject(with: response.data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String:Any]
                
                if let mypro = myProfiledata
                {
                    
                    
                    let feed = mypro["feed"] as? [String:Any]
                    //debugPrint("feed",feed)
                    self.dicData = Feed.init(json: JSON(feed ?? ""))
                    
                    DispatchQueue.main.async {
                        self.tablviewVc.reloadData()
                    }
                }
                
            }catch{
                
            }
        }
            
        
        
        
    }
    
}

extension ViewController:UITableViewDelegate,UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dicData?.result?.count ?? 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tablviewVc.dequeueReusableCell(withIdentifier: "VcTableViewCell", for: indexPath) as! VcTableViewCell
        cell.viewBG.layer.cornerRadius = 12
     
        cell.viewBG.clipsToBounds = true
        cell.viewBG.layer.borderWidth = 0.5
    
        cell.artistName.text = "artist Name - \(dicData?.result?[indexPath.row].artistName ?? "")"
        
        cell.artistId.text = "artist Id - \(dicData?.result?[indexPath.row].artistId ?? "")"
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let editAction = UIContextualAction(style: .normal, title:  "Profile", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            success(true)
            
            
            let profileVc = self.storyboard!.instantiateViewController(withIdentifier: "ProfileViewController") as! ProfileViewController
            profileVc.objProfileDataGet = self.dicData?.result?[indexPath.row]
           
           
            self.navigationController?.pushViewController(profileVc, animated: true)
        })
        editAction.backgroundColor = .blue
        let swipeAction = UISwipeActionsConfiguration(actions: [editAction])
            swipeAction.performsFirstActionWithFullSwipe = false // This is the line which disables full swipe
            return swipeAction
        
    }
    
    
}
