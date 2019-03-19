//
//  MainViewController.swift
//  ABC
//
//  Created by iosdevlog on 2019/3/19.
//  Copyright © 2019 iosdevlog. All rights reserved.
//

import UIKit
import Disk

private let reuseIdentifier = "MainTableViewCell"
private let kExamKey = "kExamKey"

class MainViewController: UIViewController {
    var exams = [Exam]()
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = editButtonItem
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.tableFooterView = UIView()
        self.tableView.rowHeight = 88
        
        load()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tableView.reloadData()
    }

    @IBAction func test(_ sender: Any) {
        self.performSegue(withIdentifier: "Test", sender: nil)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        
        self.tableView.isEditing = isEditing
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Detail" {
            let vc = segue.destination as! DetailViewController
            vc.exam = sender as? Exam
        } else if segue.identifier == "Test" {
            let vc = segue.destination as! TestViewController
            vc.delegate = self
        }
    }

}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! MainTableViewCell
        
        let exam = exams[indexPath.row]
        cell.indexLabel.text = String(indexPath.row + 1)
        cell.rightLabel?.text = "\(exam.right)"
        cell.wrongLabel?.text = "\(exam.wrong)"
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "yyyy/MM/dd"
        
        cell.dateLabel.text = String(dformatter.string(from: exam.date))
        
        let tformatter = DateFormatter()
        tformatter.dateFormat = "HH:mm:ss"
        
        cell.timeLabel.text = String(tformatter.string(from: exam.date))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let exam = exams[indexPath.row]
        performSegue(withIdentifier: "Detail", sender: exam)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            exams.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            tableView.reloadData()
        }
    }
}

extension MainViewController: UpdateExam {
    func update(exam: Exam) {
        self.exams.append(exam)
      
        self.tableView.reloadData()
        save()
    }
    
    func save() {
        try? Disk.save(exams, to: .documents, as: kExamKey)
    }
    
    func load() {
        if let data = try? Disk.retrieve(kExamKey, from: .documents, as: [Exam].self) {
            self.exams = data
        }
        self.tableView.reloadData()
    }
}
