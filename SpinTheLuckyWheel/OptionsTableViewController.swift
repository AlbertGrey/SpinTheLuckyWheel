//
//  OptionsTableViewController.swift
//  SpinTheLuckyWheel
//
//  Created by TheGrey on 2020/2/20.
//  Copyright © 2020 thegrey. All rights reserved.
//

import UIKit

class OptionsTableViewController: UITableViewController {
    
    var optionsArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "選項"
        loadList()
//        print("optionsArray=\(optionsArray), num=\(optionsArray.count)")
//        navigationController?.navigationBar.prefersLargeTitles = true //加高title
//        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "optionCell")
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
       
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return optionsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell", for: indexPath)
        
        let name = optionsArray[indexPath.row]
        
        cell.textLabel?.text = name
//        cell.textLabel?.text = "\(name) Section: \(indexPath.section) Row: \(indexPath.row)"
        cell.isSelected = true
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("indexpath=\(indexPath)")
//        performSegue(withIdentifier: "showDetail", sender: nil)
    }
    
    
    @IBAction func addOption(_ sender: UIBarButtonItem) {
//        performSegue(withIdentifier: "showDetail", sender: nil) //跳頁用segue
        popUpAlertWithDefault(nil, Handler: {
                (success, result) in
                    if success == true{
                        if let okResult = result{
                            self.optionsArray.append(okResult)
                            let insertItem = IndexPath(row: self.optionsArray.count - 1, section: 0)
                            self.tableView.insertRows(at: [insertItem], with: .automatic)
                            self.saveList()
                        }
                    }
        })
    }
    //修改
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        popUpAlertWithDefault(optionsArray[indexPath.row], Handler: {
        (success, result) in
            if success == true{
                if let okResult = result{
                    self.optionsArray[indexPath.row] = okResult
                    self.tableView.reloadData()
                    self.saveList()
                 }
            }

        })
    }
    //刪除
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            optionsArray.remove(at: indexPath.row)
            saveList()
            tableView.reloadData()
        }
    }
    //savelist
    func saveList() {
        UserDefaults.standard.set(optionsArray, forKey: "optionslist")
    }
    //load
    func loadList() {
        if let loadedList = UserDefaults.standard.stringArray(forKey: "optionslist"){
            optionsArray = loadedList
        }
    }
    
    func popUpAlertWithDefault(_ defaultValue:String?,Handler handler: @escaping (Bool, String?) -> ()){
        var titleText = ""
        if defaultValue == nil{
            titleText = "Add a new item"
        }else{
            titleText = "Edit a item"
        }
        
            let alert = UIAlertController(title: titleText, message: "", preferredStyle: .alert)
            alert.addTextField {
                (textField) in
                textField.placeholder = "Add new item"
                textField.text = defaultValue
            }
            //ok
            let okAction = UIAlertAction(title: "OK", style: .default, handler: {
                (action) in
                if let inputText = alert.textFields?[0].text{
                    if inputText != ""{
                        handler(true,inputText)
                    }else{
                        handler(false,nil)
                    }
                }
            })
            //cancel
            let cancelAction = UIAlertAction(title: "CANCEL", style: .default, handler: {
                (action) in
                handler(false,nil)
            })
            alert.addAction(okAction)
            alert.addAction(cancelAction)
            present(alert, animated: true, completion: nil)
    }

        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showDetail"{
    //            if let detailPage = segue.destination as? DetailViewController{
    //                let selectIndexpath = self.tableView.indexPathForSelectedRow
    //                if let selectRow = selectIndexpath?.row{
    //                    detailPage.infoFromOptionPage = ""
    //                }
    //
    //            }
            }
        }
    
    
}
