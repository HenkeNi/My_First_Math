//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation


// TODO:
// Impossible lvl:

// I card klassen lägg till om addision, div etc... som property?



// LÄgg till att playableCards roterar smatidigt // När playableCards byttas ut till nya (ny lvl) ska dem snurra.. kanske när spelet börjar med?? (inte snurra två ggr, tex. ett redan vänt kort)

// TODO: Korten vänds automatiskt tillbaka efter man tryckt på dem?! (lägg logiken i klassen -> efter fördröjning om isFlipped = true - flippa tillbaka)


// LÄGG Till function som returnerar cuurentEquationCards som en array av mathCards?? [MathCard]()



// GÖr en klass, playableCards?? Innehåller 5 MathCards
// End Condition: Efter Impossible -> Alert (Du har klarat spelet: 1. Gå tillbaka 2. Fortsätt spela)


// Division:

// Score/Highscore
// fixa score (mer beroende på svårighets grad)


// Fixa lite med multiplikationen, nummren (inte bara 8 X 1 osv), 9 x ? = 7 funkar inte!!

// Kolla så att alla modes samt lvls fungerar...


// TODO: lägg till högre svar i nivå 3: ex. 3 + ? = 10 (KVAR??)

// TODO: Fixa highscore (olika för dem olika räknesätten) -> Fixa speciell view för highscores!


// SKAPA EN sub KLASS AV UIVIEW (cardView klasse) innehåller ref till MathCard? Innehåller indexPosition med....


// HARDMODE:
// Progressbaren går långsammare tillbaka på lättare nivåer!?
// GÅ till nästa lvl om 10 rätt svar??
// Timmer som tickar på (mer tid kvar ger mer poäng)
// END CONDITIONS: 10 rätt på varje lvl?
// Score: Tid kvar && antal lvls/tal passerade (x / 10 på varje lvl.. om man svarar fel ska man inte kunna få högre score ex: 11/10)
// Live poäng??? Resetas poängen om man går tillbaka till lvl 1 ???
// Poäng som sakta tickar ner med?.


// KANSKE: FÖR MULTIplication: ENDAST HA RANDOMERADE NUMMER? istället för 1...5 eller 6...10!

// Kunna dra upp mer än ett kort? två rutor (en lite ovanför och till höger, sitter samman delvis)
// så man får [][] + 3 = 10 sen får man dra upp tex 4 och 2 eller 3 och 3?


// back button not working (VC presented in smaller window)



// TODO: Inte samma randomerade ekvaions tal i rad??? (spara sista svars siffra? Alt. spara senaste två randomerade talen)
// TODO: I addition (nivå1) lägg till '0';  1 + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)?



// TODO: Alert Rutan berättar när man kommit till ny nivå! -> KAnske, knapp man måste trycka först innan man går vidare?? Kanske fyverkerieffekter


// // Knapp för att slumpa fram ett nytt tal??



// SCORE BARA FÖR HARDMODE???
// TODO: highscore lista!, en för hardCore en för vanligt!

// Add Sound/Particle effects:
// rejected (wrong answer), correct answer, return sound (card dropped)
// Particle effects for finishing a lvl

// Memory Leaks
// Make all cards optional of Cards. Make them nil in deinit/viewDidDisappear
// TODO: sätt array av cards till optional eller sätt korten i arrayen till att vara optionals
// Använd structs istället för klasser?


// Försök använda; Generics, Closures, Computed Properties.....
// Generic cardClass?
// Läggga views, imageVeiws etc. i klassen?

// SKAPA CARDIMAGES programmetical




// BUGGAR:
// ANSWERVIEW FELVÄND NÄR DEN FÅR SIFFRA (IBLAND) (NÄSTA LEVEL)
// När man drar nytt kort efter att ha dragit fel; om för snabbt, resetas kortet automatiskt när man drar det....
// NIVÅ 5: Labels inte på rätt kort. Tag fel (image på fel kort)
// Kan svaret bli 5 på medel?


// BUGGAR SOM ÄR BORTA?
// Card vände sig på fel håll efter rätt svar (cardOirginalPositionc)


// Refactoring:
// Names: CardOptions, playableCards, cardHand, bottomCards, btmCardHand, bottomCardHand, bottomMathCards, btmMathCards

let nxtLvlNotificationKey = "co.HenrikJangefelt.nxtLvl"


// TODO: RENAME: BasicMathVC? || EquationsVC || MathEquationsVC
class EasyMathVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var progressBarViewBackground: UIView!
    @IBOutlet weak var progressBarContainer: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBarWidth: NSLayoutConstraint!
    @IBOutlet weak var scoreLabel: UILabel! // Gör i kod?
    
    @IBOutlet var operatorCardViews: [UIView]! // UIViews; Math operator + Equal sign
    @IBOutlet var operatorCardImages: [UIImageView]!
    
    @IBOutlet var equationCardViews: [UIView]! // UIViews; Numbers in equation + View for Answer
    @IBOutlet var equationCardImages: [UIImageView]!
    @IBOutlet var equationCardLabels: [UILabel]!
    
    @IBOutlet var playableCardViews: [UIView]! // UIViews; Bottom Cards
    @IBOutlet var playableCardImages: [UIImageView]!
    @IBOutlet var playableCardLabels: [UILabel]!
    
    
    enum Difficulty: Int, CaseIterable {
        case easy = 1
        case medium
        case hard
        case veryHard
        case impossible
    }
    
    
    var equationCards: MathCards?
    var playableCards: MathCards?
    
    //var equationCards = [MathCard]() // TODO: property in object (isTopCard)
    //var playableCards = [MathCard]() // TODO: Make optional?? ([MathCard?]), sätt arrayen till empty i deinit
    var currentDifficulty = Difficulty.impossible
    var mathMode = CalculationMode.addition
    var hardModeEnabled: Bool = false
    var audioPlayer: AVAudioPlayer?
    var calculator: Calculator?
    var numberRandomizer: NumberRandomizer?
    var score = 0
    
    
    
    var randomAnswerViewIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().isExclusiveTouch = true // Disable multi touch
        calculator = Calculator()
        playableCards = MathCards(amountOfCards: 5)
        equationCards = MathCards(amountOfCards: 3)
        addImgTapGesture(cardImages: playableCardImages, isPlayableCardImage: true)
        addImgTapGesture(cardImages: equationCardImages, isPlayableCardImage: false)
        
        updateAnswerView()
        updateEquationCards()
        updatePlayableCards()
        createObserver()
        
        if hardModeEnabled { setupHardmodeConfigurations() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setBackgroundColors(mathMode: mathMode)
        setOperatorImages(mathMode: mathMode)        
        customizeCards(cardViews: playableCardViews)
        customizeCards(cardViews: equationCardViews)
        customizeCards(cardViews: operatorCardViews)
        sortOutletCollections()
        
        title = mathMode.rawValue // Sets title based on CalculationMode enum
    }
    
    override func viewDidAppear(_ animated: Bool) {
        savePlayableCardViewPositions() // Saves the original position of the bottom cards
    }
    
    
    func sortOutletCollections() {
           playableCardViews.sort(by: { $0.tag < $1.tag })
           playableCardImages.sort(by: { $0.tag < $1.tag })
           playableCardLabels.sort(by: { $0.tag < $1.tag })
           equationCardViews.sort(by: { $0.tag < $1.tag })
           equationCardImages.sort(by: { $0.tag < $1.tag })
           equationCardLabels.sort(by: { $0.tag < $1.tag })
           operatorCardImages.sort(by: { $0.tag < $1.tag })
    }
    
    func createObserver() {
        
        let name = Notification.Name(rawValue: nxtLvlNotificationKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EasyMathVC.updateLevel(notification:)), name: name, object: nil)
    }

    
    @objc func updateLevel(notification: NSNotification) {
        randomAnswerViewIndex = nil
        updateAnswerView()
        updateEquationCards()
        updatePlayableCards()
        returnCardViewsToOriginalPosition()
        disableOrEnableCardInteractions(shouldDisable: false)
        updateScoreLabel()
    }
    
    
    func updateAnswerView() {
        
        equationCards?.setAnswerViewIndex(answerViewIndex: getAnswerViewIndex())
        //setIsAnswerViewProperty(currentIndex: getAnswerViewIndex())
        hideAnswerViewLabel(answerViewIndex: getAnswerViewIndex())
    }
    
    func updateEquationCards() {
        
        if let cards = equationCards?.cards {
            flipCardsBack(cards: cards, cardViews: equationCardViews)
            setNewEquationNumbers()
            setCardLabels(cards: cards, cardLabels: equationCardLabels)
            newCardTransitionFlip(cardViews: equationCardViews)
            setCardImages(cards: cards, cardImages: equationCardImages)
        }
    }
  
    func updatePlayableCards() {
        
        if let cards = playableCards?.cards {
            flipCardsBack(cards: cards, cardViews: playableCardViews)
            setPlayableCardsNumber()
            setCardImages(cards: cards, cardImages: playableCardImages)
            setCardLabels(cards: cards, cardLabels: playableCardLabels)
        }
    }
    
   
    
 
     
    
    // Returns correct answerView index/position for current difficulty
    func getAnswerViewIndex() -> Int {
        switch currentDifficulty {
        case .easy:
            return 2
        case .medium:
            return 2
        case .hard:
            return 1
        case .veryHard:
            return 0
        case .impossible:
            
            // TODO: ÄNDRA /eller/ EGEN FUNKTION
            if randomAnswerViewIndex != nil {
                if let randomAnswerViewIndex = randomAnswerViewIndex { return randomAnswerViewIndex }
            } else {
                randomAnswerViewIndex = Int.random(in: 0...2)
                
                if let randomAnswerViewIndex = randomAnswerViewIndex { return randomAnswerViewIndex}
            }
            return randomAnswerViewIndex!
        }
    }
    
    
     // Sets correct number of playableCards based on level
      func setPlayableCardsNumber() {
          
        for (index, n) in getPlayableCardNumbers().enumerated() {
            playableCards?.cards[index].number = n
        }
        
//          if let playableCards = playableCards?.cards {
//
//              for (index, n) in getPlayableCardNumbers().enumerated() {
//                  playableCards[index].number = n
//              }
//          }
      }
    
    
    // LÄGG I KLASSEN???
    func setNewEquationNumbers() {
                        
        if let equationCards = equationCards?.cards {
            
            let equationNumbers = getRandomizedEquationNumbers()
            let filteredEquationCards = equationCards.filter { !$0.isAnswerView }
                
            for (index, card) in filteredEquationCards.enumerated() {
                card.number = equationNumbers[index]
            }
        }
    }
    
    
    // TODO: FIX IMPOSSIBLE
    func getRandomizedEquationNumbers() -> [Int] {

//    func getRandomizedEquationNumbers() -> (firstNumber: Int, secondNumber: Int) {
        
        let numberRandomizer = NumberRandomizer()
        var condition: (Int, Int) -> Bool
        
        switch (currentDifficulty, mathMode) {
        case (.easy, .addition):
            condition = numberRandomizer.easyAdditionCondition
        case (.medium, .addition):
            condition = numberRandomizer.mediumAdditionContidion
        case (.hard, .addition):
            condition = numberRandomizer.hardAdditionCondition
        case (.veryHard, .addition):
            condition = numberRandomizer.veryHardAdditionConditio
        case (.impossible, .addition):
            //condition = getAnswerViewIndex() == 2 ? numberRandomizer.impossibleAdditionCondition1 : numberRandomizer.impossibleAdditionCondition2
            condition = getImpossibleRandomizerCondition(numberRandomizer: numberRandomizer)
            
        case (.easy, .subtraction):
            condition = numberRandomizer.easySubtractionCondition
        case (.medium, .subtraction):
            condition = numberRandomizer.mediumSubtractionCondition
        case (.hard, .subtraction):
            condition = numberRandomizer.hardSubtractionCondition
        case (.veryHard, .subtraction):
            condition = numberRandomizer.veryHardSubtractionCondition
        case (.impossible, .subtraction):
            condition = numberRandomizer.impossibleSubtractionCondition
            
        case (.easy, .multiplication):
            condition = numberRandomizer.easyMultiplicationCondition
        case (.medium, .multiplication):
            condition = numberRandomizer.mediumMultiplicationCondition
        case (.hard, .multiplication):
            condition = numberRandomizer.hardMultiplicationCondition
        case (.veryHard, .multiplication):
            condition = numberRandomizer.veryHardMultiplicationCondition
        case (.impossible, .multiplication):
            condition = numberRandomizer.impossibleMultiplicationCondition
        }
        return numberRandomizer.numberRandomizer(condition: condition)
    }
    
    
    func getImpossibleRandomizerCondition(numberRandomizer: NumberRandomizer) -> (Int, Int) -> Bool {
        
        return getAnswerViewIndex() == 2 ? numberRandomizer.impossibleAdditionCondition1 : numberRandomizer.impossibleAdditionCondition2
    }
    
    
    
    // Returns number for playableCard based on lvl and mathMode
    func getPlayableCardNumbers() -> [Int] {

        switch (currentDifficulty, mathMode)  {
            
        case (.easy, .addition), (.hard, .addition), (.easy, .multiplication), (.hard, .multiplication):
            return [1, 2, 3, 4, 5]
        case (.medium, .addition), (.veryHard, .addition), (.medium, .multiplication), (.veryHard, .multiplication):
            return [6, 7, 8, 9, 10]
        case (.easy, .subtraction), (.hard, .subtraction):
            return [0, 1, 2, 3, 4]
        case (.medium, .subtraction), (.veryHard, .subtraction):
            return [5, 6, 7, 8, 9]
        case (.impossible, .addition), (.impossible, .multiplication), (.impossible, .subtraction):
             
            if randomAnswerViewIndex == nil {
                      var tempArray = [Int]()
                      
                      if let playabelCards = playableCards?.cards {
                          for card in playabelCards {
                              tempArray.append(card.number)
                          }
                      }
                      return tempArray
                  } else {
                      print("UPDATING AGAIN")
                      return getImpossibleplayableCardNumbers()
                  }
            
        }
    }
    
    
    
    func getImpossibleplayableCardNumbers() -> [Int] {
        
        var numbs = [Int]()
            
        repeat {
            
            numbs.removeAll()
            
            for _ in 1...5 {
                let n = Int.random(in: 1...10)
                if !numbs.contains(n) {
                    numbs.append(n)
                }
            }
        } while numbs.count < 5 || !checkImpossibleNumbers(numbers: numbs)//!checkNumbers(numbers: numbs)
        
        return numbs.sorted()
    }
    
    func checkImpossibleNumbers(numbers: [Int]) -> Bool {
        if let calc = calculator {
            
            for i in numbers {
                let numbs = getNumbersInEquation(chosenNumber: i)
                                   
                let result = calc.validateMathResult(calcMode: getCalculationMode(calc: calculator!), firstNumb: numbs.firstNumber, secondNumb: numbs.secondNumber, resultNumb: numbs.resultNumber)
                                   
                if result { return true }
            }
        }
        return false
    }
    
    

    
    
    
    
 
    
    
    
    
    

    
    
    
    
      // Increase or decrease difficulty base on input
      func updateDifficulty(difficulty: Int) -> Difficulty {
          
          switch difficulty {
          case 1:
              return .easy
          case 2:
              return .medium
          case 3:
              return .hard
          case 4:
              return .veryHard
          case 5:
              return .impossible
          default:
              return .easy
          }
      }
      
    
      
      

    
    
    
    
    
    
    // Hides label for answerView
    func hideAnswerViewLabel(answerViewIndex: Int) {
        for (index, label) in equationCardLabels.enumerated() {
            label.isHidden = answerViewIndex == index ? true : false
        }
    }
    
    // Flips equations card and shows new ones
    func newCardTransitionFlip(cardViews: [UIView]) {
        for cardView in cardViews where cardView != equationCardViews[getAnswerViewIndex()] {
            
            cardView.flipView(duration: 0.6)
            //UIView.transition(with: cardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    // TODO: kolla närmare om den kan kombineras med någon annan funktion
    func flipCardsBack(cards: [MathCard], cardViews: [UIView]) {
        
        for (index, card) in cards.enumerated() where card.isFlipped && !card.isAnswerView {
            
            cardViews[index].flipView(duration: 0.6)
            card.isFlipped = false
            //card.flipCard(cardView: cardViews[index], duration: 0.6)
        }
    }
    
    // Resets the cardViews to their original position
    // returnPlayableCardViewsPosition
    func returnCardViewsToOriginalPosition() {
        
        for (index, view) in playableCardViews.enumerated() {
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                //view.center = self.playableCards[index].originalPosition!

                //if let position = self.playableCards[index].position {
                if let position = self.playableCards?.cards[index].position {
                    view.center.x = CGFloat(position.xPosition)
                    view.center.y = CGFloat(position.yPosition)
                }
          
            })
        }
    }
    
    // Saves original position for cards
    // Put in extension of UIView (save view position??)
    func savePlayableCardViewPositions() {
        
        for (index, view) in playableCardViews.enumerated() {
            //playableCards[index].originalPosition = view.center
            if let playableCards = playableCards?.cards[index] {
                playableCards.position = CardPosition(xPosition: Double(view.center.x), yPosition: Double(view.center.y))
            }
            
            //playableCards[index].position = CardPosition(xPosition: Double(view.center.x), yPosition: Double(view.center.y))
        }
    }
    
    // Disable or enable card(s) interactions
    func disableOrEnableCardInteractions(shouldDisable: Bool) {
        
        for cardView in playableCardViews {
            cardView.isUserInteractionEnabled = shouldDisable ? false : true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        playableCards = nil
        calculator = nil
        audioPlayer = nil
        numberRandomizer = nil
    }
    
    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}






    
    
        





// TODO: CHECK THIS!!!!, DONT FORCE UNWRAP IN function call!!??
// Prevents getAnswerViewindex from randomizing impossible lvl again
//       func getCurrentAnswerViewIndex() -> Int? {
//           for (index, card) in equationCards.enumerated() {
//               return index
//           }
//           return nil
//       }
