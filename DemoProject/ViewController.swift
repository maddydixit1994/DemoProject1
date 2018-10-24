//
//  ViewController.swift
//  DemoProject
//
//  Created by Revonomics on 04/10/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

import UIKit

struct ZoomTransactionManager {
    var cardView: UIView
    var cardViewFrame: CGRect
}

struct ImageTransactionManager {
    var imageView: UIImageView
    var imageViewFrame: CGRect
}

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NextViewControllerDelegete {
    
    let imgArray = ["section1_banner.jpg",
                    "section2_banner.jpg",
                    "section3_banner.jpg",
                    "section4_banner.jpg"]
    
    let titleArray = ["Introduction To Course",
                      "Section 1: SEO – An introduction",
                      "Section 2: An introduction to PPC",
                      "Section 3: Social Media and Business"]
    
    var zoomTransactionManager = ZoomTransactionManager(cardView: UIView(), cardViewFrame: .zero)
    var zoomImageTransactionManager = ImageTransactionManager(imageView: UIImageView(), imageViewFrame: .zero)
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    private func setupTableView()
    {
        myTableView.separatorStyle = .none
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        
//        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.register(ColorfulTableViewCell.classForCoder(), forCellReuseIdentifier: "ColorFullCell")
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.separatorStyle = .none
//        view.addSubview(tableView)
//
//        NSLayoutConstraint.activate([
//            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
//            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
//            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
//            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
//        ])
    }
    
    // MARK : UITableViewDelegetes Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imgArray.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TVCell", for: indexPath) as! ColorfulTableViewCell
        cell.cardView.backgroundColor = .white
        cell.imgView?.image = UIImage(named: imgArray[indexPath.row])
        cell.lblTitle?.text = titleArray[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("selected cell index : ",indexPath.row)
    
        guard let cell = tableView.cellForRow(at: indexPath) as? ColorfulTableViewCell else { return }
        
        // Card View
        let cardViewFrame = cell.cardView.superview?.convert(cell.cardView.frame, to: nil)
        let copyOfCardView = UIView(frame: cardViewFrame!)
        copyOfCardView.layer.cornerRadius = 10.0
        copyOfCardView.backgroundColor = #colorLiteral(red: 0.8162106455, green: 0.8845090422, blue: 1, alpha: 1)
        view.addSubview(copyOfCardView)
        
        // Image View
        let imageViewFrame = cell.imgView.superview?.convert(cell.imgView.frame, to: nil)
        let copyOfImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: copyOfCardView.frame.size.width, height: imageViewFrame!.size.height))
        copyOfImageView.image = UIImage(named: imgArray[indexPath.row])
        copyOfCardView.addSubview(copyOfImageView)
    
        zoomTransactionManager = ZoomTransactionManager(cardView: copyOfCardView, cardViewFrame: cardViewFrame!)
        
        zoomImageTransactionManager = ImageTransactionManager(imageView: copyOfImageView, imageViewFrame: copyOfImageView.frame)
        
        UIView.animate(withDuration: 0.4, animations: {
            copyOfCardView.layer.cornerRadius = 0.0
            copyOfCardView.frame = self.view.frame
            copyOfImageView.frame.size.width = self.view.frame.size.width
            copyOfImageView.frame.size.height = imageViewFrame!.size.height + 19.5
        }, completion: { (expanded) in
            self.performSegue(withIdentifier: "segue_next", sender: self.titleArray[indexPath.row])
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK : NextViewControllerDelegete Method
    
    func didGoBack() {
        UIView.animate(withDuration: 0.4, animations: {
            self.zoomTransactionManager.cardView.frame = self.zoomTransactionManager.cardViewFrame
            self.zoomImageTransactionManager.imageView.frame = self.zoomImageTransactionManager.imageViewFrame
            self.zoomTransactionManager.cardView.layer.cornerRadius = 10.0
        }) { (shrinked) in
            self.zoomImageTransactionManager.imageView.removeFromSuperview()
            self.zoomTransactionManager.cardView.removeFromSuperview()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextViewController = segue.destination as! NextViewController
        nextViewController.delegete = self
        nextViewController.strTitle = sender as! String
        nextViewController.topHeight = self.zoomImageTransactionManager.imageViewFrame.size.height
    }
}

