//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation

// ADD Animations!, card shkaing etc.
// TESTA SKAPA EN DELAYTIMER, tar in antal sekunder samt en completion handler!


// Completion handler istället för delay?
// CARD SHADOWS plus rounded corners?

// LÄGG TILL MÅLAR BOK - fyll i siffror... Kunna använda sina egna siffror?!

// WrongImage, aningen ha numberQuestion bakom eller ha två bilder (vissa båda) - Vill kunna se frågetecknet bakom krysset....

// SCORE KLASS?

// TODO: REPLACE DISPATCHQUEUE DELAY WIH A CUSTOM ANIMATION?? (STARTS AFTER 2 Seconds) -> Completion Handler (enable Card interaction)
 

// Disable movemnet equationcards (inte kunna snurra på dem!! efter rätt svar (tills knappen trycks))
// låt baren gå upp i toppen innan den går ner till 0

// Ingen popup med knapp?! Istället en popup som vissar rätt eller fel! Bara popup med knapp när man klarat lvl

// Update score - vid fel svar... (vid hardMode updatera scorelabel efter kortet åkt tillbaka..)
// Return card funktionen kallas på för tidigt när man updaterar scoreLabel eller timeLabel

// HARDMODE:
// End condition: efter timers slut får man se sin poäng (samt highscore lista??) -> välja gå tillbaka eller börja om


// pairable protocol med?




// Lägg en summerize function i MathCars eller protocol till Cards?? Räknar ihop talen (skicka in räknesätt)?!?!? TÄnka på - använda det till att hjälpa till vid uträkningar alt. se om något tal i imp lvl stämmer

// Score/Highscore
// TODO: Fixa highscore (olika för dem olika räknesätten) -> Fixa speciell view för highscores!
// fixa score (mer beroende på svårighets grad)

// SCORE BARA FÖR HARDMODE???
// TODO: highscore lista!, en för hardCore en för vanligt!


// End Condition: Efter Impossible -> Alert (Du har klarat spelet: 1. Gå tillbaka 2. Fortsätt spela)

// I MathCards lägg funktioner för uträkningar??
// I MathCard klassen lägg till om addision, div etc... som property?

// KANSKE: FÖR MULTIplication: ENDAST HA RANDOMERADE NUMMER? istället för 1...5 eller 6...10!

// Maybe implement: CardViews will automatically flip back after being flipped (after small delay)??
// Maybe implement: lvl where you drag up two cards either next to each other (2&1 + 2 = 5 ) or like (? + ? = 5) || (5 + ? = ?) etc.

// Progressbar -standalone class?


// FÖRSÖK ANVÄNDA:
// for-case & if-case
// Nil coalescing operator (optionalA ?? defaultValue)
// TODO: Alert Rutan berättar när man kommit till ny nivå! -> KAnske, knapp man måste trycka först innan man går vidare?? Kanske fyverkerieffekter
// Använd structs istället för klassen
// Läggga views, imageVeiws etc. i klassen?


let nxtLvlNotificationKey = "co.HenrikJangefelt.nxtLvl"


// TODO: RENAME: BasicMathVC? || EquationsVC || MathEquationsVC
class EasyMathVC: UIViewController {
    
    @IBOutlet weak var progressBarContainer: UIView!
    @IBOutlet weak var progressBarView: UIView!
    @IBOutlet weak var progressBarWidth: NSLayoutConstraint!

    @IBOutlet var operatorCardViews: [UIView]! // UIViews; Math operator + Equal sign
    @IBOutlet var operatorCardImages: [UIImageView]!
    
    @IBOutlet var equationCardViews: [UIView]! // UIViews; Numbers in equation + View for Answer
    @IBOutlet var equationCardImages: [UIImageView]!
    @IBOutlet var equationCardLabels: [UILabel]!
    
    @IBOutlet var playableCardViews: [UIView]! // UIViews; Bottom Cards
    @IBOutlet var playableCardImages: [UIImageView]!
    @IBOutlet var playableCardLabels: [UILabel]!
    
    @IBOutlet weak var scoreLabel: UILabel! // Gör i kod?
    @IBOutlet weak var timerLabel: UILabel!
    
    @IBOutlet weak var soundManagerImage: UIImageView!
    enum Difficulty: Int, CaseIterable {
        case easy = 1
        case medium
        case hard
        case veryHard
        case impossible
    }
    
    enum CompetitionMode {
        case enabled
        case disabled
    }
    
    typealias tapGesture = UITapGestureRecognizer
    
    var equationCards: Cards<EquationCard>?
    var playableCards: Cards<MathCard>?
    //var equationCards: MathCards?
    //var playableCards: MathCards?
    
    var currentDifficulty = Difficulty.easy
    var mathMode = CalculationMode.addition
    var hardModeEnabled: Bool = false // RENAME: COMPETITIVE MODE?? Competition , Make Enum (two cases)
    //var soundManager: SoundManager?
    var calculator: Calculator?
    var numberRandomizer: NumberRandomizer?
    var score = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().isExclusiveTouch = true // Disable multi touch
        calculator = Calculator()
        //soundManager = SoundManager()
        numberRandomizer = NumberRandomizer()
        
        playableCards = Cards()
        //playableCards?.cards = addCards(amount: 5)
        addCards(cards: playableCards!, amount: 5)
        
        
        equationCards = Cards()
        //equationCards?.cards = addCards(amount: 3)
        addEquationCards(cards: equationCards!, amount: 3)
        //addCards(cards: equationCards!, amount: 3)
        
        //playableCards = MathCards(amount: 5)
        //equationCards = MathCards(amount: 3)

        playableCardViews.forEach { $0.addGestureRecognizer(tapGesture(target: self, action: #selector(didTapView))) }
        equationCardViews.forEach { $0.addGestureRecognizer(tapGesture(target: self, action: #selector(didTapView))) }
        soundManagerImage.addGestureRecognizer(tapGesture(target: self, action: #selector(tappedMuteBtn)))
        updateAnswerView()
        updatePlayableCards()
        updateEquationCards()
        createObserver()
        
        if hardModeEnabled { setupHardmodeConfigurations() }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        setOperatorImages(mathMode: mathMode)
        playableCardViews.forEach { $0.roundedCorners(myRadius: 20, borderWith: 5, myColor: .darkGray) }
        equationCardViews.forEach { $0.roundedCorners(myRadius: 20, borderWith: 5, myColor: .darkGray) }
        operatorCardViews.forEach { $0.roundedCorners(myRadius: 20, borderWith: 5, myColor: .darkGray) }
        sortOutletCollections()
        
        title = mathMode.rawValue // Sets title based on CalculationMode enum
    }
    
    override func viewDidAppear(_ animated: Bool) {

        MusicPlayer.shared.startBackgroundMusic(forResource: "bensound-ukulele", songFormat: "mp3")
        
        if let playableCards = playableCards?.cards {
            saveViewsPosition(views: playableCardViews, cards: playableCards) // Saves the original position of the bottom cards
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeInstances()
    }
    
    
    
//    func addCards(to cards: Cards<<#T: Card#>>, amount: Int) {
//
//    }
//
//
//    func addCards<T: Card>(to cards: [T], amount: Int) {
//
//        cards.addCard(T)
//
//    }
    
//    func addCards(amount: Int) -> [MathCard] {
//        return Array(repeating: MathCard(), count: amount)
//    }
    
    
    // Functional programming (returnera funktion?) || returnera array av MathCards?
//    func addCards<T: Cards>(cards: [T], amount: Int) {
//        for _ in 1...amount {
//            cards.addCard(card: T)
//        }
//    }
    
    func addEquationCards(cards: Cards<EquationCard>, amount: Int) {
        for _ in 1...amount {
                 cards.addCard(card: EquationCard())
        }
    }
    
    func addCards(cards: Cards<MathCard>, amount: Int) {
        for _ in 1...amount {
            cards.addCard(card: MathCard())
        }
    }
    
    
    func sortOutletCollections() {
        playableCardViews.sort  { $0.tag < $1.tag }
        playableCardImages.sort { $0.tag < $1.tag }
        playableCardLabels.sort { $0.tag < $1.tag }
        equationCardViews.sort  { $0.tag < $1.tag }
        equationCardImages.sort { $0.tag < $1.tag }
        equationCardLabels.sort { $0.tag < $1.tag }
        operatorCardImages.sort { $0.tag < $1.tag }
    }
    
    func createObserver() {
        
        let name = Notification.Name(rawValue: nxtLvlNotificationKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EasyMathVC.updateLevel(notification:)), name: name, object: nil)
    }

    
    @objc func updateLevel(notification: NSNotification) {
        
        updateNextLevel()
        //updateScoreLabel()
    }

    
    func updateNextLevel() {
        updateAnswerView()
        updatePlayableCards()
        updateEquationCards()
        returnCards()
        disableCardInteractions(views: playableCardViews, shouldDisable: false)
        disableCardInteractions(views: equationCardViews, shouldDisable: false)
        //updateScoreLabel()
    }
    
    
    func updateAnswerView() {
        
        equationCards?.answerViewIndex = updateAnswerViewIndex()
        hideAnswerViewLabel()
    }
    
    func updateEquationCards() {
        
        // TODO FILTER AWAY isANswerView Card!!!!!ASDA
         if let cards = equationCards?.cards {
            
            
            flipCardsBack(cards: cards.filter{!$0.isAnswerView}, cardViews: equationCardViews)
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
    
    // TODO: FIX!!
    // randomAnswerViewIndex prevents flip if progressbar is first above 0 then 0 after wrong answer..
    func flipNewPlayableCards() {
        //if randomAnswerViewIndex != nil && progressBarWidth.constant == 0 || currentDifficulty == .impossible {
        
        if progressBarWidth.constant == 0 || currentDifficulty == .impossible || mathMode == .multiplication || mathMode == .division {
            newCardTransitionFlip(cardViews: playableCardViews)
        }
//        if randomAnswerViewIndex == nil && progressBarWidth.constant == 0 || currentDifficulty == .impossible {
//            newCardTransitionFlip(cardViews: playableCardViews)
//        }
    }
   
    

    
    // TODO: GÖR I KLASSEN ISTÄLLET???
     // Sets correct number of playableCards based on level
      func setPlayableCardsNumber() {
          
        for (index, n) in getPlayableCardNumbers().enumerated() {
            playableCards?[index]?.number = n
        }
      }
    
    
    // LÄGG I KLASSEN???
    func setNewEquationNumbers() {
                        
        if let equationCards = equationCards?.cards, let equationNumbers = getRandomizedEquationNumbers() {
            //let equationNumbers = getRandomizedEquationNumbers()
            
            ///let filteredEquationCards = equationCards.filter { !$0.isAnswerView }
                
            //for (index, card) in filteredEquationCards.enumerated() {
            for (index, card) in equationCards.enumerated() {

                card.number = equationNumbers[index]
            }
        }
    }
    
    
    func doAfterDelay(delay: DispatchTime, task: () -> ()) {
        
    }
    
    

    
    func getRandomizedEquationNumbers() -> [Int]? {
        
        guard let index = equationCards?.answerViewIndex, let numberRandomizer = numberRandomizer, let playableCards = playableCards?.cards else { return nil }
        
        let numbers: [Int] = playableCards.map { $0.number }
            
        return numberRandomizer.randomizeNumbers(playableCards: numbers, answerIndex: index, arithmetic: mathMode)
    }
    


    // Split into different arithmetic??
    // Returns number for playableCard based on lvl and mathMode
    func getPlayableCardNumbers() -> [Int] {

        switch (currentDifficulty, mathMode)  {
            
        case (.easy, .addition),
             (.hard, .addition):
            return [1, 2, 3, 4, 5]
            
        case (.medium, .addition),
             (.veryHard, .addition):
            return [6, 7, 8, 9, 10]
            
        case (.easy, .subtraction),
             (.hard, .subtraction):
            return [0, 1, 2, 3, 4]
            
        case (.medium, .subtraction),
             (.veryHard, .subtraction):
            return [5, 6, 7, 8, 9]
            
        default:
            return randomizeCardNumbers()
        }
    }
    
    func randomizeCardNumbers() -> [Int] {
        
        var numbs = [Int]()
            
        repeat {
            
            numbs.removeAll()
            
            for _ in 1...5 {
                let n = Int.random(in: 0...10)
                
                if !numbs.contains(n) { numbs.append(n) }
            }
        } while numbs.count < 5
        
        return numbs.sorted()
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
            assertionFailure("Unknown level")
            return .easy
          }
      }
    
    
    // Returns correct answerView index/position for current difficulty
    func updateAnswerViewIndex() -> Int {
        switch currentDifficulty {
        case .easy, .medium:
            return 2
        case .hard:
            return 1
        case .veryHard:
            return 0
        case .impossible:
            return Int.random(in: 0...2)
        }
    }
    
    // Hides label for answerView
    func hideAnswerViewLabel() {
                        
        guard let answerViewIndex = equationCards?.answerViewIndex else { return }
        
        equationCardLabels.enumerated().forEach{ (index, label) in
            label.isHidden = answerViewIndex == index ? true : false
        }
        
//        for (index, label) in equationCardLabels.enumerated() {
//            label.isHidden = answerViewIndex == index ? true : false
//        }
    }
    
    
    // Flips cards (not answerView) when their numbers changes to new values (new image)
    func newCardTransitionFlip(cardViews: [UIView]) {
        
        guard let index = equationCards?.answerViewIndex else { return }
        cardViews.filter { $0 != equationCardViews[index]}.forEach {$0.flipView(duration: 0.6)}
        //cardViews.filter { $0 != equationCardViews[getAnswerViewIndex()]}.map{$0.flipView(duration: 0.6)}
    }
    
    
    // TODO: kolla närmare om den kan kombineras med någon annan funktion
    func flipCardsBack<T: Card>(cards: [T], cardViews: [UIView]) {
        
        for (index, card) in cards.enumerated() where card.isFlipped {

            cardViews[index].flipView(duration: 0.6)
            var card = card
            card.isFlipped = false
        }
        
//        for (index, card) in cards.enumerated() where card.isFlipped && !card.isAnswerView {
//
//                 cardViews[index].flipView(duration: 0.6)
//                 card.isFlipped = false
//        }
    }
    
    
    
    // Resets the cardViews to their original position
    // returnPlayableCardViewsPosition
    
    func returnCard(cardView: UIView) {
        
        guard let cardPosition = playableCards?[cardView.tag - 1]?.position else { return }
        cardView.returnToPosition(position: cardPosition)
        
        //let view: Int = playableCardViews.filter { $0 == cardView }
        
        
//        for (index, view) in playableCardViews.enumerated() {
//            if cardView == view {
//                cardView.returnToPosition(position: playableCards?[index].position)
//            }
//        }
    }
    
    func returnCards() {

        playableCardViews.enumerated().forEach({ (index, view) in
            
            if let playableCardPosition = playableCards?[index]?.position {
                view.returnToPosition(position: playableCardPosition)
            }
        })
    }
    
    // Saves original position for cards
    // Put in extension of UIView (save view position??)
    func saveViewsPosition(views: [UIView], cards: [MathCard]) {
                
         
        for view in views.enumerated() {
            cards[view.offset].position = CardPosition(xPosition: Double(view.element.center.x), yPosition: Double(view.element.center.y))
        }
        
//        for (index, view) in views.enumerated() {
//
//            cards[index].position = CardPosition(xPosition: Double(view.center.x), yPosition: Double(view.center.y))
//        }
    }
    
    
    // Disable or enable card(s) interactions
    func disableCardInteractions(views: [UIView], shouldDisable: Bool) {
        views.forEach { $0.isUserInteractionEnabled = shouldDisable ? false : true }
    }
    
    func removeInstances() {
        NotificationCenter.default.removeObserver(self)
        playableCards = nil
        calculator = nil
        //soundManager = nil
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





    
//
//func flipCardsBack(cards: [MathCard], cardViews: [UIView]) {
//
//    for (index, card) in cards.enumerated() where card.isFlipped && !card.isAnswerView {
//
//        cardViews[index].flipView(duration: 0.6)
//        card.isFlipped = false
//    }
//}
