//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation


// TODO: Randomerade tal inte samma som förra gången (spara sista)



// Nivå 1: tal: 1 - 5
// Nivå 2: tal: 6 - 10
// Nivå 3: tal: 1 - 10 answerView är 4 + ? = 7 BARA Nivå 4??!
// Nivå 4: tal: 1 - 10 answerView skiftar ? + 3 = 5 || 4 + ? = 8 || 5 + 3 = ?


// TODO: I addition lägg till x + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)?


// TODO: randomera btm tal (en optional parameter -> kort som måste finnas med (rätt svar))


// Is answerView som property?


// TODO: om progressbaren går ner i botten sänks nivån

// TODO: Alert Rutan berättar när man kommit till ny nivå! -> KAnske, knapp man måste trycka först innan man går vidare??


// CardViews Collections: 1. btmCards, 2. plus/likamed -tecknena, 3. topNumbers + answerView (så det går att sätta topcard två till att vara answerView)

// Memory Leaks
// Make all cards optional of Cards. Make them nil in deinit/viewDidDisappear
// TODO: sätt array av cards till optional eller sätt korten i arrayen till att vara optionals


// SOunds:
// rejected, correct answer, swish for turning card, return sound  





// ADD: Add question mark image to answerView
// ADD: Multiply, subtract
// TODO: Sound effect for rejected
// TODO: title (dependent of what mode?)
// TODO: Fix both addition, multip, divis and subtraction working

// TODO: Fix score label
// TODO: reseta progressBar



// FIX:
// back button not working (VC presented in smaller window)
// Crashar om ljudfil inte finns


// BUGGAR:
// Card positionerna blir inbland fel när man drar och släpper kort
// Card vände sig på fel håll efter rätt svar (cardOirginalPositionc)
// Kan svaret bli 5 på medel?


let nxtLvlNotificationKey = "co.HenrikJangefelt.nxtLvl"


// TODO: RENAME: BASIC MATH
class EasyMathVC: UIViewController {
    
    // TODO: make part of object?
    @IBOutlet var cardViews: [UIView]! // Spara?? har gemensam för alla
    
    @IBOutlet var cardLabels: [UILabel]! // BtmCardLabels

    
    @IBOutlet var cardImages: [UIImageView]!
    
    @IBOutlet weak var WrongImage: UIImageView! // Wrong images
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var progressBarViewBackground: UIView!
    @IBOutlet weak var progressBarContainer: UIView!
    @IBOutlet weak var progressBarWidth: NSLayoutConstraint!
    @IBOutlet weak var scoreLabel: UILabel! // Gör i kod?
    
    
    
    @IBOutlet var cardHandViews: [UIView]!  //@IBOutlet var btmCardViews: [UIView]!, playableCardViews, draggableCardViews
    
    
    
    
    enum Difficulty {
        case easy
        case medium
        case hard
    }
    
    
    
    
    var cardHand = [MathCard]() //
    
    
    var equationNumbers = [MathCard]()
    
    var currentDifficulty = Difficulty.easy
    var mathMode = CalculationMode.addition
    var audioPlayer: AVAudioPlayer? // TODO: make optional
    var calculator: Calculator?
    var numberRandomizer: NumberRandomizer?
    
    var cards = [MathCard]() // TODO: Make optional?? || sätt arrayen till empty i deinit
    var topCards = [MathCard]() // TODO: property in object (isTopCard)
    
    var score = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.appearance().isExclusiveTouch = true // Disable multi touch
        calculator = Calculator()
        createBottomCards(mathMode: mathMode)
        createTopCards()
        addImageTapGesture()
        createObserver()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackgroundColors(mathMode: mathMode)
        setMathOperatorsImages(mathMode: mathMode)
        customizeCards()
        nextLevel() // TEST FIXES delay
        title = mathMode == .addition ? "Addition" : "Subtraction"
        WrongImage.isHidden = true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        saveCardPositions() // Saves the original position of the bottom cards
    }
    
    
    
    
    
    
    func createObserver() {
        
        let name = Notification.Name(rawValue: nxtLvlNotificationKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EasyMathVC.updateLevel(notification:)), name: name, object: nil)
    }
    
    
    @objc func updateLevel(notification: NSNotification) {
        nextLevel()
        returnCardsToPositions()
    }
    
    
    

    
    
    
    // TODO: improve
    func getRandomNumbers() -> (firstNumber: Int, secondNumber: Int) {
        let numberRandomizer = NumberRandomizer()
        //numberRandomizer = NumberRandomizer()
        
        //guard let numberR = numberRandomizer else { return }
        var startNumber: Int
        var endNumber: Int
        var condition: (Int, Int) -> Bool
        
        print(currentDifficulty)
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
            startNumber = 1
            endNumber = 4
            condition = numberRandomizer.additionCondition
            // Random numbers
        }
        
            //let condition = mathMode == .addition ? numberRandomizer.additionCondition : numberRandomizer.subtractionCondition
        
        
        return numberRandomizer.numberRandomizer(startNumber: startNumber, endNumber: endNumber, condition: condition)
        
    }
    
    
    
    
    func nextLevel() {
        
        //scoreLabel.text = "Score: \(score)"
        
        
        //let numberRandomizer = NumberRandomizer()
        //let randomNumbers = numberRandomizer.numberRandomizer(startNumber: <#T##Int#>, endNumber: <#T##Int#>, condition: <#T##(Int, Int) -> Bool#>)
        //let randomNumbers = numberRandomizer.randomizeTwoNumbers(mathMode: mathMode)
        
        
        
        let randomNumbers = getRandomNumbers()
        
        topCards[0].number = randomNumbers.firstNumber
        topCards[1].number = randomNumbers.secondNumber
        
        //topCards[0].updateImageName(mathMode: mathMode)
        //topCards[1].updateImageName(mathMode: mathMode)
        
        resetBtmCards() // Turns all card to front side
        
        updateCardImages()
        updateCardLabels()
        updateTopCardLabels()
        
        //disableOrEnableCardInteractions(isDisabled: true) // Enable moving/turning cards again
        
        
        WrongImage.isHidden = true
    }
    
    
    
    
    
    // Disable or enable pangesture of the cards
    func disableOrEnableCardInteractions(isDisabled: Bool) {
        
        for cardView in cardViews {
            cardView.isUserInteractionEnabled = isDisabled ? true : false
        }
    }
    
    
    
    
    
    func updateScore() {
        
        score += 10
        
        switch score {
        case 100:
            currentDifficulty = .medium
            print(currentDifficulty)
            print("Lvl1")
            increaseDifficulty()
            soundEffects(soundName: "Cheering")
        case 200:
            soundEffects(soundName: "Cheering")
            currentDifficulty = .hard
            print("Lvl2")
        default:
            break
        }
        
        /*if score < 100 {
            score += 10
        } else {
            print("Unlocked New Lvl")
            increaseDifficulty()
        }*/
        
        
        print(score)
    }

    
    
    
    func increaseDifficulty() {
        
        for card in cards {
            card.number += 5
        }
        
    }
    
    
    
    
    
    func answerIsCorrect() {
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            AlertView.instance.showAlert(title: "Correct!", message: "That is the right number!", alertType: .success)
        }
        
        //let updateProgress = updateProgressBar(isRightAnswer: true) // Sets update to be of type increaseProgress
        //progressBarWidth.constant = updateProgress(progressBarWidth.constant, progressBarContainer.frame.size.width)
        
        updateScore()
        
        //originalCardPositions() // TEST
        //nextLevel()
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            //self.scoreLabel.text = "Score: \(self.score)"
        }
        
    }
    
    
    
    
    func answerIsIncorrect() {
        
        // Score ska inte kunna gå ner?
        //if score >= 10 { score -= 10 }
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.75) {
            self.returnCardsToPositions()
            self.WrongImage.isHidden = false
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 1.5) {
                self.WrongImage.isHidden = true
            }
        }
        
        //nextLevel()
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            //self.scoreLabel.text = "Score: \(self.score)"
        }
        
    }
    
    
    
    
    
    func handleAnswer(answerCorrect: Bool) {
        
        disableOrEnableCardInteractions(isDisabled: false)
        answerCorrect ? answerIsCorrect() : answerIsIncorrect()
        
        
        let progressBarUpdate = updateProgressBar(isRightAnswer: answerCorrect)
        
        progressBarWidth.constant = progressBarUpdate(progressBarWidth.constant, progressBarContainer.frame.size.width)
        
        UIView.animate(withDuration: 1) {
            self.view.layoutIfNeeded()
            //self.scoreLabel.text = "Score: \(self.score)"
        }
        disableOrEnableCardInteractions(isDisabled: true) // Enable moving/turning cards again
    }
    
    
    
    
    
    // Check if dragged card is the correct one
    func validateChosenAnswer(currentView: UIView, answerView: UIView) {
        
        guard let calculator = calculator else { return } // Unwrap instance of calculator
        
        // Position the draggedCard in the answerView
        UIView.animate(withDuration: 0.2) {
            currentView.center = answerView.center
        }
        
        let cardNumber = cards[currentView.tag - 1].number // Dragged card's number
        
        // TODO: replace topCards[0].number med topCards.first?.number (unwrappa)
        // TODO: FIX calcMode: calcualtor.addition
        if calculator.validateMathResult(calcMode: calculator.addition, numbOne: topCards[0].number, numbTwo: topCards[1].number, answer: cardNumber) {
            
            handleAnswer(answerCorrect: true)
            //answerIsCorrect() // Correct answer
        } else {
            handleAnswer(answerCorrect: false)
            //answerIsIncorrect() // Wrong answer
        }
    }
    
    
    
    
    func getAnswerView() -> UIView? {
        
        if currentDifficulty == .easy || currentDifficulty == .medium {
            
            for cardView in cardViews where cardView.tag == 8 {
                return cardView
            }
        } else {
            for cardView in cardViews where cardView.tag == 7 {
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
    }
    
  
    
    
    
    func createBottomCards(mathMode: CalculationMode) {
        
        let subtractionMode = mathMode == .addition ? 0 : 1
        
        for cardNumber in 1...5 {
            let card = MathCard()
            card.number = cardNumber - subtractionMode
            //card.updateImageName(mathMode: mathMode)
            cards.append(card)
        }
    }
    
    
    
    func createTopCards() {
        
        /*let firstTopCard = Card()
         let secondTopCard = Card()
         topCards.append(firstTopCard)
         topCards.append(secondTopCard)*/
        
        topCards.append(MathCard())
        topCards.append(MathCard())
        
    }
    
    
    
    
    
    // BEHÖVS det att flippa tillbaka topCards? Sätt istället isFlipped till false
    // TODO: improve
    // Turns the cards back to the front side
    func resetBtmCards() {
        
        for (index, card) in cards.enumerated() where card.isFlipped {

            card.flipCardBack(cardView: cardViews[index])
            //card.updateImageName(mathMode: mathMode)
        }
        
        topCards[0].flipCardBack(cardView: cardViews[5])
        topCards[1].flipCardBack(cardView: cardViews[6]) // FIX: behöve bara sätta isFlipped till false??
    }
    
    func resetTopCards() {
        
    }
    
    
    // Resets the cards to their original position
    func returnCardsToPositions() {
        
        for (index, cardView) in cardHandViews.enumerated() {
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
                
                cardView.center = self.cards[index].originalPosition!
            })
        }
    }
    
    
    // Saves original position for cards
    func saveCardPositions() {
        
        for (index, cardView) in cardHandViews.enumerated() {
            cards[index].originalPosition = cardView.center
        }
    }
    
    
    
    
    // Soundeffects for placing cards
    func soundEffects(soundName: String) {
        
        let soundURL = Bundle.main.url(forResource: soundName, withExtension: "wav")
        
        audioPlayer = AVAudioPlayer()
      
        audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
        audioPlayer!.play()
        
        
        /*if var audioPlayer = audioPlayer {
            
            audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
            audioPlayer.play()
        }*/
        
        
    }
    
    
    
    
    
    
    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    deinit {
        calculator = nil
        
        NotificationCenter.default.removeObserver(self)
    }
    
    
}






  
  // FIX!
  /*func getImageName(cardNumber: Int) -> String {
      if mathMode == .addition {
          return "Number\(cardNumber)"
      } else {
          return "Number\(cardNumber)M"
      }
  }*/





/*
 
 
 @IBAction func scrollPicturesButton(_ sender: UIButton) {
 if sender.tag == 1 {
 
 if indexPath <= 0 {
 indexPath = 0
 } else {
 indexPath -= 1
 }
 
 }
 if sender.tag == 2 {
 
 if indexPath < picturesArray.count - 4 {
 indexPath += 1
 } else {
 indexPath = picturesArray.count - 4
 }
 
 
 
 }
 firstImage.image = picturesArray[indexPath]
 secondImage.image = picturesArray[indexPath + 1]
 thirdImage.image = picturesArray[indexPath + 2]
 fourthImage.image = picturesArray[indexPath + 3]
 print(indexPath)
 }
 
 */
