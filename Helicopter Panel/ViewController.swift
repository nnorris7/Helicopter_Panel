//
//  ViewController.swift
//  Helicopter Panel
//
//  Created by Norman Norris on 9/21/19.
//  Copyright © 2019 Norman Norris. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // MARK: - Outlets
    @IBOutlet var buttons: [CustomButton]!
    @IBOutlet weak var bgImageView: UIImageView!
    
    //MARK: - Model - holds all the json info in a custom class
    var panelButtons = [PanelButton]()

    // MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // load the json from the panel file into the panelButtons variable
        loadJSON()
        
        // loop through all the buttons and set their title and tag (number)
        for index in buttons.indices {
            let button = buttons[index]
            button.setTitle(panelButtons[index].name, for: .normal)
            button.tag = panelButtons[index].id
        }
    }
    
    //MARK: - load the json data
    func loadJSON() {
        if let path = Bundle.main.url(forResource: "panel", withExtension: "json") {
            do {
                let data = try Data(contentsOf: path, options: .mappedIfSafe)
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                do {
                    panelButtons = try decoder.decode([PanelButton].self, from: data)
                } catch {
                    print(error.localizedDescription)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    // MARK: - Target/action methods
    @IBAction func hideBackground(_ sender: UIButton) {
        if sender.titleLabel?.text == "Hide Background" {
            bgImageView.isHidden = true
            sender.setTitle("Show Background", for: .normal)
        } else {
            bgImageView.isHidden = false
            sender.setTitle("Hide Background", for: .normal)
        }
    }
    
    @IBAction func showProcedure(_ sender: UIButton) {
        // get a handle to the popover view
        guard let popVC = storyboard?.instantiateViewController(withIdentifier: "popVC") as? PopoverViewController else { return }
        
        // get the tag (number) of the button that was tapped so you can get its procedure text
        let index = sender.tag
        popVC.procedureText = panelButtons[index].procedure
        
        // set some popover attribures and present the view
        popVC.modalPresentationStyle = .popover
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = sender

        self.present(popVC, animated: true)

        // reset the button that was tapped
        let button = sender as! CustomButton
        button.resetButton()
        
        // reset the other linked buttons
        for buttonNumber in panelButtons[index].linkedButtons {
            let button = buttons[buttonNumber]
            button.resetButton()
        }
    }
    
    @IBAction func randomAlert(_ sender: Any) {
        // reset all buttons back to black/white original state
        for index in buttons.indices {
            let button = buttons[index]
            button.resetButton()
        }

        // get a random number/button
        let index = Int.random(in: 0..<panelButtons.count)
        
        // get the panelButton for the random number and set its colour according to its warning colour value
        if panelButtons[index].warningColour == "red" {
            buttons[index].turnButtonRed()
        } else {
            buttons[index].turnButtonYellow()
        }

        // cycle through the linked buttons array for the selected (random) button and set their warning colour as well
        for buttonNumber in panelButtons[index].linkedButtons {
            if panelButtons[buttonNumber].warningColour == "red" {
                buttons[buttonNumber].turnButtonRed()
            } else {
                buttons[buttonNumber].turnButtonYellow()
            }
        }
    }
}

