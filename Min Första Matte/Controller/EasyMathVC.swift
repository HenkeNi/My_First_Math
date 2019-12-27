//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation


// RENAME: BASIC MATH


// Memory Leaks
// Make all cards optional of Cards. Make them nil in deinit/viewDidDisappear
// TODO: sätt array av cards till optional eller sätt korten i arrayen till att vara optionals



// FÖRSLAG: Slumpa ut fem btm kort, kolla scoren, när man får mer poäng blir det svårare tal, och vid mindre poäng blir det lättare tal...

// GÖr 3 + ? = 5 senare


// Change: back button not working (VC presented in smaller window)



// ADD: Add question mark image to answerView
// ADD: Multiply, subtract
// TODO: Sound effect for rejected
// TODO: title (dependent of what mode?)
// TODO: Fix both addition and subtraction working



// Bugg: Card positionerna blir inbland fel när man drar och släpper kort
// Bugg: Card vände sig på fel håll efter rätt svar (cardOirginalPositionc)



// TODO: I addition lägg till x + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)?


// TODO: GÖR ENgen scroll view? med pan gesture som bytar sifforna


// TODO: Så länge, när man fyllt progress baren så dycker plus/minus tecken upp och man
// kan gå över till andra räknesättet


// TODO: Function for updating labels Lägg i klassen
// TODO: Fix score label

// TODO: Randomerade tal inte samma som förra gången (spara sista)


let nxtLvlNotificationKey = "co.HenrikJangefelt.nxtLvl"

class EasyMathVC: UIViewController {
    
    // TODO: make part of object?
    @IBOutlet var cardViews: [UIView]!
    @IBOutlet var cardImages: [UIImageView]!
    @IBOutlet var cardLabels: [UILabel]!
    
    @IBOutlet weak var WrongImage: UIImageView! // Wrong images
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var progressBarViewBackground: UIView!
    @IBOutlet weak var progressBarContainer: UIView!
    @IBOutlet weak var progressBarWidth: NSLayoutConstraint!
    @IBOutlet weak var scoreLabel: UILabel!

    
    
    @IBOutlet var btmCardViews: [UIView]!
    
    
    
    
    var selectedSoundFileName = "Click"
    var mathMode = CalculationMode.addition
    var audioPlayer: AVAudioPlayer! // TODO: make optional
    var calculator: Calculator?
    
    var cards = [Card]() // TODO: Make optional?? || sätt arrayen till empty i deinit
    var topCards = [Card]() // TODO: property in object (isTopCard)
    
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
        //nextLevel()
        
     
    }
    
    
    
    
    
    func createObserver() {
        
        let name = Notification.Name(rawValue: nxtLvlNotificationKey)
        
        NotificationCenter.default.addObserver(self, selector: #selector(EasyMathVC.updateLevel(notification:)), name: name, object: nil)
    }
    
    
    @objc func updateLevel(notification: NSNotification) {
        nextLevel()
        returnCardsToPositions()
    }
    
    
   

            

    
    
    
    
    
    func createBottomCards(mathMode: CalculationMode) {
           
        let subtractionMode = mathMode == .addition ? 0 : 1
           
        for cardNumber in 1...5 {
            let card = Card()
            card.number = cardNumber - subtractionMode
            card.updateImageName(mathMode: mathMode)
            cards.append(card)
        }
    }
 
    
    
    func createTopCards() {
        
        let firstTopCard = Card()
        let secondTopCard = Card()
        topCards.append(firstTopCard)
        topCards.append(secondTopCard)
    }
    
 
 
    
    

    
    
    // TODO: improve
    func getRandomNumbers() -> (Int, Int) {
        let numberRandomizer = NumberRandomizer()
        
        let startNumber = mathMode == .addition ? 1 : 0
        let endNumber = mathMode == .addition ? 4 : 4
        let condition = mathMode == .addition ? numberRandomizer.additionCondition : numberRandomizer.subtractionCondition
        return numberRandomizer.numberRandomizer(startNumber: startNumber, endNumber: endNumber, condition: condition)

    }
    
    func nextLevel() {
        
        //scoreLabel.text = "Score: \(score)"

        
        //let numberRandomizer = NumberRandomizer()
        
        
        
        //let randomNumbers = numberRandomizer.numberRandomizer(startNumber: <#T##Int#>, endNumber: <#T##Int#>, condition: <#T##(Int, Int) -> Bool#>)
        
        //let randomNumbers = numberRandomizer.randomizeTwoNumbers(mathMode: mathMode)
        
        let randomNumbers = getRandomNumbers()
        
        topCards[0].number = randomNumbers.0
        topCards[1].number = randomNumbers.1
        
        topCards[0].updateImageName(mathMode: mathMode)
        topCards[1].updateImageName(mathMode: mathMode)
        
        flipCardsBack() // Turns all card to front side
        
        updateCardImages()
        updateTopCardLabels()
        //disableOrEnableCardInteractions(isDisabled: true) // Enable moving/turning cards again
        
        // Hide UI elements
        WrongImage.isHidden = true
        
        /*for card in cards where card.number == 8 {
            
        }*/
        
    }
    
    

    
    // BEHÖVS det att flippa tillbaka topCards? Sätt istället isFlipped till false
    // TODO: improve
    // Turns the cards back to the front side
    func flipCardsBack() {
        
        //var cardViewIndex = 0
        
        for (index, card) in cards.enumerated() {
            if card.isFlipped {
                card.flipCardBack(cardView: cardViews[index])
                card.updateImageName(mathMode: mathMode)
            }
            //cardViewIndex += 1
        }
        
        topCards[0].flipCardBack(cardView: cardViews[5])
        topCards[1].flipCardBack(cardView: cardViews[6])
    }
    
    
    
    // Resets the cards to their original position
    func returnCardsToPositions() {
    
        //var cardIndex = 0
        
        for (index, cardView) in cardViews.enumerated() where cardView.tag <= 5 && cardView.tag > 0 {
            
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
                cardView.center = self.cards[index].originalPosition!

            })
            
            /*UIView.animate(withDuration: 0.3) {
                cardView.center = self.cards[cardIndex].originalPosition!
            }*/
            
            
            
            
            /*guard let position = cards[cardIndex].originalPosition else {
                print("ERROR!!! origCard pos")
                return }
            cardView.center = position*/
           
            //cardIndex += 1
        }
    }
    

    // Saves original position for cards
    func saveCardPositions() {
        
        //var cardIndex = 0
        
        // For all the cardViews with tags between 1 and 5 (the bottom cards)
        for (index, cardView) in cardViews.enumerated() where cardView.tag <= 5 && cardView.tag > 0 {
            cards[index].originalPosition = cardView.center
            //cardIndex += 1
        }
    }
  
    
    
    
    
    
    
       // Soundeffects for placing cards
       func soundEffects() {
           let soundURL = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "wav")
           
           audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
           
           audioPlayer.play()
       }
    
   

    

    
    
    
 
    
 
 
    
    
    // Disable or enable pangesture of the cards
       func disableOrEnableCardInteractions(isDisabled: Bool) {
           
           for cardView in cardViews {
               cardView.isUserInteractionEnabled = isDisabled ? true : false
           }
       }
    
    
    
    
    


    
   
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
 
    
    
    
    
    
    
    
    
    
    
    
    
 
    

    
    
    
    func answerIsCorrect() {

        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            AlertView.instance.showAlert(title: "Correct!", message: "That is the right number!", alertType: .success)
        }

        //let updateProgress = updateProgressBar(isRightAnswer: true) // Sets update to be of type increaseProgress
        //progressBarWidth.constant = updateProgress(progressBarWidth.constant, progressBarContainer.frame.size.width)
        
        
          score += 10

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
    func validateDraggedAnswer(currentView: UIView, answerView: UIView) {
       
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
           
        for cardView in cardViews where cardView.tag == 8 {
            return cardView
        }
        return nil
    }
    
    

      
    
    
    
    
    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    
    
    deinit {
        calculator = nil
        NotificationCenter.default.removeObserver(self)
       }
    
    
}


