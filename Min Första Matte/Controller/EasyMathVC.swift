//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation




// Nivå 1: tal: 1 - 5
// Nivå 2: tal: 6 - 10

// Nivå 3: tal 1-5    3 + ? = 5
// Nivå 4: tal 6-10   5 + ? = 9

// Nivå 5: tal 1-10 (random) ? + 3 = 10 || 2 + ? = 3 || 3 + 4 = ?







// I card klassen lägg till om addision, div etc... som property?


// Dagens uppgift, gör generic function för att kod som har med Card att göra. Reseta card tex.... som kan användas till både topCard % Btm cards


// LÄgg logik för att lägga till kort i klassen MathCard?

// Generic cardClass?

// CardHand egen klass? Array av Cards?, Subscript för att nå certain card



// TODO: Randomerade tal inte samma som förra gången (spara sista)







// GetImageName i klassen


// TODO: I addition lägg till x + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)?


// TODO: randomera btm tal (en optional parameter -> kort som måste finnas med (rätt svar))


// TODO: label till answerView

// Is answerView som property?


// TODO: om progressbaren går ner i botten sänks nivån

// TODO: Alert Rutan berättar när man kommit till ny nivå! -> KAnske, knapp man måste trycka först innan man går vidare??


// CardViews Collections: 1. btmCards, 2. plus/likamed -tecknena, 3. topNumbers + answerView (så det går att sätta topcard två till att vara answerView)

// Memory Leaks
// Make all cards optional of Cards. Make them nil in deinit/viewDidDisappear
// TODO: sätt array av cards till optional eller sätt korten i arrayen till att vara optionals


// Add Sound effects:
// rejected (wrong answer), correct answer, return sound (card dropped)

// Particle effects for finishing a lvl

// HARDMODE: gå ner i nivå om mätaren når 0. Mätaren börjar på toppen och går sakta neråt? Klarar man en nivå börjar den på topp igen!

// ADD: Add question mark image to answerView
// ADD: Multiply, subtract
// TODO: Sound effect for rejected
// TODO: title (dependent of what mode?)
// TODO: Fix both addition, multip, divis and subtraction working

// TODO: Fix score label
// TODO: reseta progressBar


// Läggga views, imageVeiws etc. i klassen?
// SKAPA CARDIMAGES programmetical
// LÄGG KOD I KLASSEN?



// Knapp FÖR nytt tal??


// FIX:
// Om man startar från början på level medium ska korten skapas som medium kort (6-10)
    // - kolla när korten bottem cards instansieras vilken lvl som det är?

// back button not working (VC presented in smaller window)
// Crashar om ljudfil inte finns
// Top Korten flippar inte när dem byts ut
// FLippa answerView

// BUGGAR:
// Card positionerna blir inbland fel när man drar och släpper kort
// Card vände sig på fel håll efter rätt svar (cardOirginalPositionc)
// Kan svaret bli 5 på medel?
// KAnske pterkommer, tryck på kort 4 så snurrar kort 5. Fel, ordningen i playableCardVeiws collectionen!s

// Refactoring:
// Good name for bottomCards array of cards:
// CardOptions, playableCards, cardHand, bottomCards, btmCardHand, bottomCardHand, bottomMathCards,
   
// cardHandViews: [UIView]!  //@IBOutlet var btmCardViews: [UIView]!, playableCardViews, draggableCardViews


let nxtLvlNotificationKey = "co.HenrikJangefelt.nxtLvl"


// TODO: RENAME: BASIC MATH
class EasyMathVC: UIViewController {
    
    // TODO: make part of object?
    //@IBOutlet var cardViews: [UIView]!
    //@IBOutlet var cardLabels: [UILabel]! // BtmCardLabels
    //@IBOutlet var cardImages: [UIImageView]!
    
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
    
    
    enum Difficulty: Int {
        case easy = 1
        case medium
        case hard
        //case veryHard
        //case impossible
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
        createPlayableCards(mathMode: mathMode)
        createTopCards()
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
        //WrongImage.isHidden = true
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
    }
    
    
    
    
    

    
    
    
    
    
    
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
        
        
        setDifficulty(difficulty: currentDifficulty.rawValue)

        let randomNumbers = getRandomNumbers()
        
        var tempArray = [MathCard]()
        
        for equationCard in equationCards where !equationCard.isAnswerView {
            tempArray.append(equationCard)
        }
        
        tempArray[0].number = randomNumbers.firstNumber
        tempArray[1].number = randomNumbers.secondNumber
        print("Tal: \(equationCards[0].number) + \(equationCards[1].number) = \(equationCards[2].number)")
        print("AnswerVeiw: \(equationCards[0].isAnswerView) + \(equationCards[1].isAnswerView) = \(equationCards[2].isAnswerView)")
        
        
        //equationCards[0].number = randomNumbers.firstNumber
        //equationCards[1].number = randomNumbers.secondNumber
            
     
        

        var answerIndex = 0
        
        // Finds index position for AnswerView
        for (index, card) in equationCards.enumerated() where card.isAnswerView {
            answerIndex = index
        }
        
        // Flips equations card and shows new ones
        for (index, cardView) in equationCardViews.enumerated() where index != answerIndex {
            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
     
        setCardImages(cards: equationCards, cardImages: equationCardImages)
    }
    
    
    
    
 
    
    
    
    
    // TODO: improve
    func getRandomNumbers() -> (firstNumber: Int, secondNumber: Int) {
        let numberRandomizer = NumberRandomizer()
        //numberRandomizer = NumberRandomizer()
        
        //guard let numberR = numberRandomizer else { return }
        var startNumber: Int
        var endNumber: Int
        var condition: (Int, Int) -> Bool
        
        switch currentDifficulty {
        case .easy:
            startNumber = mathMode == .addition ? 1 : 0
            endNumber = mathMode == .addition ? 4 : 4
            condition = numberRandomizer.additionCondition
        case .medium:
            startNumber = 1
            endNumber = 9
            condition = numberRandomizer.additionMedContidion
        case .hard:
            let temp = tempRandomizer()
            return temp
            //startNumber = 1
            //endNumber = 4
            //condition = numberRandomizer.additionCondition
            // Random numbers
        }
        
            //let condition = mathMode == .addition ? numberRandomizer.additionCondition : numberRandomizer.subtractionCondition
        
        return numberRandomizer.numberRandomizer(startNumber: startNumber, endNumber: endNumber, condition: condition)
        
    }
    
    
    
    func tempRandomizer() -> (Int, Int) {
        
        var firstNumber: Int
        var answerNumber: Int
        
        repeat {
            firstNumber = Int.random(in: 1...4)
            answerNumber = Int.random(in: 1...5)
        } while answerNumber - firstNumber > 5 || answerNumber - firstNumber < 1
                
        print("\(firstNumber) + \(answerNumber)")
        return (firstNumber, answerNumber)
    }
    
    
   
    
    
    
  
    
    
    func setDifficulty(difficulty: Int) {
        
        for (index, card) in equationCards.enumerated() {
                 
            switch currentDifficulty {
            case .easy:
                equationCards[0].isAnswerView = false
                equationCards[1].isAnswerView = false
                equationCards[2].isAnswerView = true
            case .medium:
                equationCards[0].isAnswerView = false
                equationCards[1].isAnswerView = false
                equationCards[2].isAnswerView = true
            case .hard:
                equationCards[0].isAnswerView = false
                equationCards[1].isAnswerView = true
                equationCards[2].isAnswerView = false
            }
        }
    }
    
    
    func checkProgress() {
        var counter = 0
        var currentD = currentDifficulty.rawValue
        
        if progressBarWidth.constant.rounded() == progressBarContainer.frame.size.width.rounded() {
            
            // KOlla istället Difficulty.values...
            if currentD < 3 {
                currentD += 1
                increaseDifficulty()
                soundEffects(soundName: "Cheering")
                progressBarWidth.constant = 0
            }
        }
        
        if progressBarWidth.constant.rounded() == 0 {
            counter += 1
            print("MINUS NIVÅ?")
            print("\(counter)")
        }
        currentDifficulty = updateDifficulty(difficulty: currentD)
    }
    
    
    
    
    func increaseDifficulty() {
          
          if currentDifficulty == .easy {
                // Medium
              for card in playableCards {
                  card.number += 5
              }
          }
        
        if currentDifficulty == .medium {
            // hard
            for card in playableCards {
                card.number -= 5
//                for (index, card) in equationCards.enumerated() {
//                    equationCards[1].isAnswerView = true
//                    equationCards[2].isAnswerView = false
//                }
            }
            
        }
        
        
      }
    
    
    

    func updateDifficulty(difficulty: Int) -> Difficulty {
         
         switch difficulty {
         case 1:
             return .easy
         case 2:
             return .medium
         case 3:
             return .hard
         default:
             return .easy
         }
     }
    
    
    
    
    
    
    
    
    
    
    
    // Ändra för lvls med (6, 10)
    // 0 for minus, 1 for plus etc...
    func getStartPlayableCardNumber() -> (lowNumb: Int, highNumb: Int) {
        
        switch mathMode {
        case .addition:
            return (1, 5)
        case .subtraction:
            return (0, 4)
        }
        
    }
    
  
    
    func createPlayableCards(mathMode: CalculationMode) {
    
        let startingNumbers = getStartPlayableCardNumber()
        
        let lowestNumber = startingNumbers.lowNumb
        let highestNumber = startingNumbers.highNumb
        
        
        for cardNumberValue in lowestNumber...highestNumber {
            let card = MathCard()
            card.number = cardNumberValue
            playableCards.append(card)
        }
    
    }

    
    
    func createEquationCards() {
        
        switch currentDifficulty {
        case .easy:
            print("sad")
            // index 2 is answerView
            break
        case .medium:
            // index 2 is answerView
            break
        case .hard:
            // index 1 is answerVeiw
            break
            
        }
      
    }
    
    func createTopCards() {
        
        /*let firstTopCard = Card()
         let secondTopCard = Card()
         topCards.append(firstTopCard)
         topCards.append(secondTopCard)*/
        
        equationCards.append(MathCard())
        equationCards.append(MathCard())
        
        let answerView = MathCard()
        answerView.isAnswerView = true
        equationCards.append(answerView)
        
    }
    
    
    
    
    
    

 
    
    
    
    
    
    
    
    
    
    
    
    
    
    func updateScore() {
        score += 10
    }
    
    
    
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

    
    deinit {
        calculator = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
       
    
    
}






/*func resetBtmCards() {
    
    for (index, card) in playableCards.enumerated() where card.isFlipped {

        card.flipCardBack(cardView: playableCardViews[index])
        //card.updateImageName(mathMode: mathMode)
    }
    
    equationCards[0].flipCardBack(cardView: equationCardViews[0])
    equationCards[1].flipCardBack(cardView: equationCardViews[1]) // FIX: behöve bara sätta isFlipped till false??
}*/


  





// TODO: CHANGE!!! CHECK FOR CARD.isAnswerView
/*func getAnswerView() -> UIView? {
    
    

    if currentDifficulty == .easy || currentDifficulty == .medium {
        
        for cardView in equationCardViews where cardView.tag == 3 {
            return cardView
        }
    } else {
        for cardView in equationCardViews where cardView.tag == 2 {
            return cardView
        }
    }
    /*
    for cardView in cardViews where cardView.tag == 8 {
        return cardView
    }
    return nil
    */
    return nil
}*/



/*
 
 // Check if dragged card is the correct one
 func validateChosenAnswer(currentView: UIView, answerView: UIView) {
     
     guard let calculator = calculator else { return } // Unwrap instance of calculator
     
     // Position the draggedCard in the answerView
     UIView.animate(withDuration: 0.2) {
         currentView.center = answerView.center
     }
     
     let chosenNumber = playableCards[currentView.tag - 1].number // Dragged card's number
     
     let equationNumbers = getEquationNumbers()
     print("\(equationNumbers.firstNumber) \(equationNumbers.secondNumber)")
     
     
     // TODO: replace topCards[0].number med topCards.first?.number (unwrappa)
     // TODO: FIX calcMode: calcualtor.addition
     if calculator.validateMathResult(calcMode: calculator.addition, numbOne: equationCards[0].number, numbTwo: equationCards[1].number, answer: chosenNumber) {
         
         handleAnswer(answerCorrect: true)
         //answerIsCorrect() // Correct answer
     } else {
         handleAnswer(answerCorrect: false)
         //answerIsIncorrect() // Wrong answer
     }
 }
 */



//    func createBottomCards(mathMode: CalculationMode) {
//
//        createPlayableCards(mathMode: mathMode)
//        let subtractionMode = mathMode == .addition ? 0 : 1
//        for cardNumber in 1...5 {
//            let card = MathCard()
//            card.number = cardNumber - subtractionMode
//            //card.updateImageName(mathMode: mathMode)
//            playableCards.append(card)
//        }
//    }






    // Returns card.number for valid (not AnswerView) equationCards
//    func getEquationNumbers() -> (firstNumber: Int, secondNumber: Int) {
//
//        var firstNumb: Int = 0
//        var secondNumb: Int = 0
//
//        for (index, card) in equationCards.enumerated() where !card.isAnswerView {
//            switch index {
//            case 0:
//                firstNumb = card.number
//            case 1:
//                secondNumb = card.number
//            default:
//                break
//            }
//        }
//        return (firstNumb, secondNumb)
//    }
