//
//  CharactersViewController.swift
//  MarvelTeam
//
//  Created by Eduardo Jordan on 28/1/22.
//

import UIKit

class CharactersViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    static var shared = CharactersViewController()
    
    var viewModel = ViewModelCharacter()
    var page = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBar()
        setupTableView()
        configureView()
        bind()
    }
    
    func setupNavBar() {
        let logoContainer = UIView(frame: CGRect(x: 0, y: 0, width: 270, height: 30))
        let imageView = UIImageView(frame: CGRect(x: 0, y: -5, width: 270, height: 30))
        imageView.contentMode = .scaleAspectFit
        let image = UIImage(named: "LogoMarvel")
        imageView.image = image
        logoContainer.addSubview(imageView)
        navigationItem.titleView = logoContainer
    }
    
    func setupTableView() {
        tableView.rowHeight = 250
    }
    
    func configureView() {
        activity.startAnimating()
        activity.isHidden = false
        viewModel.retrieveData(page: page)
    }
    
    func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async { [self] in
                self!.tableView.reloadData()
                self!.activity.stopAnimating()
                self?.activity.isHidden = true
            }
        }
    }
    
    func loadMoreData() {
        activity.startAnimating()
        activity.isHidden = false
        page += 100
        viewModel.retrieveData(page: page)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if (tableView.contentOffset.y + tableView.frame.size.height) >= tableView.contentSize.height {
            self.loadMoreData()
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.activity.stopAnimating()
                self.activity.isHidden = true
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension CharactersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.characterData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.cellCharacter) as! CellCellCharactersViewController
        
        let marvelHero = viewModel.characterData[indexPath.row]
        
        cell.selectionStyle = .none
        cell.nameCharacters.text = marvelHero.name
        
        let imgData = "\(marvelHero.image!)" + "/portrait_xlarge.jpg"
        let url = URL(string: imgData)
        
        if (url == nil || imgData.contains(Constants.textImgNotAvailable) || imgData.contains(
            "http://i.annihil.us/u/prod/marvel/i/mg/5/")) {
            cell.imgChracters?.image = UIImage(named: Constants.imgNotAvailable)
            cell.imgChracters?.contentMode = .scaleAspectFit
        } else {
            cell.imgChracters?.image = UIImage(url: URL(string: imgData))
            cell.imgChracters?.contentMode = .scaleAspectFit
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex && viewModel.characterData.count > 0 {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.color = Colors.MarvelRed
            spinner.frame = CGRect(x: 0.0, y: 0.0, width: tableView.bounds.width, height: 70)
            spinner.startAnimating()
            tableView.tableFooterView = spinner
        }
    }
}

// MARK: - UITableViewDelegate

extension CharactersViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let marvelHero = viewModel.characterData[indexPath.row]
        let controller = self.storyboard!.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        controller.getName = marvelHero.name!
        controller.getDescription = marvelHero.description!
        controller.getImage = marvelHero.image!
        self.navigationController!.pushViewController(controller, animated: true)
    }
    
}

