//
//  SecondViewController.swift
//  treads
//
//  Created by Islam Kasem on 29/06/2019.
//  Copyright © 2019 Islam Kasem. All rights reserved.
//

import UIKit

class RunLogVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
    }


}

extension RunLogVC : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Run.returnAllRuns()?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RunLogCell") as? RunLogCell {
            guard let run = Run.returnAllRuns()?[indexPath.row]else{
                return RunLogCell()
            }
            cell.configureRunLog(run: run)
            return cell
        }else{
        return UITableViewCell()
        }
        
    }
    
    
}

