//
//  Deck.swift
//  PassingInfoToSegue
//
//  Created by Gustavo Pares on 7/5/17.
//  Copyright © 2017 Gustavo Pares. All rights reserved.
//

import UIKit


//let questions = ["cachorro", "gato", "galinha", "pomba", "bicicleta", "motoboy", "Skank", "Jaspion", "Jiraya", "Xuxa", "Angelica", "Mara Maravilha", "Gugu", "Silvio Santos", "Panico", "Ayrton Senna", "Guga", "Pica Pau Amarelo", "Kid Abelha", "Barão Vermelho", "Titás", "Biquíno Cavadão", "Capital Inicial", "Hortencia", "Paralamas do Sucesso", "Gasparzinho", "Chaves", "Scooby Doo", "Piu Piu e Frajola", "Tico e Teco", "Pantera Cor-de-Rosa", "Manda Chuva", "Zé Colmeia", "Gil Gomes", "Os Jetsons", "Cidade Alerta", "Traço Mágico", "Os Caça-Fantasmas", "Roberto Carlos", "Ki Suco", "Rede Globo", "Manchete", "SBT", "Bau da Felicidade", "Recruta Zero", "Homen-Aranha", "Boliche", "Santos", "Rio de Janeiro", "São  Paulo", "Santa Catarina", "Buddha", "Jesus Cristo", "Americano", "Alemão", "iPhone", "iPad", "Xiclete com Banana", "Raul Gil", "Fantastico", "Big Brother", "Pele", "Vladimir Putin", "Donald Trump", "Obama", "Lula", "Sabadão Sertanejo", "Lollapalooza", "Rock in Rio", "Arco e flecha", "Transito", "Garfo", "Faca", "Colher"]

let questions = [
  "Maça",
  "Banana",
  "Queijo",
  "Pimenta",
  "Sal",
  "Laranja",
  "Spaghetti",
  "Pizza",
  "Bolacha",
  "Flan",
  "Rodizio",
  "Sushi",
  "Queijo Quente",
  "Pastel de Carne",
  "Pastel de Queijo",
  "Coca Cola",
  "Fanta",
  "Guaraná",
  "Pão",
  "Pão de Queijo",
  "Pastel de Camarão",
  "Ervilha",
  "Abacate",
  "Abacaxi",
  "Acerola",
  "Açaí",
  "Azeitona",
  "Amêndoa",
  "Cacau",
  "Caju",
  "Carambola",
  "Cereja",
  "Espetinho",
  "Feijoada",
  "Feijão",
  "Goiaba",
  "Groselha",
  "Jabuticaba",
  "Jaca",
  "Kiwi",
  "Lima",
  "Limão",
  "Maçã",
  "Mamão",
  "Manga",
  "Maracujá",
  "Melancia",
  "Melão",
  "Morango",
  "Noz",
  "Pera",
  "Raviolli",
  "Pêssego",
  "Romã",
  "Tangerina",
  "Uva",
  "Vinho",
  "Salada",
  "Coxinha",
  "Brigadeiro",
  "Batata",
  "Batata frita",
  "Hamburger"
  
  
  
  
  
  

]

enum Outcome {
  case right
  case wrong
  case none
}

enum FileType {
  case json
  case image
}


struct Deck {
  var name = String()
  var cards = [Card]()
  var description = String()
  var deckImage = UIImage()
  var descriptionBg = UIImage()
		
}

struct Card {
  var name: String
  var outcome = Outcome.none
  var color: UIColor {
    switch self.outcome {
    case .wrong:
      return UIColor.red
    case .right:
      return UIColor.white
    default:
      return UIColor.red
    }
  }
  var alpha = Int()
}



func createDeck(withName name: String, withCards cards: [String], description: String, deckImage: UIImage, descriptionBg: UIImage) -> Deck{
  var deck = Deck(name: name, cards: [Card](), description: description, deckImage: deckImage, descriptionBg: descriptionBg)
  
  for name in cards {
    deck.cards.append(Card(name: name, outcome: .none, alpha: 0))
  }
  
  return deck
}
