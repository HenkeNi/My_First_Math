//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation


// TODO: Fixa lite med multiplikationen, nummren (inte bara 8 X 1 osv), 9 x ? = 7 funkar inte!!

// TODO: lägg till högre svar i nivå 3: ex. 3 + ? = 10 (KVAR??)

// TODO: Fixa nivå 5! randomera btm tal (en optional parameter -> kort som måste finnas med (rätt svar))

// TODO: Division

// TODO: fixa score (mer beroende på svårighets grad)
// TODO: Fixa highscore (olika för dem olika räknesätten) -> Fixa speciell view för highscores!

// Fixa olika färger på progressbaren??

// TODO: Impossible nivåerna!

// PLUS
// Nivå 1: tal: 1 - 5    1 + 3 = ?
// Nivå 2: tal: 6 - 10   6 + 3 = ?
// Nivå 3: tal: 1-5      3 + ? = 5
// Nivå 4: tal: 6-10     5 + ? = 9 || ? + 5 = 9
// Nivå 5: tal: 1-10 (random) ? + 3 = 10 || 2 + ? = 3 || 3 + 4 = ?



// HARDMODE:
// Kunna gå bakåt i lvl (till lvl. 1) (om progressbaren når 0)
// Timmer som tickar på (mer tid kvar ger mer poäng)
// Progressbaren börjar i toppen och går sakta ner (fylls på om man svarar rätt, tappar om man svarar fel)
// Resetas poängen om man går tillbaka till lvl 1 ???
// Poäng som sakta tickar ner med?.
// Mätaren börjar på toppen och går sakta neråt? Klarar man en nivå börjar den på topp igen!




// KANSKE: FÖR MULTI: ENDAST HA RANDOMERADE NUMMER? istället för 1...5 eller 6...10!




// FIX:
// Progressbar color...
// Om man startar från början på level medium ska korten skapas som medium kort (6-10)
// - kolla när korten bottem cards instansieras vilken lvl som det är?
// back button not working (VC presented in smaller window)
// Crashar om ljudfil intex finns





// TODO: Randomerade matte tal, inte samma som förra gången (spara sista). Ex: 3 + 4, nästa gång 2 + 1. Alt att svaret inte heller är samma
// TODO: I addition (nivå1) lägg till '0';  1 + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)?

// TODO: Alert Rutan berättar när man kommit till ny nivå! -> KAnske, knapp man måste trycka först innan man går vidare?? Kanske fyverkerieffekter



// SCORE BARA FÖR HARDMODE???
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





// BUGGAR:
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
// ResetCard, vänd tillbaka, sätt isFlipped till false osv... lägg i klassen?


let nxtLvlNotificationKey = "co.HenrikJangefelt.nxtLvl"


// TODO: RENAME: BasicMathVC?
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
    var playableCards = [MathCard]() // TODO: Make optional?? || sätt arrayen till empty i deinit
    var currentDifficulty = Difficulty.easy
    //var currentDifficulty: Difficulty? = .easy
    var mathMode = CalculationMode.addition
    var audioPlayer: AVAudioPlayer?
    var calculator: Calculator?
    var numberRandomizer: NumberRandomizer?
    var hardMode: Bool = false
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
        setStartDifficulty()
        enableHardMode(shouldEnable: hardMode)// FIX
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
    
    
    func setStartDifficulty() {
        currentDifficulty = Difficulty.easy
    }
    
    

    func createObserver() {
        
        let name = Notification.Name(rawValue: nxtLvlNotificationKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EasyMathVC.updateLevel(notification:)), name: name, object: nil)
    }
    
    
    @objc func updateLevel(notification: NSNotification) {
        nextEquation()
        resetToCardPosition()
        disableOrEnableCardInteractions(shouldDisable: false)
        updateScoreLabel()
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
    
    
    
    
    func updateScoreLabel() {
        scoreLabel.text = "Score: \(score)"
    }

    
    func changeAnswerViewImage(displayWrongAnswer: Bool) {
        
        for (index, image) in equationCardImages.enumerated() where index == getAnswerViewIndex() {
            image.image = displayWrongAnswer ? UIImage(named: "WrongAnswer") : UIImage(named: "NumberQuestion")
        }
    }
    
    
    
    // FIX
    func enableHardMode(shouldEnable: Bool) {
        
        refillProgress()
        timerInterval()
        
    }
    
    
    func checkForNoProgressBar() {
        
//        if progressBarView.frame.width <= 0 {
//
//            //DispatchQueue.asyncAfter(<#T##self: DispatchQueue##DispatchQueue#>)
//            print("ZERO!!")
//        }
        
        if progressBarWidth.constant.rounded() == 0 {
        }
        if progressBarWidth.constant <= 0 {
            print("NO PROG")
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
//                print("NO PROGRESS LEFT!!!")
//            }
        }
    }
    
    func refillProgress() {
        progressBarWidth.constant = EasyMathVC.fullProgress(progressBarWidth.constant, progressBarContainer.frame.width)
    }
    
    
    @objc func progressBarSlowDecrease() {
        print("MINUS!!")
        progressBarWidth.constant = EasyMathVC.slowDecreaseProgress(progressBarWidth.constant, progressBarContainer.frame.width, 0.01) // 5 for smoother but harder to check for 0
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
        }
        
        checkForNoProgressBar()
    }
    
    func timerInterval() {
        let timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(progressBarSlowDecrease), userInfo: nil, repeats: true)
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
        for cardView in equationCardViews where cardView != getAnswerView() {

            UIView.transition(with: cardView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
     
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
        
        if getAnswerViewIndex() == 2 {
            print("Answer 2")
        } else {
            print("Not answer 2")
        }
        
       return getAnswerViewIndex() == 2 ? numberRandomizer.impossibleAdditionCondition1 : numberRandomizer.impossibleAdditionCondition2
    }
    

    
    
   
        
 
        
        
        

    
    
    
    
    

    
    // TODO: SPlit in two functions??
    func checkProgress() {
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
    
    
    

    

    

    
    func getPlayableCardNumberValueRange() -> ClosedRange<Int> {
        
        switch (currentDifficulty, mathMode)  {
            
        case (.easy, .addition), (.hard, .addition), (.easy, .multiplication), (.hard, .multiplication):
            return 1...5
        case (.medium, .addition), (.veryHard, .addition), (.medium, .multiplication), (.veryHard, .multiplication):
            return 6...10
        case (.impossible, .addition), (.impossible, .multiplication):
            return 4...8 // TODO: FIX!!
            
        case (.easy, .subtraction), (.hard, .subtraction):
            return 0...4
        case (.medium, .subtraction), (.veryHard, .subtraction):
            return 5...9
        case (.impossible, .subtraction):
            return 4...8 // FIX
                        
        }
        
        
//        switch difficulty {
//        case .easy:
//            return 1...5
//        case .medium:
//            return 6...10
//        case .hard:
//            return 1...5
//        case .veryHard:
//            return 6...10
//        case .impossible:
//            return 4...8 // TODO: FIX!!
//        }
        
    }
    
    
    func setPlayableCardNumberValue() {
        
        let numberRange: ClosedRange<Int> = getPlayableCardNumberValueRange()
       
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
            card.type = mathMode
            if n == getAnswerViewIndex() { card.isAnswerView = true }
            equationCards.append(card)
        }
    }
    
    func createPlayableCards() {
        
        for _ in 1...5 {
            let card = MathCard()
            card.type = mathMode
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
    
        
    // Resets the card(s) to their original position
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





//// TODO: FIX IMPOSSIBLE
// func getEquationNumbers() -> (firstNumber: Int, secondNumber: Int) {
//
//     let numberRandomizer = NumberRandomizer()
//     var condition: (Int, Int) -> Bool
//
//     switch currentDifficulty {
//     case .easy:
//         condition = numberRandomizer.easyAdditionCondition
//     case .medium:
//         condition = numberRandomizer.mediumAdditionContidion
//     case .hard:
//         condition = numberRandomizer.hardAdditionCondition
//     case .veryHard:
//         condition = numberRandomizer.veryHardAdditionConditio
//     case .impossible:
//         //condition = getAnswerViewIndex() == 2 ? numberRandomizer.impossibleAdditionCondition1 : numberRandomizer.impossibleAdditionCondition2
//         condition = getImpossibleRandomizerCondition(numberRandomizer: numberRandomizer)
//     }
//     return numberRandomizer.numberRandomizer(condition: condition)
// }
