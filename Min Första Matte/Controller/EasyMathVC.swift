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
// problem; answerView randomeras hela tiden
// randomerade (ett som är rätt) playable cards
// Nivå 5: tal: 1-10 (random) ? + 3 = 10 || 2 + ? = 3 || 3 + 4 = ?





// Division:

// Score/Highscore
// fixa score (mer beroende på svårighets grad)


// Fixa lite med multiplikationen, nummren (inte bara 8 X 1 osv), 9 x ? = 7 funkar inte!!

// Kolla så att alla modes samt lvls fungerar...


// TODO: lägg till högre svar i nivå 3: ex. 3 + ? = 10 (KVAR??)



// TODO: Fixa highscore (olika för dem olika räknesätten) -> Fixa speciell view för highscores!


// TODO: Korten vänds automatiskt tillbaka efter man tryckt på dem?!


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



// FIX:
// back button not working (VC presented in smaller window)
// Crashar om ljudfil intex finns



// TODO: Randomerade matte tal, inte samma som förra gången (spara sista). Ex: 3 + 4, nästa gång 2 + 1. Alt att svaret inte heller är samma
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

// Card positionerna blir inbland fel när man drar och släpper kort (EJ KVAR??)
// Card vände sig på fel håll efter rätt svar (cardOirginalPositionc) (EJ KVAR??)
// Kan svaret bli 5 på medel?
// KAnske pterkommer, tryck på kort 4 så snurrar kort 5. Fel, ordningen i playableCardVeiws collectionen!s (EJ KVAR??)

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
    
    
    
    //var randomIndex = 5
    var randomIndex: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().isExclusiveTouch = true // Disable multi touch
        calculator = Calculator()
        playableCards = createCards(numberOfCards: 5, isEquationCards: false)
        equationCards = createCards(numberOfCards: 3, isEquationCards: true)
        setPlayableCardsNumber()
        addImgTapGesture(cardImages: playableCardImages, isPlayableCardImage: true)
        addImgTapGesture(cardImages: equationCardImages, isPlayableCardImage: false)
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
        setupNextEquation()
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
        //randomIndex = 5
        randomIndex = nil
        setupNextEquation()
        returnCardViewsToOriginalPosition()
        disableOrEnableCardInteractions(shouldDisable: false)
        updateScoreLabel()
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
    
  
    
    
    
    // RENAME: setupNextEquation || setupNewEquation
    func setupNextEquation() {
        
        setCurrentAnswerView(currentIndex: getAnswerViewIndex())
        print("Current Answer \(getAnswerViewIndex())")
        flipCardsBack(cards: playableCards, cardViews: playableCardViews)
        flipCardsBack(cards: equationCards, cardViews: equationCardViews) // TOOD: BeHÖVS???!!!
        
        setCardImages(cards: playableCards, cardImages: playableCardImages)
        
        getNewEquationCards()
        //setCardImages(cards: equationCards, cardImages: equationCardImages)
        
        setCardLabels(cards: playableCards, cardLabels: playableCardLabels)
        setCardLabels(cards: equationCards, cardLabels: equationCardLabels)
    }
    
    
    
    func getNewEquationCards() {
        //setCurrentAnswerView(currentIndex: getAnswerViewIndex())
        hideAnswerViewLabel(answerViewIndex: getAnswerViewIndex())
        //setDifficulty(difficulty: currentDifficulty.rawValue)
        
        let randomNumbers = getEquationNumbers()
        
        var tempArray = [MathCard]()
        
        for equationCard in equationCards where !equationCard.isAnswerView {
            tempArray.append(equationCard)
        }
        // TODO: använd function för detta....
        tempArray[0].number = randomNumbers.firstNumber // Points to the same place in the memory as first valid equationCard (works because classes are reference's types!)
        tempArray[1].number = randomNumbers.secondNumber
        
        
        //for cardView in equationCardViews where cardView != getAnswerView() {
        
        //        for cardView in equationCardViews where cardView != equationCardViews[getAnswerViewIndex()] {
        //
        //            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        //        }
        newCardTransitionFlip(cardViews: equationCardViews)
        
        setCardImages(cards: equationCards, cardImages: equationCardImages)
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
        
        print("AnswInde:\(getAnswerViewIndex())")
        
        if getAnswerViewIndex() == 2 {
            print("Answer 2")
        } else {
            print("Not answer 2")
        }
        
        return getAnswerViewIndex() == 2 ? numberRandomizer.impossibleAdditionCondition1 : numberRandomizer.impossibleAdditionCondition2
    }
    
    
    
    // Returns number for playableCard based on lvl and mathMode
    func getPlayableCardNumbersRange() -> ClosedRange<Int> {
        
        switch (currentDifficulty, mathMode)  {
            
        case (.easy, .addition), (.hard, .addition), (.easy, .multiplication), (.hard, .multiplication):
            return 1...5
        case (.medium, .addition), (.veryHard, .addition), (.medium, .multiplication), (.veryHard, .multiplication):
            return 6...10
        case (.impossible, .addition), (.impossible, .multiplication):
            return 4...8 // TODO: FIX!! RANDOM!!!!
            
        case (.easy, .subtraction), (.hard, .subtraction):
            return 0...4
        case (.medium, .subtraction), (.veryHard, .subtraction):
            return 5...9
        case (.impossible, .subtraction):
            return 4...8 // FIX
            
        }
    }
    
    
    
    
    
    
    // Sets correct number of playableCards based on level
    func setPlayableCardsNumber() {
        
        for (index, n) in getPlayableCardNumbersRange().enumerated() {
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
            
            if randomIndex != nil {
                if let randomIndex = randomIndex { return randomIndex }
            } else {
                randomIndex = Int.random(in: 0...2)
                
                if let randomIndex = randomIndex { return randomIndex}
            }
            
//            if randomIndex == nil {
//                randomIndex = Int.random(in: 0...2)
//
//                if let n = randomIndex {
//                    return n
//                }
//
//                //return randomIndex
//            } else {
//                if let randomIndex = randomIndex { return randomIndex}
//                //return randomIndex
//            }
            
            return randomIndex!
            
            //if let randomIndex = randomIndex { return randomIndex }
            
//            if randomIndex == 5 {
//                print("radn")
//                let n = Int.random(in: 0...2)
//                randomIndex = n
//                return n
//            } else {
//                print("no rand")
//                return randomIndex
//            }
            //return Int.random(in: 0...2)
        }
    }
    
    
    // Sets property of isAnswerView in equationCards
    func setCurrentAnswerView(currentIndex: Int) {
        
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




