//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation


// TODO: Fixa equation numbers till nivå 4!



// TODO: Fixa att progressbaren blir större än mätaren!

// Nivå 1: tal: 1 - 5    1 + 3 = ?
// Nivå 2: tal: 6 - 10   6 + 3 = ?
// Nivå 3: tal: 1-5      3 + ? = 5
// Nivå 4: tal: 6-10     5 + ? = 9 || ? + 5 = 9
// Nivå 5: tal: 1-10 (random) ? + 3 = 10 || 2 + ? = 3 || 3 + 4 = ?

// Vissa score? Bugg, Card hoppar ner innan man trycker på nästa lvl


// RÄknesätt: +, -, /, *

// TODO: Randomerade matte tal, inte samma som förra gången (spara sista). Ex: 3 + 4, nästa gång 2 + 1. Alt att svaret inte heller är samma
// TODO: I addition (nivå1) lägg till '0';  1 + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)?
// TODO: Fixa räknesätten -, / och *

// TODO: Alert Rutan berättar när man kommit till ny nivå! -> KAnske, knapp man måste trycka först innan man går vidare?? Kanske fyverkerieffekter

// TODO: Fix score label, highscore Class


// TODO: lägg till högre svar i nivå 3: ex. 3 + ? = 10

// TODO: Nivå 4 och 5.
//    nivå 5, randomera btm tal (en optional parameter -> kort som måste finnas med (rätt svar))



// TODO: Hardmode!, om progressbaren går ner i botten sänks nivån. Progressbar sänks över tid. Poäng som sakta tickar ner med?. .... gå ner i nivå om mätaren når 0. Mätaren börjar på toppen och går sakta neråt? Klarar man en nivå börjar den på topp igen!


// TODO: highscore lista!, en för hardCore en för vanligt!


// Add Sound effects:
// rejected (wrong answer), correct answer, return sound (card dropped)


// Particle effects for finishing a lvl

// Memory Leaks
// Make all cards optional of Cards. Make them nil in deinit/viewDidDisappear
// TODO: sätt array av cards till optional eller sätt korten i arrayen till att vara optionals
// Använd structs istället för klasser?




// Försök använda; Generics, Closures, Computed Properties.....
// I card klassen lägg till om addision, div etc... som property?
// LÄgg logik för att lägga till kort i klassen MathCard?
// Generic cardClass?
// CardHand egen klass? Array av Cards?, Subscript för att nå certain card
// GetImageName i klassen
// Läggga views, imageVeiws etc. i klassen?
// SKAPA CARDIMAGES programmetical
// LÄGG KOD I KLASSEN?
// Knapp FÖR nytt tal?? - OM ogilgtligt tal ...




// FIX:
// Om man startar från början på level medium ska korten skapas som medium kort (6-10)
    // - kolla när korten bottem cards instansieras vilken lvl som det är?

// back button not working (VC presented in smaller window)
// Crashar om ljudfil inte finns

// BUGGAR:

// Labels inte på rätt kort. Tag fel (image på fel kort)

// Card positionerna blir inbland fel när man drar och släpper kort (EJ KVAR??)
// Card vände sig på fel håll efter rätt svar (cardOirginalPositionc) (EJ KVAR??)
// Kan svaret bli 5 på medel?
// KAnske pterkommer, tryck på kort 4 så snurrar kort 5. Fel, ordningen i playableCardVeiws collectionen!s

// Refactoring:
// Good name for bottomCards array of cards:
// CardOptions, playableCards, cardHand, bottomCards, btmCardHand, bottomCardHand, bottomMathCards,
   
// cardHandViews: [UIView]!  //@IBOutlet var btmCardViews: [UIView]!, playableCardViews, draggableCardViews
// TODO: RENAME answerView!
// ResetCard, vänd tillbaka, sätt isFlipped till false osv... lägg i klassen?


let nxtLvlNotificationKey = "co.HenrikJangefelt.nxtLvl"


// TODO: RENAME: BasicMathVC?
class EasyMathVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var progressBarViewBackground: UIView!
    @IBOutlet weak var progressBarContainer: UIView!
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
    
    var equationCards = [MathCard]() // TODO: property in object (isTopCard)
    var playableCards = [MathCard]() // TODO: Make optional?? || sätt arrayen till empty i deinit
    var currentDifficulty = Difficulty.easy
    var mathMode = CalculationMode.addition
    var audioPlayer: AVAudioPlayer?
    var calculator: Calculator?
    var numberRandomizer: NumberRandomizer?
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UIView.appearance().isExclusiveTouch = true // Disable multi touch
        calculator = Calculator()
        createPlayableCards()
        createEquationCards()
        addImgTapGesture(cardImages: playableCardImages, isPlayableCardImage: true)
        addImgTapGesture(cardImages: equationCardImages, isPlayableCardImage: false)
        createObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setBackgroundColors(mathMode: mathMode)
        setOperatorImages(mathMode: mathMode)        
        customizeCards(cardViews: playableCardViews)
        customizeCards(cardViews: equationCardViews)
        customizeCards(cardViews: operatorCardViews)
        
        sortOutletCollections()
        nextEquation()
        title = mathMode.rawValue // Sets title based on CalculationMode enum
    }
    
    override func viewDidAppear(_ animated: Bool) {
        saveCardPositions() // Saves the original position of the bottom cards
    }
    
    
    
    

    func createObserver() {
        
        let name = Notification.Name(rawValue: nxtLvlNotificationKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EasyMathVC.updateLevel(notification:)), name: name, object: nil)
    }
    
    
    @objc func updateLevel(notification: NSNotification) {
        nextEquation()
        resetToCardPosition()
    }
    
    

    func sortOutletCollections() {
        playableCardViews.sort(by: { $0.tag < $1.tag })
        playableCardImages.sort(by: { $0.tag < $1.tag })
        playableCardLabels.sort(by: { $0.tag < $1.tag })
        
        equationCardViews.sort(by: { $0.tag < $1.tag }) // TODO: Behövs?
        equationCardImages.sort(by: { $0.tag < $1.tag }) // TODO: Behövs?
        equationCardLabels.sort(by: { $0.tag < $1.tag })
        operatorCardImages.sort(by: { $0.tag < $1.tag })
        
    }
    
    
    
    
    

    
    
    
    
    
    
    
    
    
    
    
    // RENAME: setupNextEquation
    func nextEquation() {
        
        //scoreLabel.text = "Score: \(score)"
        
        
        //let numberRandomizer = NumberRandomizer()
        //let randomNumbers = numberRandomizer.numberRandomizer(startNumber: <#T##Int#>, endNumber: <#T##Int#>, condition: <#T##(Int, Int) -> Bool#>)
        //let randomNumbers = numberRandomizer.randomizeTwoNumbers(mathMode: mathMode)
        
        //topCards[0].updateImageName(mathMode: mathMode)
        //topCards[1].updateImageName(mathMode: mathMode)
        
        
        flipCardsBack(cards: playableCards, cardViews: playableCardViews)
        flipCardsBack(cards: equationCards, cardViews: equationCardViews) // TOOD: BeHÖVS???!!!
        
        setCardImages(cards: playableCards, cardImages: playableCardImages)
        
        newEquationCards()
        //setCardImages(cards: equationCards, cardImages: equationCardImages)
        
        setCardLabels(cards: playableCards, cardLabels: playableCardLabels)
        setCardLabels(cards: equationCards, cardLabels: equationCardLabels)
        
        
        //WrongImage.isHidden = true
    }
    
    
    
    func newEquationCards() {
        
        setCurrentAnswerView(currentIndex: getAnswerViewIndex())
        hideAnswerViewLabel(answerView: getAnswerViewIndex())
        //setDifficulty(difficulty: currentDifficulty.rawValue)

        let randomNumbers = getEquationNumbers()
            
        var tempArray = [MathCard]()
        
        for equationCard in equationCards where !equationCard.isAnswerView {
            tempArray.append(equationCard)
        }
        
        tempArray[0].number = randomNumbers.firstNumber // Points to the same place in the memory as first valid equationCard (works because classes are reference's types!)
        tempArray[1].number = randomNumbers.secondNumber
        
        
        // Flips equations card and shows new ones
        for (index, cardView) in equationCardViews.enumerated() where cardView != getAnswerView() {

            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
     
        setCardImages(cards: equationCards, cardImages: equationCardImages)
    }
    
    
    
    
 
    
    
    // TODO: FIX IMPOSSIBLE
    func getEquationNumbers() -> (firstNumber: Int, secondNumber: Int) {
       
        let numberRandomizer = NumberRandomizer()
        var condition: (Int, Int) -> Bool
        
        switch currentDifficulty {
        case .easy:
            condition = numberRandomizer.easyAdditionCondition
        case .medium:
            condition = numberRandomizer.mediumAdditionContidion
        case .hard:
            condition = numberRandomizer.hardAdditionCondition
        case .veryHard:
            condition = numberRandomizer.veryHardAdditionConditio
        case .impossible:
            print("IMPOSSIBLE!!!!")
            return (10, 2)
        }
        
        return numberRandomizer.numberRandomizer(condition: condition)
    }
    
    
    

    
    
   
        
 
        
        
        

    
    
    
 
    

    
    
    func checkProgress() {
        var counter = 0
        var difficultyValue = currentDifficulty.rawValue
        
        if progressBarWidth.constant.rounded() == progressBarContainer.frame.size.width.rounded() {
            
            if difficultyValue < Difficulty.allCases.count {
                // Increase lvl!
                difficultyValue += 1
                soundEffects(soundName: "Cheering")
                progressBarWidth.constant = 0
            }
        }
        
        // TODO: FÖR HARDMODE!
        if progressBarWidth.constant.rounded() == 0 {
            counter += 1
        }
        currentDifficulty = updateDifficulty(difficulty: difficultyValue)
        setPlayableCardNumberValue()
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

    
    // NOT USED!!!!!
    func increaseDifficulty() {

    }
    
    func decreaseDifficulty() {
        
    }
    
    
    

    

    

    
    func getPlayableCardNumberValueRange(difficulty: Difficulty) -> ClosedRange<Int> {
        
        switch difficulty {
        case .easy:
            return 1...5
        case .medium:
            return 6...10
        case .hard:
            return 1...5
        case .veryHard:
            return 6...10
        case .impossible:
            return 4...8 // TODO: FIX!!
        }
        
    }
    
    
    func setPlayableCardNumberValue() {
        
        let numberRange: ClosedRange<Int> = getPlayableCardNumberValueRange(difficulty: currentDifficulty)
       
        var numbRangeArray = [Int]()
        
        for number in numberRange {
            numbRangeArray.append(number)
        }
        
        for (index, card) in playableCards.enumerated() {
            card.number = numbRangeArray[index]
        }
    }
    
    
    func createEquationCards() {
         
        for n in 1...3 {
                 
            let card = MathCard()
             
            if n == getAnswerViewIndex() { card.isAnswerView = true }
            equationCards.append(card)
        }
    }
    
    func createPlayableCards() {
        
        for _ in 1...5 {
            let card = MathCard()
            playableCards.append(card)
        }
        setPlayableCardNumberValue()
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
            return Int.random(in: 0...2)
        }
    }
    
    
    // Sets property of isAnswerView in equationCards
    func setCurrentAnswerView(currentIndex: Int) {
             
        for (index, card) in equationCards.enumerated() {
            card.isAnswerView = index == currentIndex ? true : false
        }
    }
      
    // Hides label for answerView
    func hideAnswerViewLabel(answerView: Int) {
        for (index, label) in equationCardLabels.enumerated() {
            label.isHidden = answerView == index ? true : false
        }
    }
  
    // Returns the current answerView
    func getAnswerView() -> UIView? {
          
        for (index, card) in equationCards.enumerated() where card.isAnswerView {
            return equationCardViews[index]
        }
        return nil
    }
    
    
    
    
    
    func flipCardsBack(cards: [MathCard], cardViews: [UIView]) {
        
        for (index, card) in cards.enumerated() where card.isFlipped && !card.isAnswerView {
            card.flipCardBack(cardView: cardViews[index])
        }
    }
    
    
    // Resets the cards to their original position
    func resetToCardPosition() {
        
        for (index, view) in playableCardViews.enumerated() {
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                view.center = self.playableCards[index].originalPosition!
            })
        }
    }
    
    
    // Saves original position for cards
    func saveCardPositions() {
        
        for (index, view) in playableCardViews.enumerated() {
            playableCards[index].originalPosition = view.center
        }
    }
    
    
    // Disable or enable pangesture of the cards
     func disableOrEnableCardInteractions(shouldDisable: Bool) {
         
         for cardView in playableCardViews {
             cardView.isUserInteractionEnabled = shouldDisable ? false : true
         }
     }
    
    
    
    
    
    
    func updateScore() {
        score += 10
    }
    
    
    

    
    deinit {
        calculator = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
       
    
    
}










//    // TODO: ta bort difficulty? REturnera anserIndex?
//    func setDifficulty(difficulty: Int) {
//
//        var answerIndex: Int = 2
//
//        switch currentDifficulty {
//        case .easy:
//            answerIndex = 2
//        case .medium:
//            answerIndex = 2
//        case .hard:
//            answerIndex = 1
//        case .veryHard:
//            answerIndex = 0
//        case .impossible:
//            answerIndex = 1 // FIX!!
//        }
//
//        setAnswerView(answerViewIndex: answerIndex)
//        setAnswerViewLabel(answerView: answerIndex)
//    }



//   func createPlayableCards(mathMode: CalculationMode) {
//        let range = getPlayableCardNumberValueRange(difficulty: currentDifficulty)
//
//        for n in 1...5 {
//
//            let card = MathCard()
//
//
//        }
//        let startingNumbers = getStartPlayableCardNumber()
//
//        let lowestNumber = startingNumbers.lowNumb
//        let highestNumber = startingNumbers.highNumb
//
//
//        for cardNumberValue in lowestNumber...highestNumber {
//            let card = MathCard()
//            card.number = cardNumberValue
//            playableCards.append(card)
//        }
//    }



      // Ändra för lvls med (6, 10)
      // 0 for minus, 1 for plus etc...
//      func getStartPlayableCardNumber() -> (lowNumb: Int, highNumb: Int) {
//
//          switch mathMode {
//          case .addition:
//              return (1, 5)
//          case .subtraction:
//              return (0, 4)
//          }
//
//      }
