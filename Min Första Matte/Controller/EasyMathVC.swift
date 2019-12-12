//
//  EasyMathVC.swift
//  Min Första Matte
//
//  Created by Henrik Jangefelt on 2019-08-08.
//  Copyright © 2019 Henrik Jangefelt Nilsson. All rights reserved.
//

import UIKit
import AVFoundation

// Bugg: Card positionerna blir inbland fel när man drar och släpper kort
// Bugg: Card vände sig på fel håll efter rätt svar (cardOirginalPositionc)

// TODO v1.1: Nivå med fler siffror (1-10, 0-10(?)) (knappar blir synliga) och "svårare" ekvationer (5 + 4) etc.
// eventuellt: 5 + X = 9


// TODO: I addition lägg till x + 0. Så man får använda nr 1 nån gång (1 + 0 = 1)

// TODO: Så länge, när man fyllt progress baren så dycker plus/minus tecken upp och man
// kan gå över till andra räknesättet

// TODO: lägg listener för alertView click

// TODO: Function for updating labels Lägg i klassen
// TODO: Fix score label

// TODO: Randomerade tal inte samma som förra gången (spara sista)

// TODO: lägg logik i klasserna!


// TODO: back button not working

// TODO: Sound effect for rejected

// TODO: Prevent memory leak. make all cards optional of Cards. Make them nil in deinit/viewDidDisappear
// FIX?: Divide code with extension?

// TODO: title (dependent of what mode?)

// TODO: Fix both addition and subtraction working

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

    
    
    var audioPlayer : AVAudioPlayer!
    var selectedSoundFileName = "Click"
    var calculator: Calculator?
    
    var mathMode = CalculationMode.addition
    var cards = [Card]() // TODO: Make optional??
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
        originalCardPositions()
    }
    
    // Sets right background color based on CalculationMode
    func setBackgroundColors(mathMode: CalculationMode) {
        
        view.backgroundColor = mathMode == .addition ? .additionLightBrown : .subtractionLightBlue
        topView.backgroundColor = mathMode == .addition ? .additionBrown : .subtractionBlue
        progressBarViewBackground.backgroundColor = mathMode == .addition ? .additionBrown : .subtractionBlue
    }
    

            
    func setMathOperatorsImages(mathMode: CalculationMode) {
                
        for cardImage in cardImages {
            
            switch cardImage.tag {
            case 8:
                cardImage.image = mathMode == .addition ? UIImage(named: "NumberPlus") : UIImage(named: "NumberMinus")
            case 9:
                cardImage.image = mathMode == .addition ? UIImage(named: "NumberEqual") : UIImage(named: "NumberEqualMinus")
            default:
                break
            }
        }
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
    
 
    

    // Puts right image on the card
    func updateCardImages() {
        
        for cardImage in cardImages {
            
            switch cardImage.tag {
                
            case 1:
                cardImage.image = UIImage(named: cards[0].imageName)
            case 2:
                cardImage.image = UIImage(named: cards[1].imageName)
            case 3:
                cardImage.image = UIImage(named: cards[2].imageName)
            case 4:
                cardImage.image = UIImage(named: cards[3].imageName)
            case 5:
                cardImage.image = UIImage(named: cards[4].imageName)
            case 6:
                cardImage.image = UIImage(named: topCards[0].imageName)
            case 7:
                cardImage.image = UIImage(named: topCards[1].imageName)
            default:
                break
            }
        }
    }
    
    
    // Updates the label text
    func updateTopCardLabels() {
          
        for label in cardLabels {
            
            switch label.tag {
            case 6:
                print("\(topCards[0].numberText)")
                label.text = topCards[0].number.convertIntToString()
            case 7:
                label.text = topCards[1].number.convertIntToString()
            default:
                continue
            }
        }
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
        disableOrEnableCardInteractions(isDisabled: true) // Enable moving/turning cards again
        
        // Hide UI elements
        WrongImage.isHidden = true
        
        /*for card in cards where card.number == 8 {
            
        }*/
        
    }
    
    

    
    // TODO: improve
    // Turns the cards back to the front side
    func flipCardsBack() {
        
        var cardViewIndex = 0
        
        for card in cards {
            if card.isFlipped {
                card.flipCardBack(cardView: cardViews[cardViewIndex])
                card.updateImageName(mathMode: mathMode)
            }
            cardViewIndex += 1
        }
        
        topCards[0].flipCardBack(cardView: cardViews[5])
        topCards[1].flipCardBack(cardView: cardViews[6])
    }
    
    
    
    // Resets the cards to their original position
    func originalCardPositions() {
    
        var cardIndex = 0
        
        for cardView in cardViews where cardView.tag <= 5 && cardView.tag > 0 {
            
            
            UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseIn, animations: {
            
                cardView.center = self.cards[cardIndex].originalPosition!

            })
            
            /*UIView.animate(withDuration: 0.3) {
                cardView.center = self.cards[cardIndex].originalPosition!
            }*/
            
            
            
            
            /*guard let position = cards[cardIndex].originalPosition else {
                print("ERROR!!! origCard pos")
                return }
            cardView.center = position*/
            cardIndex += 1
        }
    }
    

    // Saves original position for cards
    func saveCardPositions() {
        
        var cardIndex = 0
        
        // For all the cardViews with tags between 1 and 5 (the bottom cards)
        for cardView in cardViews where cardView.tag <= 5 && cardView.tag > 0 {
            cards[cardIndex].originalPosition = cardView.center
            cardIndex += 1
        }
    }
  
    
    
    
    
    
    
       // Soundeffects for placing cards
       func soundEffects() {
           let soundURL = Bundle.main.url(forResource: selectedSoundFileName, withExtension: "wav")
           
           audioPlayer = try! AVAudioPlayer(contentsOf: soundURL!)
           
           audioPlayer.play()
       }
    
   

    
    // Rounded corners, border width (and color) for Cards
    func customizeCards() {
        
        for cardView in cardViews {
            cardView.roundedCorners(myRadius: 20, borderWith: 5, myColor: .darkGray)
        }
    }
    
    
    
    
 
    
 
 
    
    
    // Disable or enable pangesture of the cards
       func disableOrEnableCardInteractions(isDisabled: Bool) {
           
           for cardView in cardViews {
               cardView.isUserInteractionEnabled = isDisabled ? true : false
           }
       }
    
    
    
    
    


    
   
    
    
    // Adds tap recognizer to all card images
    func addImageTapGesture() {
        
        for cardImage in cardImages {
            
            let cardTap = UITapGestureRecognizer(target: self, action: #selector(cardTapped(gesture:)))
            
            cardImage.addGestureRecognizer(cardTap)
        }
    }
    

    @objc func cardTapped(gesture: UITapGestureRecognizer) {
        
        for cardView in cardViews where gesture.view?.tag == cardView.tag {
            
            if gesture.view as? UIImageView != nil {

                if cardView.tag <= 5 {
                    cards[cardView.tag - 1].turnCard(cardView: cardView, mode: mathMode)
                } else { // TODO: Improve/ make better
                    topCards[cardView.tag - 6].turnCard(cardView: cardView, mode: mathMode)
                }
            }
            updateCardImages()
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
     // Returns closure expression for updating progressbar
     func updateProgressBar(isRightAnswer: Bool) -> (CGFloat, CGFloat) -> CGFloat {
         return isRightAnswer ? increaseProgress : decreaseProgress
     }
     
     // Closure expression for increasing progressbar
     let increaseProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
                 
         return barWidth >= containerWidth ? containerWidth : barWidth + (containerWidth * 0.1)
     }
     
     // Closure expression for decreasing progressbar
     let decreaseProgress: (CGFloat, CGFloat) -> CGFloat = { (barWidth: CGFloat, containerWidth: CGFloat) -> CGFloat in
         
         return barWidth < 0 ? 0.0 : barWidth - (containerWidth * 0.1)
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
            self.originalCardPositions()
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
    }
 
    
    
    
  
    // Check if dragged card is the correct one
    func validateDraggedAnswer(currentView: UIView, answerView: UIView) {
       
        guard let calculator = calculator else { return } // Unwrap instance of calculator
        
        // Position the draggedCard in the answerView
        UIView.animate(withDuration: 0.2) {
            currentView.center = answerView.center
        }
        
        let cardNumber = cards[currentView.tag - 1].number // Dragged card's number
                
        // TODO: FIX calcMode: calcualtor.addition
        if calculator.validateMathResult(calcMode: calculator.addition, numbOne: topCards[0].number, numbTwo: topCards[1].number, answer: cardNumber) {
            
            handleAnswer(answerCorrect: true)
            //answerIsCorrect() // Correct answer
        } else {
            handleAnswer(answerCorrect: false)
            //answerIsIncorrect() // Wrong answer
        }
    }
    
    
    // Function for moving (card) view
    func moveView(currentView: UIView, sender: UIPanGestureRecognizer) {
             
        let translation = sender.translation(in: view)

        currentView.center = CGPoint(x: currentView.center.x + translation.x, y: currentView.center.y + translation.y)
        sender.setTranslation(CGPoint.zero, in: view)
             
        view.bringSubviewToFront(currentView)
    }
    
    
    func getAnswerView() -> UIView? {
           
        for cardView in cardViews where cardView.tag == 8 {
            return cardView
        }
        return nil
    }
    
    
    // Handles different gesture recognizer states
    @IBAction func handlePan(sender: UIPanGestureRecognizer) {
        
        guard let handledCard = sender.view else { return }
        
        switch sender.state {
            
        case .began, .changed:
            
            moveView(currentView: handledCard, sender: sender)
            WrongImage.isHidden = true
            
        case .ended:
            
            if handledCard.frame.intersects(getAnswerView()!.frame) {
                soundEffects()
                validateDraggedAnswer(currentView: handledCard, answerView: getAnswerView()!)
            } else {
                originalCardPositions()
            }
        default:
            break
        }
    }
      
    
    @IBAction func goBackPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    deinit {
           NotificationCenter.default.removeObserver(self)
       }
    
    
}


