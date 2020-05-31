//
//  SettingsVC.swift
//  JSONPlaceholderAPI
//
//  Created by Aleksey on 0530..20.
//  Copyright © 2020 Aleksey Kabishau. All rights reserved.
//

import UIKit

class SettingsVC: UITableViewController {
	
	enum SettingsKey: String {
		case usersToDisplay
		case controlUsers
	}
	
	private(set) lazy var currentSettings = getCurrentSettings()
	private var defaults = UserDefaults.standard
	private var settingsKey = "settings"
	
	
	let defaultSettings: [String: Any] = [
		SettingsKey.controlUsers.rawValue: true,
		SettingsKey.usersToDisplay.rawValue: 5
	]
	
	@IBOutlet weak var controlUsersSwitch: UISwitch!
	@IBOutlet weak var usersValueLabel: UILabel!
	@IBOutlet weak var usersSlider: UISlider!
	
	
	@IBAction func sliderValueChanged(_ sender: UISlider) {
		usersValueLabel.text = String(Int(sender.value))
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//usersValueLabel.text = String(Int(usersSlider.value))
		//loadSettings()
		updateUIbased(on: currentSettings)
		
    }
	

	
	private func updateUIbased(on settings: [String: Any]) {
		guard
			let controlUser = settings[SettingsKey.controlUsers.rawValue] as? Bool,
			let usersToDisplay = settings[SettingsKey.usersToDisplay.rawValue] as? Int
			else { return }
		
		self.controlUsersSwitch.isOn = controlUser
		self.usersValueLabel.text = String(usersToDisplay)
		self.usersSlider.value = Float(usersToDisplay)
	}
	
	
	private func getCurrentSettings() -> [String: Any] {
		return defaults.dictionary(forKey: settingsKey) ?? defaultSettings
	}
	
	
	private func saveSettings() {
		let settings: [String: Any?] = [
			SettingsKey.controlUsers.rawValue: controlUsersSwitch.isOn,
			SettingsKey.usersToDisplay.rawValue: Int(usersSlider.value)]
		
		defaults.set(settings, forKey: settingsKey)
		
		showSaveAlertOnMainThread()
	}
	
	
	private func resetSettings() {
		defaults.removeObject(forKey: settingsKey)
		updateUIbased(on: defaultSettings)
	}
	
	func showSaveAlertOnMainThread() {
		print(#function)
		DispatchQueue.main.async {
			let alertController = UIAlertController(title: "Saved Settings", message: nil, preferredStyle: .alert)
			let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel, handler: nil)
			alertController.addAction(dismissAction)
			self.present(alertController, animated: true, completion: nil)
		}
	}
	
	
	override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//		guard indexPath.section == 2 else { return }
//		saveSettings()
		
		// implementation through table view controller and static cells not ideal...
		switch indexPath.section {
			case 2: saveSettings()
			case 3: resetSettings() // add alert about reseting
			default: return
		}
	}
}
