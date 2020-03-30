//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation


// TODO: EGEN FIL FÖR CONSTANTER
let nxtLvlNotificationKey = "co.HenrikJangefelt.nxtLvl"

// TODO: StackView för CardView? 

// TODO: RENAME: BasicMathVC? || EquationsVC || MathEquationsVC
class EasyMathVC: UIViewController {
    
    @IBOutlet var operatorCardViews: [UIView]! // UIViews; Math operator + Equal sign
    @IBOutlet var operatorCardImages: [UIImageView]!
    
    // TODO: Create a cardView class (subview of UIView)??
    @IBOutlet var equationCardViews: [UIView]! // UIViews; Numbers in equation + View for Answer
    @IBOutlet var equationCardImages: [UIImageView]!
    @IBOutlet var equationCardLabels: [UILabel]!
    
    @IBOutlet var playableCardViews: [UIView]! // UIViews; Bottom Cards
    @IBOutlet var playableCardImages: [UIImageView]!
    @IBOutlet var playableCardLabels: [UILabel]!
    
    @IBOutlet weak var scoreLabel: UILabel! // Gör i kod?
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var soundManagerImage: UIImageView! // TODO: Settings?
    
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
    var currentDifficulty = Difficulty.easy
    var mathMode = CalculationMode.addition
    
    
    var hardModeEnabled: Bool = false // RENAME: COMPETITIVE MODE?? Competition , Make Enum (two cases)
    //var soundManager: SoundManager?
    var calculator: Calculator?
    var numberRandomizer: NumberRandomizer?
    var progressBar: ProgressBar?
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
        equationCards = Cards()
        playableCards?.cards = [MathCard(), MathCard(), MathCard(), MathCard(), MathCard()]
        equationCards?.cards = [EquationCard(), EquationCard(), EquationCard()]
   

        playableCardViews.forEach { $0.addGestureRecognizer(tapGesture(target: self, action: #selector(didTapView))) }
        equationCardViews.forEach { $0.addGestureRecognizer(tapGesture(target: self, action: #selector(didTapView))) }
        soundManagerImage.addGestureRecognizer(tapGesture(target: self, action: #selector(tappedMuteBtn)))
        updateAnswerView()
        updatePlayableCards()
        updateEquationCards()
        createObserver()
        
        if hardModeEnabled { setupHardmodeConfigurations() }
        
        createProgressBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        operatorCardImages[0].image = UIImage(named: mathMode.rawValue)
        
        playableCardViews.forEach { $0.roundedCorners(borderWidth: 5, myColor: .darkGray) }
        equationCardViews.forEach { $0.roundedCorners(borderWidth: 5, myColor: .darkGray) }
        operatorCardViews.forEach { $0.roundedCorners(borderWidth: 5, myColor: .darkGray) }
        sortOutletCollections()
        
        title = mathMode.rawValue // Sets title based on CalculationMode enum
    }
    
    override func viewDidAppear(_ animated: Bool) {

       // MusicPlayer.shared.startBackgroundMusic(forResource: "bensound-ukulele", songFormat: "mp3")
        
        if let playableCards = playableCards?.cards {
            saveViewsPosition(views: playableCardViews, cards: playableCards) // Saves the original position of the bottom cards
        }
        
        
        let card = CardView(frame: CGRect(x: 10,
                                          y: 10,
                                          width: 200,
                                          height: 200),
                                          imgName: "Number1",
                                          labelText: "One")
        view.addSubview(card)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        removeInstances()
    }
    
    
    
    func createProgressBar() {
        let width = Int(view.frame.size.width - 100)
        let height = Int(view.frame.size.height / 20)
        let xPosition = 50
        let yPosition = Int(view.frame.size.height) - (height + 20)
        
        progressBar = ProgressBar(frame: CGRect(x: xPosition, y: yPosition, width: width, height: height))
        
        if let progressBar = progressBar {
            view.addSubview(progressBar)
        }
    }
    
    
    
    // TODO: REMOVE / COMBINE?!
//    func addMathCards(cards: Cards<MathCard>, amount: Int) {
//        for _ in 1...amount {
//            cards.addCard(card: MathCard())
//        }
//    }
//
//    func addEquationCards(cards: Cards<EquationCard>, amount : Int) {
//        for _ in 1...amount {
//            cards.addCard(card: EquationCard())
//        }
//    }
    
    

  
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
        guard let progressBar = progressBar else {
            return
        }
        
        if progressBar.progressIsFull || currentDifficulty == .impossible || mathMode == .multiplication || mathMode == .division {
            newCardTransitionFlip(cardViews: playableCardViews)
        }
//        if randomAnswerViewIndex == nil && progressBarWidth.constant == 0 || currentDifficulty == .impossible {
//            newCardTransitionFlip(cardViews: playableCardViews)
//        }
    }
   
    
    
//    func createCardView() -> UIView {
//        
//    }
  

    
    // TODO: GÖR I KLASSEN ISTÄLLET???
     // Sets correct number of playableCards based on level
    func setPlayableCardsNumber() {
          
        for (index, number) in getPlayableCardNumbers().enumerated() {
            playableCards?[index] = MathCard(number: number)
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
    
    
  
    
    
   // SUbclass of UIImageview??!?
    func displayWrongAnswerImage() {
        guard let index = equationCards?.answerViewIndex else { return }
              
              let answerView = equationCardViews[index]
              let wrongImage = UIImageView(frame: CGRect(x: 0,
                                                         y: 0,
                                                         width: answerView.frame.size.width,
                                                         height: answerView.frame.size.height))
              wrongImage.image = UIImage(named: "WrongAnswer")
              answerView.addSubview(wrongImage)
        hideWrongAnswerImage(wrongImage: wrongImage)
    }
    
    
    // TODO: Keyframes?? Låt gå en stund innan de fadas bort...
    func hideWrongAnswerImage(wrongImage: UIImageView) {
        
        UIView.animate(withDuration: 1.2, animations: {
            wrongImage.alpha = 0
        }) { (finished: Bool) in
            print("FINISHED!")
            wrongImage.removeFromSuperview()
        }
        
    }
    
    
    
    func placeCardInAnswerView(currentView: UIView, answerView: UIView) {
         
         SoundManager.shared.playSound(soundName: "Click")
                        
         UIView.animate(withDuration: 0.2) {
             currentView.center = answerView.center // Position the draggedCard in the answerView
         }
     }
    
    
    
    // TODO: Make score class!
    func updateNormalScore() {
        
        score += currentDifficulty.rawValue * 5
    }
    
    
    
    // TODO : FIX difficulty increase (remove function?)
    // TODO: SPlit in two functions??
     func checkProgress() {
         
        guard let progressBar = progressBar else { return }
        
        // If progressBar is "full"
        if progressBar.progressIsFull {
            
            // If not highest level
            if currentDifficulty.rawValue < Difficulty.allCases.count {
                
                // Increase lvl!
               currentDifficulty = updateDifficulty(difficulty: currentDifficulty.rawValue + 1)
               //MusicPlayer.shared.playSoundEffect(soundEffect: "Cheering", songFormat: "wav")
               SoundManager.shared.playSound(soundName: "Cheering")
            }
        }
     }
    

    
    func getRandomizedEquationNumbers() -> [Int]? {
        
        guard let index = equationCards?.answerViewIndex, let numberRandomizer = numberRandomizer, let playableCards = playableCards?.cards else { return nil }
        
        let numbers: [Int] = playableCards.map { $0.number }
            
        return numberRandomizer.randomizeNumbers(playableCards: numbers, answerIndex: index, arithmetic: mathMode)
    }
    
    
    
    
    
    
    
    
    
    
    func answerIsCorrect() {
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            
            self.hardModeEnabled ? self.updateNextLevel() : AlertView.instance.showAlert(title: "Correct!", message: "That is the rigth number!!", alertType: .success)
        }
    
        print("Score: \(score)")
    }
    
    
    
      func handleAnswer(answerCorrect: Bool, currentView: UIView) {
             
            disableCardInteractions(views: playableCardViews, shouldDisable: true)
            disableCardInteractions(views: equationCardViews, shouldDisable: true)
             
            answerCorrect ? answerIsCorrect() : answerIsIncorrect(cardView: currentView)
            
            let newValue = answerCorrect ? self.progressBar?.increaseProgress(amount: 100.0) : self.progressBar?.decreaseProgress(amount: 100.0)

    //        UIView.animate(withDuration: 1.2) {
    //            self.view.layoutIfNeeded()
    //
    //        }
             checkProgress()
                     
             UIView.animate(withDuration: 1) {
                 self.view.layoutIfNeeded()
             }
         }
    
    
    
    func answerIsIncorrect(cardView: UIView) {
         
                 
         DispatchQueue(label: "serial").asyncAfter(deadline: DispatchTime.now() + 0.75) {
             
             DispatchQueue.main.async {
                                 
                 //self.returnCard(cardView: cardView)
                 self.returnCards() // FIX ONLY RESET CURRENT CARD?
                 self.displayWrongAnswerImage()
                 self.disableCardInteractions(views: self.playableCardViews, shouldDisable: false)
                 self.disableCardInteractions(views: self.equationCardViews, shouldDisable: false)
             }
         }
         
         UIView.animate(withDuration: 1) {
             self.view.layoutIfNeeded()
             //self.scoreLabel.text = "Score: \(self.score)"
         }
     }
    
    
    
    // Check if dragged card is the correct one
      func validateChosenAnswer(currentView: UIView, answerView: UIView) {

          guard let playableCards = playableCards, let equationCards = equationCards, let index = equationCards.answerViewIndex else { return }

          placeCardInAnswerView(currentView: currentView, answerView: answerView)

          // If dragged card (number) is the same as equation card (answerView/number)
          handleAnswer(answerCorrect:  playableCards[currentView.tag - 1]?.number == equationCards[index]?.number, currentView: currentView)
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
    
    
       // TEST; lade till where !cards[index].isAnserView
        func setCardLabels<T: Card>(cards: [T], cardLabels: [UILabel]) {
            
            for (index, label) in cardLabels.enumerated() {
                label.text = cards[index].labelText
            }
            
    //        for (index, label) in cardLabels.enumerated() where !cards[index].isAnswerView {
    //            label.text = cards[index].labelText
    //        }
            
        }
    
    
    

    
    
        // TOOD: Set nil/Black om card.isAnswerView = true?
        func setCardImages<T: Card>(cards: [T], cardImages: [UIImageView]) {

            sortOutletCollections()
        
            for (index, cardImage) in cardImages.enumerated() where cardImage.tag == index + 1 {
                cardImage.image = UIImage(named: cards[index].imageName)
            }
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
    
    
    
    
    
    // TODO: Lägg logik för return och save i CardView
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
                        
        for (index, view) in views.enumerated() {
            cards[index].position = CardPosition(xPosition: Double(view.center.x), yPosition: Double(view.center.y))
        }
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







 // func returnCard(cardView: UIView) {
//
//        guard let cardPosition = playableCards?[cardView.tag - 1]?.position else { return }
//        cardView.returnToPosition(position: cardPosition)
//
//        //let view: Int = playableCardViews.filter { $0 == cardView }
//
////        for (index, view) in playableCardViews.enumerated() {
////            if cardView == view {
////                cardView.returnToPosition(position: playableCards?[index].position)
////            }
////        }
//    }



//

  
//    // Resets the cardViews to their original position
//    func resetCardView(views: UIView..., positions: [CardPosition]) {
//        views.enumerated().forEach { (index, view) in
//            view.returnToPosition(position: positions[index]) }
//    }
// func resetCardView(view: UIView, position: CardPosition) {
////        view.returnToPosition(position: position[index])
////    }
