//
//  ViewController.swift
//  employeeDatabase
//
//  Created by apple on 17/04/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var EmployeeDetailsTableView: UITableView!
    
    @IBOutlet weak var baseView: UIView!
    @IBOutlet weak var holdView: UIView!
    @IBOutlet weak var firstNameLbl: UILabel!
    @IBOutlet weak var secondNameLbl: UILabel!
    @IBOutlet weak var emailLbl: UILabel!
    
    @IBOutlet weak var myActivityIndicator: UIActivityIndicatorView!
    
    var jsonResult : [String : Any] = [String : Any] ()
    var data : [[String : Any]] = [[String : Any]] ()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.getMethodAPI()
        self.EmployeeDetailsTableView.delegate = self
        self.EmployeeDetailsTableView.dataSource = self
        
        self.EmployeeDetailsTableView.layer.masksToBounds = true
        self.EmployeeDetailsTableView.layer.cornerRadius = 10.0
        
        self.baseView.isHidden = true
        self.baseView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.7)
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.baseView.addGestureRecognizer(tap)
        
        self.holdView.layer.masksToBounds = true
        self.holdView.layer.cornerRadius = 10.0
        
        self.myActivityIndicator.isHidden = false
    }
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.baseView.isHidden = true
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "databaseTbCell", for: indexPath) as! databaseTbCell
        cell.selectionStyle = .none
        cell.empFirstNameLbl.text = "\(self.data[indexPath.row]["first_name"]!)"
        cell.empLastNameLbl.text = "\(self.data[indexPath.row]["last_name"]!)"
        cell.empEmailIdLbl.text = "\(self.data[indexPath.row]["email"]!)"
        
        let Imgurl = URL(string: "\(self.data[indexPath.row]["avatar"]!)")
        let Imgdata = NSData(contentsOf: Imgurl!)
        cell.empAvatarImg.image = UIImage.init(data: Imgdata as! Data)
        
        return cell
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Employee Details"
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.baseView.isHidden = false
        self.firstNameLbl.text = "\(self.data[indexPath.row]["first_name"] ?? "")"
        self.secondNameLbl.text = "\(self.data[indexPath.row]["last_name"] ?? "")"
        self.emailLbl.text = "\(self.data[indexPath.row]["email"] ?? "")"
    }
    
    
    func getMethodAPI() {
        let url = URL(string: "https://reqres.in/api/users?page=1")
        var urlReq = URLRequest(url: url!)
        urlReq.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: urlReq) { data, response, error in
            
            if let err = error {
                print (err.localizedDescription)
                return
            }
            
            if let resp = response as? HTTPURLResponse {
                print (resp.statusCode)
            }
            do {
                self.jsonResult = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                self.data = self.jsonResult["data"] as! [[String:Any]]
                print(self.data)
            }
            catch let err as NSError {
                print (err.localizedDescription)
            }
            DispatchQueue.main.async {
                self.EmployeeDetailsTableView.reloadData()
                self.view.backgroundColor = .cyan
                self.myActivityIndicator.isHidden = true
            }
            
        }
        task.resume()
    }
    
}
