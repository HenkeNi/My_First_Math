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

// Bugg, drar upp fel nummer -> Sedan roterar, bytts playableCards ut ....

// Problemet: getPlayableCardNumbers kallas på och i den kallas impossible som ger nya random Cards


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


// KANSKE: FÖR MULTI: ENDAST HA RANDOMERADE NUMMER? istället för 1...5 eller 6...10!

// Kunna dra upp mer en ett kort? två rutor (en lite ovanför och till höger, sitter samman delvis)
// så man får [][] + 3 = 10 sen får man dra upp tex 4 och 2 eller 3 och 3?


// back button not working (VC presented in smaller window)



// TODO: Inte samma randomerade ekvaions tal i rad??? (spara sista svars siffra? Alt. spara senaste två randomerade talen)
// TODO: I addition (nivå1) lägg till '0';  1 + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)?



// TODO: Alert Rutan berättar när man kommit till ny nivå! -> KAnske, knapp man måste trycka först innan man går vidare?? Kanske fyverkerieffekter



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
// I card klassen lägg till om addision, div etc... som property?
// LÄgg logik för att lägga till kort i klassen MathCard?
// Generic cardClass?
// CardHand egen klass? Array av Cards?, Subscript för att nå certain card
// GetImageName i klassen
// Läggga views, imageVeiws etc. i klassen?
// SKAPA CARDIMAGES programmetical
// LÄGG KOD I KLASSEN?
// Knapp FÖR nytt tal?? - OM ogilgtligt tal ...





// BUGGAR:
// ANSWERVIEW FELVÄND NÄR DEN FÅR SIFFRA (IBLAND) (NÄSTA LEVEL)
// När man drar nytt kort efter att ha dragit fel; om för snabbt, resetas kortet automatiskt när man drar det....
// NIVÅ 5: Labels inte på rätt kort. Tag fel (image på fel kort)

// Kan svaret bli 5 på medel?



// BUGGAR SOM ÄR BORTA?
// Impossible lvl: FÖrsta ekvationen, siffrorna bytts ut.... (BUGG)
// Impossible lvl: Siffra visar fel label // Siffra byts ut till en annnan mid-game
// problem; answerView randomeras hela tiden (när man drar fel svar/ska rättas etc..)
// Card positionerna blir inbland fel när man drar och släpper kort
// Card vände sig på fel håll efter rätt svar (cardOirginalPositionc)
// KAnske pterkommer, tryck på kort 4 så snurrar kort 5. Fel, ordningen i playableCardVeiws collectionen!s
// Crashar om ljudfil intex finns




// Refactoring:
// Good name for bottomCards array of cards:
// CardOptions, playableCards, cardHand, bottomCards, btmCardHand, bottomCardHand, bottomMathCards,

// cardHandViews: [UIView]!  //@IBOutlet var btmCardViews: [UIView]!, playableCardViews, draggableCardViews
// TODO: RENAME answerView!


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
    
    
    var equationCards = [MathCard]() // TODO: property in object (isTopCard)
    var playableCards = [MathCard]() // TODO: Make optional?? ([MathCard?]), sätt arrayen till empty i deinit
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
        playableCards = createCards(numberOfCards: 5, isEquationCards: false)
        equationCards = createCards(numberOfCards: 3, isEquationCards: true)
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
        setIsAnswerViewProperty(currentIndex: getAnswerViewIndex())
        hideAnswerViewLabel(answerViewIndex: getAnswerViewIndex())
    }
    
    func updateEquationCards() {
        flipCardsBack(cards: equationCards, cardViews: equationCardViews)
        setNewEquationNumbers()
        setCardLabels(cards: equationCards, cardLabels: equationCardLabels)
        newCardTransitionFlip(cardViews: equationCardViews)
        setCardImages(cards: equationCards, cardImages: equationCardImages)
    }
  
    func setNewEquationNumbers() {
        let equationNumbers = getEquationNumbers()
        var tempArray = [MathCard]()

        for equationCard in equationCards where !equationCard.isAnswerView {
            tempArray.append(equationCard)
        }
        tempArray[0].number = equationNumbers.firstNumber
        tempArray[1].number = equationNumbers.secondNumber
    }
    
    func updatePlayableCards() {
        flipCardsBack(cards: playableCards, cardViews: playableCardViews)
        setPlayableCardsNumber()
        setCardImages(cards: playableCards, cardImages: playableCardImages)
        setCardLabels(cards: playableCards, cardLabels: playableCardLabels)
    }
    
   
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    // TODO: FIX IMPOSSIBLE
    func getEquationNumbers() -> (firstNumber: Int, secondNumber: Int) {
        
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
        print("UPDATING CARD")
        switch (currentDifficulty, mathMode)  {
            
        case (.easy, .addition), (.hard, .addition), (.easy, .multiplication), (.hard, .multiplication):
            return [1, 2, 3, 4, 5]
            //return [1...5]
        case (.medium, .addition), (.veryHard, .addition), (.medium, .multiplication), (.veryHard, .multiplication):
            return [6, 7, 8, 9, 10]
            //return [6...10]
        case (.impossible, .addition), (.impossible, .multiplication):
            //return 4...8 // TODO: FIX!! RANDOM!!!!
            
            // TODO: FIXA!!! EGEN PlayableCards klass?
            print("UPDATING RANDOM INDEX: \(randomAnswerViewIndex)")
            if randomAnswerViewIndex == nil {
                var tempArray = [Int]()
                
                for card in playableCards {
                    tempArray.append(card.number)
                }
                return tempArray
            } else {
                print("UPDATING AGAIN")
                return getImpossibleLvlCardNumbers()
            }
            //return 4...8
            
        case (.easy, .subtraction), (.hard, .subtraction):
            return [0, 1, 2, 3, 4]
            //return [0...4]
        case (.medium, .subtraction), (.veryHard, .subtraction):
            return [5, 6, 7, 8, 9]
            //return [5...9]
        case (.impossible, .subtraction):
             return [4, 5, 6, 7, 8] // FIX
            //return [4...8] // FIX
            
        }
    }
    
    func getImpossibleLvlCardNumbers() -> [Int] {
        
        var numbs = [Int]()
        var usedNumbs = [Int]()
            
        repeat {
            
            numbs.removeAll()
            
            for _ in 1...5 {
                let n = Int.random(in: 1...10)
                if !numbs.contains(n) {
                    numbs.append(n)
                }
            }
            
        } while numbs.count < 5 || !checkNumbers(numbers: numbs)
        
        
        return numbs.sorted()
        
        //print("Contains correct Answer: \(checkNumbers(numbers: numbs))")
        //return numbs
    }
    
    
    func checkNumbers(numbers: [Int]) -> Bool {
        
        guard let calculator = calculator else {
            print("Contains nothing")
            return false } // Unwrap instance of calculator
        
        var answers = [Bool]()
        
        let equationsNumber = getCurrentEquationCardNumbers()
        print(equationsNumber[0])
        print(equationsNumber[1])
        var numb1: Int = 0
        var numb2: Int = 0
        var numb3: Int = 0
        
        for number in numbers {
            
            switch getAnswerViewIndex() {
            case 0:
                print("Contains case 0")
                print("Contains: \(number) + \(equationsNumber[0]) = \(equationsNumber[1])")
                numb1 = number
                numb2 = equationsNumber[0]
                numb3 = equationsNumber[1]
                 //return (number, equationNumbers[0], equationNumbers[1])
            case 1:
                print("Contains case 1")
                print("Contains: \(equationsNumber[0]) + \(number) = \(equationsNumber[1])")
                numb1 = equationsNumber[0]
                numb2 = number
                numb3 = equationsNumber[1]
                //return (equationNumbers[0], number, equationNumbers[1])
            case 2:
                print("Contains case 2")
                print("Contains: \(equationsNumber[0]) + \(equationsNumber[1]) = \(number)")
                numb1 = equationsNumber[0]
                numb2 = equationsNumber[1]
                numb3 = number
                //return (equationNumbers[0], equationNumbers[1], number)
            default:
                print("Contains failure")
                //return (0, 0, 0) // TODO: FIX!
            }
            
            let calculationMode = getCalculationMode(calc: calculator)

            answers.append(calculator.validateMathResult(calcMode: calculationMode, firstNumb: numb1, secondNumb: numb2, resultNumb: numb3))
        }
        
        for answer in answers {
            print("Contains answer: \(answer)")
            if answer == true { return true }
        }
        
        return false

        // COMBINE WITH getNumbersInEquation
        
        
    }
    // FIX
//    func getMissingNumberInEquation() -> Int {
//
//    }
    
    
    
    
    // Sets correct number of playableCards based on level
    func setPlayableCardsNumber() {
        
        for (index, n) in getPlayableCardNumbers().enumerated() {
            playableCards[index].number = n
        }
    }
    
    func createCards(numberOfCards: Int, isEquationCards: Bool) -> [MathCard] {
        
        var cards = [MathCard]()
        
        for n in 1...numberOfCards {
            
            let card = MathCard()
            card.calcMode = mathMode
            if isEquationCards {
                if n == getAnswerViewIndex() { card.isAnswerView = true }
            }
            cards.append(card)
        }
        return cards
    }
    
    
    
    
    // TODO: CHECK THIS!!!!, DONT FORCE UNWRAP IN function call!!??
    // Prevents getAnswerViewindex from randomizing impossible lvl again
    //       func getCurrentAnswerViewIndex() -> Int? {
    //           for (index, card) in equationCards.enumerated() {
    //               return index
    //           }
    //           return nil
    //       }
    
    
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
      
    
      
      
    // Sets property of isAnswerView in equationCards
    // setCurrentAnswerView
    func setIsAnswerViewProperty(currentIndex: Int) {
        
        for (index, card) in equationCards.enumerated() {
            card.isAnswerView = index == currentIndex ? true : false
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
            
            UIView.transition(with: cardView, duration: 0.6, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    // TODO: kolla närmare om den kan kombineras med någon annan funktion
    func flipCardsBack(cards: [MathCard], cardViews: [UIView]) {
        
        for (index, card) in cards.enumerated() where card.isFlipped && !card.isAnswerView {
            card.flipCard(cardView: cardViews[index], duration: 0.6)
        }
    }
    
    // Resets the cardViews to their original position
    // returnPlayableCardViewsPosition
    func returnCardViewsToOriginalPosition() {
        
        for (index, view) in playableCardViews.enumerated() {
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                view.center = self.playableCards[index].originalPosition!
            })
        }
    }
    
    // Saves original position for cards
    // Put in extension of UIView (save view position??)
    func savePlayableCardViewPositions() {
        
        for (index, view) in playableCardViews.enumerated() {
            playableCards[index].originalPosition = view.center
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
        calculator = nil
        audioPlayer = nil
        numberRandomizer = nil
    }
    
    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}





