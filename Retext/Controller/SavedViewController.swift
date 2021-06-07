//
//  SavedViewController.swift
//  Retext
//
//  Created by Abraham Estrada on 6/1/21.
//

import UIKit

private let cellIdentifier = "cell"

class SavedViewController: UITableViewController {
    
    // MARK: - Properties
    
    var retexts = [String]() {
        didSet{handleShouldShowNoRetextsLabel()}
    }
    
    private let noRetextsSavedLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.text = "No Retexts Saved"
        label.textColor = TINTCOLOR
        label.textAlignment = .center
        return label
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardOnTap()
        tabBarController?.tabBar.tintColor = TINTCOLOR
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Delete All", style: .plain, target: self, action: #selector(handleDeleteAllTapped))
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.register(RetextCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.rowHeight = 125
        view.backgroundColor = BACKGROUNDCOLOR
        navigationItem.title = "Saved"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retexts = UserDefaults.standard.array(forKey: RETEXTSKEY) as? [String] ?? [String]()
        tableView.reloadData()
    }
    
    // MARK: - Actions
    
    @objc func handleDeleteAllTapped() {
        if retexts.count == 0 {
            showMessage(withTitle: "", message: "There are no Retexts to delete.")
        } else {
            showDeleteAllAlert()
        }
    }
    
    // MARK: - Helpers
    
    func handleShouldShowNoRetextsLabel() {
        guard let navView = navigationController?.view else {return}
        navView.addSubview(noRetextsSavedLabel)
        noRetextsSavedLabel.center(inView: navView)
        if retexts.count == 0 {
            noRetextsSavedLabel.isHidden = false
        } else {
            noRetextsSavedLabel.isHidden = true
        }
    }
    
    func showDeleteAllAlert() {
        let alert = UIAlertController(title: "Delete All Retexts", message: "Are you sure you want to delete all Retexts? This cannot be undone.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Delete All", style: .destructive) { _ in
            self.retexts.removeAll()
            UserDefaults.standard.set(self.retexts, forKey: RETEXTSKEY)
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            self.tableView.reloadData()
        })
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource

extension SavedViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return retexts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! RetextCell
        cell.delegate = self
        cell.retextTextView.text = retexts[indexPath.row]
        return cell
    }
}

// MARK: - UITableViewDelegate

extension SavedViewController {
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            retexts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            UserDefaults.standard.set(retexts, forKey: RETEXTSKEY)
            let generator = UIImpactFeedbackGenerator(style: .soft)
            generator.impactOccurred(intensity: 1.0)
        }
    }
}

// MARK: - RetextCellDelegate

extension SavedViewController: RetextCellDelegate {
    
    func didTapCopy(retext: String) {
        let pasteboard = UIPasteboard.general
        pasteboard.string = retext
        let generator = UIImpactFeedbackGenerator(style: .rigid)
        generator.impactOccurred(intensity: 1.0)
        showAlert(title: "Copied to Clipboard", message: "")
    }
}
