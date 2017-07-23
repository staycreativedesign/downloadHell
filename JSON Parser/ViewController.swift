//
//  ViewController.swift
//  JSON Parser
//
//  Created by Gustavo Pares on 7/19/17.
//  Copyright Â© 2017 Gustavo Pares. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  var boughtDecks = [Deck]()
  var totalCards = [String]()
  
  var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
  
  @IBOutlet weak var testImage: UIImageView!
  
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
        guard let deckDescription = deck["description"] as? String        else { return print("no deck description") }
        guard let deckImage = deck["deckImage"]         as? String        else { return print("no deck image") }
        guard let deckBgImage = deck["deckBgImage"]     as? String        else { return print("no deck image bg")}
        
        guard let cards = deck["cards"]!                as? [[String: String]]  else { return  print("error in cards")}
        
        for card in cards {
          let currentCard = card["name"]
          totalCards.append(currentCard!)
          
        }
        
        
        checkForDirectoryOrFile(name: "decks/\(deckName)", type: "dir")
        
        let deckImageUrl =    downloadFile(location: deckImage, saveAt: deckName, fileName: "deckImage.jpg")
        let deckBgImageUrl =  downloadFile(location: deckBgImage, saveAt: deckName, fileName: "descriptionBg.jpg")
        
        print(deckImageUrl)
        guard let deckBgImagePath = UIImage(data: deckBgImageUrl as Data) else { return print("printing deckBgImagePath return statement") }
        guard let deckImagePath =   UIImage(data: deckImageUrl as Data)   else { return print("printing deckImagePath return statement") }
        
        let finalizedDeck = createDeck(withName: deckName, withCards: totalCards, description: deckDescription, deckImage: deckImagePath, descriptionBg: deckBgImagePath)
        boughtDecks.append(finalizedDeck)
      }
      
    }
    catch {
      print(error.localizedDescription)
    }
  }
  
  
  
  
  
  
  func downloadFile(location: String, saveAt: String, fileName: String) -> NSData {
    var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let dir = paths[0]
    let toSaveAt = dir + "/decks/" + saveAt
    let loc = URL(string: location)
    var imageURL = NSData()
    
    let filePath = URL(fileURLWithPath: toSaveAt).appendingPathComponent(fileName).path
    
    
    let task = URLSession.shared.dataTask(with: loc!) { (data, response, error) in
      if ( error != nil) {
        print(error!.localizedDescription)
      }
        
      else {
        FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
        
        imageURL = NSData(contentsOfFile: filePath)!
        
      }
    }
    task.resume()
    print(imageURL)
    return imageURL
  }
  
  func createDirectory(withName name: String) {
    let fm = FileManager.default
    let dirPath = fm.urls(for: .documentDirectory, in: .userDomainMask)
    let docsURL = dirPath[0]
    let deckPath = docsURL.appendingPathComponent(name)
    
    do {
      try fm.createDirectory(at: deckPath, withIntermediateDirectories: true, attributes: nil)
    }
    catch {
      print(error.localizedDescription)
    }
  }

  
  
  
  func checkForDirectoryOrFile(name: String, type: String) {
    var directory: ObjCBool = ObjCBool(true)
    let newDir = paths[0] + "/" + name
    let exists: Bool = FileManager.default.fileExists(atPath: newDir, isDirectory: &directory)
    print(newDir)
    if exists && directory.boolValue {
    }
    else if exists {
    }
      
    else {
      if type == "dir" {
        createDirectory(withName: name)
      }
      else {
        downloadFileJson(location: "https://api.myjson.com/bins/9k38b.json", fileName: "files.json")
      }
    }
  }
  
  
  func downloadFileJson(location: String, fileName: String) {
    var paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
    let dir = paths[0]
    let toSaveAt = dir + "/"
    let loc = URL(string: location)
    let filePath = URL(fileURLWithPath: toSaveAt).appendingPathComponent(fileName).path
    
    
    let task = URLSession.shared.dataTask(with: loc!) { (data, response, error) in
      if ( error != nil) {
        print(error!.localizedDescription)
      }
        
      else {
        FileManager.default.createFile(atPath: filePath, contents: data, attributes: nil)
        
      }
    }
    task.resume()
  }

  
  
  
  
  
  
}
