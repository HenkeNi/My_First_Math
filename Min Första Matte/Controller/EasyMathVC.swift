//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation

// App kraschar imps subtraction (kolla andr subtra lvl med) - ibland efter många tal...

// Update score - vid fel svar... (vid hardMode updatera scorelabel efter kortet åkt tillbaka..)
// Return card funktionen kallas på för tidigt när man updaterar scoreLabel eller timeLabel

// HARDMODE:
// End condition: efter timers slut får man se sin poäng (samt highscore lista??) -> välja gå tillbaka eller börja om


// TODO: I addition (nivå1) lägg till '0';  1 + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)?

// Score/Highscore
// TODO: Fixa highscore (olika för dem olika räknesätten) -> Fixa speciell view för highscores!
// fixa score (mer beroende på svårighets grad)

// SCORE BARA FÖR HARDMODE???
// TODO: highscore lista!, en för hardCore en för vanligt!

// Division:
// Fixa lite med multiplikationen, nummren (inte bara 8 X 1 osv), 9 x ? = 7 funkar inte!!

// End Condition: Efter Impossible -> Alert (Du har klarat spelet: 1. Gå tillbaka 2. Fortsätt spela)

// I MathCard klassen lägg till om addision, div etc... som property?

// KANSKE: FÖR MULTIplication: ENDAST HA RANDOMERADE NUMMER? istället för 1...5 eller 6...10!

// Maybe implement: CardViews will automatically flip back after being flipped (after small delay)??
// Maybe implement: lvl where you drag up two cards either next to each other (2&1 + 2 = 5 ) or like (? + ? = 5) || (5 + ? = ?) etc.


// FÖRSÖK ANVÄNDA:
// equatable protocol (== mellan två objekt)
// map (loopa över en collection of utföra samma sak på varje element)
// Nil coalescing operator (optionalA ?? defaultValue)
// TODO: Alert Rutan berättar när man kommit till ny nivå! -> KAnske, knapp man måste trycka först innan man går vidare?? Kanske fyverkerieffekter


// Memory Leaks
// Make all cards optional of Cards. Make them nil in deinit/viewDidDisappear
// TODO: sätt array av cards till optional eller sätt korten i arrayen till att vara optionals
// Använd structs istället för klasser?


// Försök använda; Generics, Closures, Computed Properties, map, filter.....
// Generic cardClass?
// Läggga views, imageVeiws etc. i klassen?


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
    
    @IBOutlet weak var timerLabel: UILabel!
    
    enum Difficulty: Int, CaseIterable {
        case easy = 1
        case medium
        case hard
        case veryHard
        case impossible
    }
    
    var equationCards: MathCards?
    var playableCards: MathCards?
    var currentDifficulty = Difficulty.easy
    var mathMode = CalculationMode.addition
    var hardModeEnabled: Bool = false // RENAME: COMPETITIVE MODE?? Competition ,
    var audioPlayer: AVAudioPlayer?
    var calculator: Calculator?
    var numberRandomizer: NumberRandomizer?
    var score = 0
    
    
    var randomAnswerViewIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().isExclusiveTouch = true // Disable multi touch
        calculator = Calculator()
        numberRandomizer = NumberRandomizer()
        playableCards = MathCards(amountOfCards: 5)
        equationCards = MathCards(amountOfCards: 3)

        addImgTapGesture(cardImages: playableCardImages, isPlayableCardImage: true)
        addImgTapGesture(cardImages: equationCardImages, isPlayableCardImage: false)
        
        updateAnswerView()
        //updatePlayableCards()
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
    
    override func viewDidDisappear(_ animated: Bool) {
        removeInstances()
    }
    
    
    func sortOutletCollections() {
            // sort { $0.tag < $1.tag }??
           playableCardViews.sort(by:  { $0.tag < $1.tag })
           playableCardImages.sort(by: { $0.tag < $1.tag })
           playableCardLabels.sort(by: { $0.tag < $1.tag })
           equationCardViews.sort(by:  { $0.tag < $1.tag })
           equationCardImages.sort(by: { $0.tag < $1.tag })
           equationCardLabels.sort(by: { $0.tag < $1.tag })
           operatorCardImages.sort(by: { $0.tag < $1.tag })
    }
    
    func createObserver() {
        
        let name = Notification.Name(rawValue: nxtLvlNotificationKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EasyMathVC.updateLevel(notification:)), name: name, object: nil)
    }

    
    @objc func updateLevel(notification: NSNotification) {
        updateNextLevel()
    }
    
    func updateNextLevel() {
        randomAnswerViewIndex = nil
        updateAnswerView()
        //updatePlayableCards()
        updateEquationCards()
        updatePlayableCards()
        returnCardViewsToOriginalPosition()
        disableCardInteractions(shouldDisable: false)
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
            flipNewPlayableCards()
            setCardImages(cards: cards, cardImages: playableCardImages)
            setCardLabels(cards: cards, cardLabels: playableCardLabels)
        }
    }
    
    
    // randomAnswerViewIndex prevents flip if progressbar is first above 0 then 0 after wrong answer..
    func flipNewPlayableCards() {
        //if randomAnswerViewIndex != nil && progressBarWidth.constant == 0 || currentDifficulty == .impossible {
        if randomAnswerViewIndex == nil && progressBarWidth.constant == 0 || currentDifficulty == .impossible {
            newCardTransitionFlip(cardViews: playableCardViews)
        }
    }
   
    
    
    

    
    
     // Sets correct number of playableCards based on level
      func setPlayableCardsNumber() {
          
        for (index, n) in getPlayableCardNumbers().enumerated() {
            playableCards?[index].number = n
        }
      }
    
    
    // LÄGG I KLASSEN???
    func setNewEquationNumbers() {
                        
        if let equationCards = equationCards?.cards, let equationNumbers = getRandomizedEquationNumbers() {
            
            //let equationNumbers = getRandomizedEquationNumbers()
            let filteredEquationCards = equationCards.filter { !$0.isAnswerView }
                
            for (index, card) in filteredEquationCards.enumerated() {
                card.number = equationNumbers[index]
            }
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
            return getImpossibleLvlAnswerViewIndex() // TODO: rename getRandomIndex
        }
    }
    
    func getImpossibleLvlAnswerViewIndex() -> Int {
        
        if randomAnswerViewIndex != nil {
            return randomAnswerViewIndex!
        } else {
            randomAnswerViewIndex = Int.random(in: 0...2)
            return randomAnswerViewIndex!
        }
    }
    
    
    
    
    func doAfterDelay(delay: DispatchTime, task: () -> ()) {
        
    }
    
    
    
//    func randomizeEquationNumbers(minValue: Int, maxValue: Int) -> [Int]? {
//
//        guard let numberRandomizer = numberRandomizer else { return nil }
//
//        switch (mathMode, currentDifficulty) {
//
//        case (.addition, .easy), (.addition, .medium):
//            return numberRandomizer.randomizeNumbers { $0 + $1 >= minValue && $0 + $1 <= maxValue }
//        case (.addition, .hard), (.addition, .veryHard):
//            return numberRandomizer.randomizeNumbers { $1 - $0 >= minValue && $1 - $0 <= maxValue}
//        case (.addition, .impossible):
//            let condition = getAnswerViewIndex() == 2 ? numberRandomizer.impossibleAdditionCondition1 : numberRandomizer.impossibleAdditionCondition2
//            return numberRandomizer.randomizeNumbers(condition: condition)
//        case (.subtraction, .easy), (.subtraction, .medium), (.addition, .hard), (.addition, .veryHard):
//            return numberRandomizer.randomizeNumbers { $0 - $1 >= minValue && $0 - $1 <= maxValue }
//        default:
//            return nil
//        }
//    }
    
    
    // JSON???!
    // TODO: FIX IMPOSSIBLE
    // Sätt minValue = playableCards[0] max playableCarsd [4]???
    func getRandomizedEquationNumbers() -> [Int]? {
        
        guard let numberRandomizer = numberRandomizer else { return nil }
        
//        // ADDITION
//        if currentDifficulty == .impossible {
//            return nil
//        } else {
//            print(playableCards![0].number)
//            print(playableCards![4].number)
//            return randomizeEquationNumbers(minValue: playableCards![0].number, maxValue: playableCards![4].number)
//
//        }
        
        
        var condition: (Int, Int) -> Bool

        switch (currentDifficulty, mathMode) {
        case (.easy, .addition):
            //return randomizeEquationNumbers(minValue: 1, maxValue: 5)
            condition = numberRandomizer.easyAdditionCondition
        case (.medium, .addition):
            condition = numberRandomizer.mediumAdditionContidion
        case (.hard, .addition):
            condition = numberRandomizer.hardAdditionCondition
        case (.veryHard, .addition):
            condition = numberRandomizer.veryHardAdditionConditio
        case (.impossible, .addition):
            //condition = getAnswerViewIndex() == 2 ? numberRandomizer.impossibleAdditionCondition1 : numberRandomizer.impossibleAdditionCondition2
            condition = getImpossibleAdditionRandomizerCondition(numberRandomizer: numberRandomizer)

        case (.easy, .subtraction):
            condition = numberRandomizer.easySubtractionCondition
        case (.medium, .subtraction):
            condition = numberRandomizer.mediumSubtractionCondition
        case (.hard, .subtraction):
            condition = numberRandomizer.hardSubtractionCondition
        case (.veryHard, .subtraction):
            condition = numberRandomizer.veryHardSubtractionCondition
        case (.impossible, .subtraction):
            //condition = numberRandomizer.impossibleSubtractionCondition
            condition = getImpossibleSubtractionRandimizerCondition(numberRandomizer: numberRandomizer)
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
    
    
    
    func getImpossibleAdditionRandomizerCondition(numberRandomizer: NumberRandomizer) -> (Int, Int) -> Bool {
        
        return getAnswerViewIndex() == 2 ? numberRandomizer.impossibleAdditionCondition1 : numberRandomizer.impossibleAdditionCondition2
    }
    
    
    func getImpossibleSubtractionRandimizerCondition(numberRandomizer: NumberRandomizer) -> (Int, Int) -> Bool {
        
        switch getAnswerViewIndex() {
        case 0:
            return numberRandomizer.impossibleSubtractionCondition3
        case 1:
            return numberRandomizer.impossibleSubtractionCondition2
        case 2:
            return numberRandomizer.impossibleSubtractionCondition1
        default:
            return numberRandomizer.impossibleSubtractionCondition1 // FIX!
        }
    }
    
    
 
    
    
   

    // Split into different arithmetic??
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
             return randomAnswerViewIndex == nil ? playableCards!.cards.map({$0.number}) : getImpossibleplayableCardNumbers()
        }
    }
    
    func getImpossibleplayableCardNumbers() -> [Int] {
        
        var numbs = [Int]()
            
        repeat {
            
            numbs.removeAll()
            
            for _ in 1...5 {
                let n = Int.random(in: 1...10)
                
                if !numbs.contains(n) { numbs.append(n) }
            }
        } while numbs.count < 5 || !checkImpossibleNumbers(numbers: numbs)//!checkNumbers(numbers: numbs)
        
        return numbs.sorted()
    }
    
    
    
    // Verify impossible lvl playableCards
    func checkImpossibleNumbers(numbers: [Int]) -> Bool {
        if let calc = calculator {
            
            for i in numbers {
                let numbs = getNumbersInEquation(chosenNumber: i)
                
                return calc.validateMathResult(firstNumb: numbs.firstNumber, secondNumb: numbs.secondNumber, resultNumb: numbs.resultNumber, calcMode: getCalculationMode(calc: calc))
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
    
    // Flips cards (not answerView) when their numbers changes to new values (new image)
    func newCardTransitionFlip(cardViews: [UIView]) {
        
        cardViews.filter { $0 != equationCardViews[getAnswerViewIndex()]}.map{$0.flipView(duration: 0.6)}
    }
    
    
    // TODO: kolla närmare om den kan kombineras med någon annan funktion
    func flipCardsBack(cards: [MathCard], cardViews: [UIView]) {
        
        //cards.filter{ $0.isFlipped && !$0.isAnswerView }.map{$0.isFlipped = false }
        
        for (index, card) in cards.enumerated() where card.isFlipped && !card.isAnswerView {
            
            cardViews[index].flipView(duration: 0.6)
            card.isFlipped = false
        }
    }
    
    
    // Resets the cardViews to their original position
    // returnPlayableCardViewsPosition
    func returnCardViewsToOriginalPosition() {

        for (index, view) in playableCardViews.enumerated() {
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                if let position = self.playableCards?[index].position {
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
            
            playableCards?[index].position = CardPosition(xPosition: Double(view.center.x), yPosition: Double(view.center.y))
        }
    }
    
    // Disable or enable card(s) interactions
    func disableCardInteractions(shouldDisable: Bool) {
        
        playableCardViews.map { $0.isUserInteractionEnabled = shouldDisable ? false : true }
    }
    
    
    func removeInstances() {
        NotificationCenter.default.removeObserver(self)
        playableCards = nil
        calculator = nil
        audioPlayer = nil
        numberRandomizer = nil
        playableCards = nil
        equationCards = nil
    }
    
    deinit {
        print("EasyMathVC was deallocated")
    }
    
    
    @IBAction func goBackPressed(_ sender: Any) {

        dismiss(animated: true, completion: nil)
    }
     
    
    
}

