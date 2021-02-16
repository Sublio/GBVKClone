//
//  NewsFeedTableViewController.swift
//  GeekBrainsTestProject
//
//  Created by Denis Mordvinov on 16.02.2021.
//

import UIKit

class NewsFeedTableViewController: UITableViewController {
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 600
        setGradientToTableView()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = .clear
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! NewsFeedTableViewCell
        cell.userName.text = "David"
        //cell.picture.image = UIImage(named: "france")
        cell.picture.image = ((indexPath.row % 2) != 0) ? UIImage(named: "france") : UIImage(named: "winders")
        cell.date.text = "14/11/2009"
        cell.avatar.image = UIImage(named: "face1")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func setGradientToTableView(){
        let hexColors: [CGColor] = [
            UIColor.blueZero.cgColor,
            UIColor.white.cgColor
        ]
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = hexColors
        gradientLayer.locations = [0.0, 0.5]
        //Vertical mode for gradient
        gradientLayer.startPoint = .init(x: 1, y: 0)
        gradientLayer.endPoint   = .init(x: 0, y: 1)
        gradientLayer.frame = self.tableView.bounds
        let keeperView = UIView(frame: self.tableView.bounds)
        keeperView.layer.insertSublayer(gradientLayer, at: 0)
        self.tableView.backgroundView = keeperView
    }

}
