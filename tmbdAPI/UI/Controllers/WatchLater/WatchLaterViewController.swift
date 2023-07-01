//
//  WatchLaterViewController.swift
//  tmbdAPI
//
//  Created by Emre Alpago on 1.07.2023.
//

import UIKit

class WatchLaterViewController: BaseViewController<WatchLaterViewModel> {

    @IBOutlet private weak var watchLaterTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setTitle(title: "İzlenecekler Listem")
        viewModel.setupTableView(with: watchLaterTableView)
        viewModel.takeWatchListFromDB {
            DispatchQueue.main.async {
                self.watchLaterTableView.reloadData()
            }
        }
        viewModel.selectedCell = { id in
            if let vc = "DetailsStoryboard".viewController(identifier: DetailsViewController.identifier) as? DetailsViewController{
                vc.movieDetailID = id
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }

    override func setViewModel() {
        viewModel = WatchLaterViewModel()
    }
}
