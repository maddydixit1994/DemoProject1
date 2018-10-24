//
//  NextViewController.swift
//  DemoProject
//
//  Created by Revonomics on 04/10/18.
//  Copyright © 2018 Revonomics. All rights reserved.
//

import UIKit

protocol NextViewControllerDelegete {
    func didGoBack()
}

class NextViewController: UIViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewContent: UIView!
    
    var strTitle = String()
    
    var topHeight:CGFloat = 0
    
    var delegete: NextViewControllerDelegete?
    
    var swipeDown:UISwipeGestureRecognizer? = nil
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        view.backgroundColor = .clear
        
        lblTitle.text = strTitle
        
        topConstraint.constant = topHeight + 19.5 + 15
        
        viewContent.layer.masksToBounds = true
        viewContent.layer.cornerRadius = 10
        
        swipeDown = UISwipeGestureRecognizer.init(target: self, action: #selector(swipeHappened))
        
        swipeDown?.direction = UISwipeGestureRecognizerDirection.down
        
        self.view.addGestureRecognizer(swipeDown!)
        
        //setupWelcomeLabel()
    }
    
    @objc func swipeHappened(_ swip:UISwipeGestureRecognizer) {
        print("Swipe down action...")
        guard let delegete = delegete else { return }
        delegete.didGoBack()
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnBack.layer.cornerRadius = 5.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func setupWelcomeLabel() {
//        let label = UILabel()
//        label.numberOfLines = 0
//        label.font = UIFont.boldSystemFont(ofSize: 30)
//        label.textColor = .white
//        label.textAlignment = .center
//        label.text = "Zoommed\nFrom Row\n\(selectedRow)"
//        label.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(label)
//
//        NSLayoutConstraint.activate([
//            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 32.0),
//            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -32.0),
//            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64.0),
//            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor)
//        ])
//    }
    
    @IBAction func backAction(_ sender: Any) {
        print("Back button action...")
        guard let delegete = delegete else { return }
        delegete.didGoBack()
        dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
