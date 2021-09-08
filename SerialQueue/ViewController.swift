//
//  ViewController.swift
//  SerialQueue
//
//  Created by Pradip Gotame on 07/09/2021.
//

import UIKit
import SDWebImage

struct URLs {
    var url = ""
    var cLength = ""
    var favIcon = ""
    var error = ""
}

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var startBtn: UIButton!
    
    var urls = [URLs(url: "apple.com", cLength: "", favIcon: "", error: ""),
                URLs(url: "spacex.com", cLength: "", favIcon: "", error: ""),
                URLs(url: "dapi.co", cLength: "", favIcon: "", error: ""),
                URLs(url: "facebook.com", cLength: "", favIcon: "", error: ""),
                URLs(url: "microsoft.com", cLength: "", favIcon: "", error: ""),
                URLs(url:  "amazon.com", cLength: "", favIcon: "", error: ""),
                URLs(url: "boomsupersonic.com", cLength: "", favIcon: "", error: ""),
                URLs(url: "twitter.com", cLength: "", favIcon: "", error: ""),
                URLs(url: "twit", cLength: "", favIcon: "", error: "")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func startBtn(_ sender: Any) {
        startBtn.isHidden = true
        
        let semaphone = DispatchSemaphore(value: 1)
        let dispatchQueue = DispatchQueue.global(qos: .background)
        
        dispatchQueue.async {
            for (index, item) in self.urls.enumerated() {
                print("Index -> ", index)
                semaphone.wait()
                NetworkService.shared.fetchRequest(url: item.url) {err,length,fav in
                    
                    self.urls[index].cLength = length
                    self.urls[index].favIcon = fav
                    self.urls[index].error   = err
                    
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(item: index, section: 0)
                        self.tableView.reloadRows(at: [indexPath], with: .none)
                    }
                    
                    semaphone.signal()
                }
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return urls.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: TableCell = tableView.dequeueReusableCell(withIdentifier: String(describing: TableCell.self), for: indexPath) as! TableCell
        cell.model = urls[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
}

