//
//  IRSSHistoryViewController.swift
//  wang.dov (iOS)
//
//  Created by i564206 on 2022/4/18.
//

import Foundation
import UIKit

class IRSSHistoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let apiCaller = APICaller()
    private var data = [String]()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.row]
        return cell
    }
    
    
    private let tablView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    private func createSpinnerFooter() -> UIView {
        let footerView = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 100))
        let spinner = UIActivityIndicatorView()
        footerView.addSubview(spinner)
        spinner.startAnimating()
        return footerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tablView)
        tablView.dataSource = self
        tablView.delegate = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tablView.frame = view.bounds
        apiCaller.fetchData { [weak self] result in
            switch result {
            case .success(let data):
                self?.data.append(contentsOf: data)
                DispatchQueue.main.async {
                    self?.tablView.reloadData()
                }
            case .failure(_):
                print("error")
            }
        }
    } 
    
    func scrollViewDidScroll(_ scrollerView: UIScrollView) {
        let position = scrollerView.contentOffset.y
        if position > (tablView.contentSize.height-100-scrollerView.frame.size.height) {
            guard !apiCaller.isPagination else { return }
            self.tablView.tableFooterView = createSpinnerFooter()
            apiCaller.fetchData(pagination: true) { [weak self] result in
                DispatchQueue.main.async {
                    self?.tablView.tableFooterView = nil
                }
                switch result{
                case .success(let data):
                    self?.data.append(contentsOf: data)
                    DispatchQueue.main.async {
                        self?.tablView.reloadData()
                    }
                case .failure(_):
                    print("error")
                }
            }
        }
    }
}

