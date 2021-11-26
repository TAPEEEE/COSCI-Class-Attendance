//
//  HomeViewController.swift
//  classattendanceproject
//
//  Created by Parisut Supchokpool on 1/11/2564 BE.
//

import UIKit
import Firebase
import CloudKit

class HomeViewController: UIViewController, UITableViewDataSource,UITableViewDelegate  {
//    @IBOutlet weak var headerlable: UILabel!
    
    @IBOutlet weak var headerlable: UILabel!
    private var classlist : [ClassModel]?
    
    var subjectname:[String] = ["Object Oriented Programming","Database Management System","Consumer Behavior","Active Citizens"]
    var subjectid:[String] = ["CSC261","CSC251","COS302","SWU261"]
    var subjecttime:[String] = ["9:00-11.30","9:00-11:30","9:00-11:30","9:00-11:30"]
    var stdcount:[String] = ["45","45","45","45"]
    var checkstats:[String] = ["0","1","0","2"]
    var teachername:[String] = ["Dr.A","Prof.Dr.A","Dr.B","Dr.B"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjectname.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "subjectcard", for: indexPath) as! SubjectCardCell
        cell.subject(id: subjectid[indexPath.row], name: subjectname[indexPath.row], time: subjecttime[indexPath.row], stdcount: stdcount[indexPath.row], checkstat: checkstats[indexPath.row])
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ontap(gesture:)))
        cell.tag = indexPath.row
        cell.addGestureRecognizer(tapGesture)
        return cell
    }
    
    @objc func ontap(gesture:UITapGestureRecognizer) {
        if let cell = gesture.view {
            print(cell.tag)
            performSegue(withIdentifier: "show_class", sender: "")
            //ฟ้อนทำด้วย //ดันหน้าที่ถูกต้อง จะได้ไม่ซ้อน พุช
//            let vc = self.storyboard?.instantiateViewController(identifier: "createclass") as? CreateClass
//            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
    @IBAction func profileButton(_ sender: Any) {
        let Profile = self.storyboard?.instantiateViewController(identifier: "profile") as? ProfileViewController
        self.view.window?.rootViewController = Profile
        //self.view.window?.makeKeyAndVisible()
    }
    
    @IBAction func addClass(_ sender: Any) {
        let Create = self.storyboard?.instantiateViewController(identifier: "createclass") as? CreateClass
        self.view.window?.rootViewController = Create
    }
    
    
    @IBOutlet weak var permissionbtn: UIButton!
    @IBOutlet weak var tf: UITextField!
    override func viewDidLoad() {
        DatabaseManager.shared.getalldata()
        super.viewDidLoad()
        headerlable.font = UIFont(name: Constants.ConstantFont.Medium, size: 28)
        headerlable.textColor = UIColor.white
        permissionbtn.titleLabel?.font = UIFont(name: Constants.ConstantFont.Regular, size: 14)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show_class" {
            //ส่งค่า
            let subjectinfo = segue.destination as! SubjectInfo
            
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setaddClassButton()
        //เช็คหน้าซ้อน
        //print(self.navigationController?.viewControllers.count)
        // ลบหน้าตามindex(count)
        //self.navigationController?.viewControllers.remove(at:navigationController!.viewControllers.count)
        //กลับหน้า
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    //เช็คtypeและซ่อนปุ่มaddclass
    fileprivate func setaddClassButton() {
        let type = DatabaseManager.shared.checkType()
        switch type {
        case "teacher" :
            permissionbtn.isHidden = false
        default :
            permissionbtn.isHidden = true
        }
    }
        
}
    