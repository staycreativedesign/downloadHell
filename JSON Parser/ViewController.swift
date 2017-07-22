//
//  ViewController.swift
//  JSON Parser
//
//  Created by Gustavo Pares on 7/19/17.
//  Copyright © 2017 Gustavo Pares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
//  var boughtDecks = [Deck]()
  var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    checkForDirectoryOrFile(name: "decks", type: "dir")
    checkForDirectoryOrFile(name: "files.json", type: "file")
    
    let fm = FileManager.default
    let docsUrl = try! fm.url(for:.documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
    let filesJsonPath = docsUrl.appendingPathComponent("files.json")
    
    
    do {
      print("started")
      let data = try Data(contentsOf: filesJsonPath)
      let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
      let array = json as? [Any]
      
      
      
      for obj in array! {
        guard let deck = obj                            as? [String: Any] else { return print("no deck object") }
        guard let deckName = deck["name"]               as? String        else { return print("no deck name") }
//        guard let deckDescription = deck["description"] as? String        else { return print("no deck description") }
        guard let deckImage = deck["deckImage"]         as? String        else { return }
        guard let deckBgImage = deck["deckBgImage"]     as? String        else { return }
//        guard let cards = deck["cards"]!                as? [[String: String]]    else { return }
        
        checkForDirectoryOrFile(name: "decks/\(deckName)", type: "dir")
        downloadFile(location: deckImage, saveAt: deckName, fileName: "deckImage.jpg")
        downloadFile(location: deckBgImage, saveAt: deckName, fileName: "descriptionBg.jpg")
        
      }
      
    }
    catch {
        print(error.localizedDescription)
    }
    
//        TODO
//        guard let cards = deck["cards"]! as? [[String: String]] else { return }
//        
//        for card in cards {
//          let currentCard = card["name"]
//          print(currentCard!)
//          totalCards.append(currentCard!)
//          
//        }
//        
//        
//        // create deck
////        let finalizedDeck = createDeck(withName: deckName, withCards: totalCards, description: deckDescription, deckImage: deckImage, descriptionBg: deckBgImage)
//        
//       
//        
//      
//      
//        // add deck to decks array
////        boughtDecks.append(finalizedDeck)
//      }
//    } catch {
//      print(error)
//    }
  }
  
  

  
  
  
  func downloadFile(location: String, saveAt: String, fileName: String) {
    var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let dir = paths[0]
    
    let loc = URL(string: location)

    
    let saveAt = dir + "/" + saveAt + "/" + fileName
    
    
    let task = URLSession.shared.dataTask(with: loc!) { (data, response, error) in
      print("started downloading and saving at \(saveAt)")
      if ( error != nil) {
        print("//////////////////////////////////////// error")
        print(error!.localizedDescription)
      }
        
      else {
        print("finished downloading \(fileName)")
        FileManager.default.createFile(atPath: saveAt, contents: data, attributes: nil)
      }
    }
    task.resume()
  }
  
  func createDirectory(withName name: String) {
    let fm = FileManager.default
    let dirPath = fm.urls(for: .documentDirectory, in: .userDomainMask)
    let docsURL = dirPath[0]
    let deckPath = docsURL.appendingPathComponent(name)
    
    do {
      try fm.createDirectory(at: deckPath, withIntermediateDirectories: true, attributes: nil)
      print("created")
    }
    catch {
      print("//////////////////////////////////////// error")
      print(error.localizedDescription)
    }
  }
  
  
  
  
  func checkForDirectoryOrFile(name: String, type: String) {
    var directory: ObjCBool = ObjCBool(true)
    let newDir = paths[0] + "/" + name
    let exists: Bool = FileManager.default.fileExists(atPath: newDir, isDirectory: &directory)
      print(newDir)
      print("///////////////////////")
    if exists && directory.boolValue {
      print("directory exists")
    }
    else if exists {
      print("file exists")
    }

    else {
      print("file or directory does not exist")
      if type == "dir" {
        createDirectory(withName: name)
        print("\(name) directory created")
      }
      else {
        downloadFile(location: "https://api.myjson.com/bins/9k38b.json", saveAt: "", fileName: "files.json")
      }
    }
  }
}

