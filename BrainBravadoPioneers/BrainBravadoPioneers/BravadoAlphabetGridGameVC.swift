//
//  BravadoAlphabetGridGameVC.swift
//  BrainBravadoPioneers
//
//  Created by SunTory on 2025/3/8.
//

import UIKit

class BravadoAlphabetGridGameVC: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var hintLabel: UILabel!
    @IBOutlet weak var selectedAnswerLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var submitButton: UIButton!
    
    let gridSize = 5
    var gridLetters: [[Character]] = []
    var answer: String = ""
    var answerPositions: [(Int, Int)] = []
    var selectedAnswer = "" {
        didSet {
            selectedAnswerLabel.text = "Selected: " + selectedAnswer
        }
    }
    var hintIndex = 0
    var currentQuestionIndex = 0
    var correctAnswers = 0
    var wrongAnswers = 0
    
    struct Question {
        let question: String
        let answer: String
        let positions: [(Int, Int)]
    }
    
    let questions: [Question] = [
        Question(question: "What is the boiling point of water in Celsius?",
                 answer: "HUNDRED",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (3, 4), (2, 4)]),
        
        Question(question: "Which gas is essential for breathing?",
                 answer: "OXYGEN",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (1, 4)]),
        
        Question(question: "What is the largest ocean?",
                 answer: "PACIFIC",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (2, 4), (1, 4)]),
        
        Question(question: "What is the longest river?",
                 answer: "AMAZON",
                 positions: [(1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (0, 4)]),
        
        Question(question: "What do bees collect from flowers?",
                 answer: "NECTAR",
                 positions: [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 4)]),
        
        Question(question: "Which planet is known as the Red Planet?",
                 answer: "MARS",
                 positions: [(0, 1), (1, 1), (2, 1), (3, 1)]),
        
        Question(question: "Which metal is used in electrical wiring?",
                 answer: "COPPER",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (1, 4)]),
        
        Question(question: "What is the capital of Japan?",
                 answer: "TOKYO",
                 positions: [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4)]),
        
        Question(question: "Which vitamin is produced when exposed to sunlight?",
                 answer: "VITAMIN",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (3, 4), (2, 4)]),
        
        Question(question: "What is the capital of India?",
                 answer: "DELHI",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4)]),
        
        Question(question: "What is the hardest natural substance?",
                 answer: "DIAMOND",
                 positions: [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 4), (2, 4)]),
        
        Question(question: "Which is the tallest mountain?",
                 answer: "EVEREST",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (2, 4), (1, 4)]),
        
        Question(question: "Which is the largest mammal?",
                 answer: "WHALE",
                 positions: [(1, 0), (1, 1), (1, 2), (1, 3), (1, 4)]),
        
        Question(question: "Which bird is known for wisdom?",
                 answer: "OWL",
                 positions: [(2, 0), (2, 1), (2, 2)]),
        
        Question(question: "Which animal has the longest neck?",
                 answer: "GIRAFFE",
                 positions: [(1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (0, 4), (0, 3)]),
        
        Question(question: "Which is the closest star to Earth?",
                 answer: "SUN",
                 positions: [(3, 0), (3, 1), (3, 2)]),
        
        Question(question: "Which country is known for kangaroos?",
                 answer: "AUSTRALIA",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (2, 4), (1, 4), (0, 4)]),
        
        Question(question: "What is the currency of the USA?",
                 answer: "DOLLAR",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (3, 4)]),
        
        Question(question: "What is the national sport of Canada?",
                 answer: "HOCKEY",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (1, 4)]),
        
        Question(question: "Which shape has three sides?",
                 answer: "TRIANGLE",
                 positions: [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 4), (2, 4), (3, 4)]),
        
        
        Question(question: "Which gas do plants absorb?",
                 answer: "CARBON",
                 positions: [(1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (0, 4)]),
        
        Question(question: "What is the freezing point of water?",
                 answer: "ZERO",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3)]),
        
        Question(question: "Which planet is closest to the sun?",
                 answer: "MERCURY",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (3, 4), (2, 4)]),
        
        Question(question: "Which is the fastest land animal?",
                 answer: "CHEETAH",
                 positions: [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 4), (2, 4)]),
        
        Question(question: "Which fruit is known as the king of fruits?",
                 answer: "MANGO",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4)]),
        
        Question(question: "Which animal can change its color?",
                 answer: "CHAMELEON",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (1, 4), (0, 4), (0, 3), (0, 2)]),
        
        Question(question: "What is the smallest unit of life?",
                 answer: "CELL",
                 positions: [(1, 0), (1, 1), (1, 2), (1, 3)]),
        
        Question(question: "Which continent is the largest?",
                 answer: "ASIA",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3)]),
        
        Question(question: "What do we breathe in?",
                 answer: "OXYGEN",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (2, 4)]),
        
        Question(question: "What is the capital of England?",
                 answer: "LONDON",
                 positions: [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 4)]),
        
        Question(question: "Which bird cannot fly?",
                 answer: "PENGUIN",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (1, 4), (0, 4)]),
        
        Question(question: "What is the national currency of Japan?",
                 answer: "YEN",
                 positions: [(3, 0), (3, 1), (3, 2)]),
        
        Question(question: "Which mineral is found in salt?",
                 answer: "SODIUM",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (3, 4)]),
        
        Question(question: "Which sense organ helps us hear?",
                 answer: "EAR",
                 positions: [(1, 0), (1, 1), (1, 2)]),
        
        Question(question: "Which sport is played at Wimbledon?",
                 answer: "TENNIS",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (1, 4)]),
        
        Question(question: "Which gas makes balloons float?",
                 answer: "HELIUM",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4), (2, 4)]),
        
        Question(question: "Which ocean is the deepest?",
                 answer: "PACIFIC",
                 positions: [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 4), (2, 4)]),
        
        Question(question: "Which number comes after 999?",
                 answer: "THOUSAND",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (3, 4), (2, 4), (1, 4)]),
        
        Question(question: "Which instrument has black and white keys?",
                 answer: "PIANO",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4)]),
        
        Question(question: "Which festival is known as the festival of lights?",
                 answer: "DIWALI",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (1, 4)]),
        
        Question(question: "What is the name of our galaxy?",
                 answer: "MILKYWAY",
                 positions: [(1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (0, 4), (0, 3), (0, 2)]),
        
        Question(question: "Which metal is liquid at room temperature?",
                 answer: "MERCURY",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (3, 4), (2, 4)]),
        
        Question(question: "Which month has 28 or 29 days?",
                 answer: "FEBRUARY",
                 positions: [(0, 0), (0, 1), (0, 2), (0, 3), (0, 4), (1, 4), (2, 4), (3, 4)]),
        
        Question(question: "Which continent is also a country?",
                 answer: "AUSTRALIA",
                 positions: [(2, 0), (2, 1), (2, 2), (2, 3), (2, 4), (1, 4), (0, 4), (0, 3)]),
        
        Question(question: "Which animal has a trunk?",
                 answer: "ELEPHANT",
                 positions: [(4, 0), (4, 1), (4, 2), (4, 3), (4, 4), (3, 4), (2, 4), (1, 4)]),
        
        Question(question: "Which shape has four equal sides?",
                 answer: "SQUARE",
                 positions: [(3, 0), (3, 1), (3, 2), (3, 3), (3, 4)]),
        
        Question(question: "What is the largest desert?",
                 answer: "SAHARA",
                 positions: [(1, 0), (1, 1), (1, 2), (1, 3), (1, 4), (0, 4)]),
        
    ]



    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "BravadoAlphabetBravadoGridCell", bundle: nil), forCellWithReuseIdentifier: "BravadoAlphabetBravadoGridCell")
        loadQuestion()
    }
    
    func loadQuestion() {
        if currentQuestionIndex < questions.count {
            let currentQuestion = questions[currentQuestionIndex]
            questionLabel.text = currentQuestion.question
            answer = currentQuestion.answer
            answerPositions = currentQuestion.positions
            selectedAnswer = ""
            hintIndex = 0
            setupGrid()
            collectionView.reloadData()
            updateHintLabel()
        } else {
            showFinalScore()
            saveScore()
        }
    }
    
    func setupGrid() {
        let alphabets = Array("ABCDEFGHIJKLMNOPQRSTUVWXYZ")
        gridLetters = (0..<gridSize).map { _ in (0..<gridSize).map { _ in alphabets.randomElement()! } }
        
        for (index, pos) in answerPositions.enumerated() {
            if index < answer.count, pos.0 < gridSize, pos.1 < gridSize {
                gridLetters[pos.0][pos.1] = Array(answer)[index]
            }
        }
    }
    
    func updateHintLabel() {
        if hintIndex < answerPositions.count {
            let position = answerPositions[hintIndex]
            let letter = gridLetters[position.0][position.1]
            hintLabel.text = "Hint: Letter at [\(position.0)][\(position.1)] is '\(letter)'"
            hintIndex += 1
        } else {
            hintLabel.text = "All hints shown!"
        }
    }
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        if selectedAnswer.count < answer.count {
            showAlert(title: "Incomplete Answer", message: "You must select at least \(answer.count) letters.")
            return
        }
        
        if selectedAnswer == answer {
            correctAnswers += 1
        } else {
            wrongAnswers += 1
        }
        currentQuestionIndex += 1
        loadQuestion()
    }
    
    func showFinalScore() {
        let message = "Game Over!\nCorrect: \(correctAnswers)\nWrong: \(wrongAnswers)"
        showAlert(title: "Final Score", message: message)
    }
    
    func saveScore() {
        let finalScore = "Correct: \(correctAnswers), Wrong: \(wrongAnswers)"
        var scores = UserDefaults.standard.array(forKey: "scoreHistory") as? [String] ?? []
        scores.append(finalScore)
        UserDefaults.standard.set(scores, forKey: "scoreHistory")
    }
    
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}

extension BravadoAlphabetGridGameVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return gridSize * gridSize
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BravadoAlphabetBravadoGridCell", for: indexPath) as! BravadoAlphabetBravadoGridCell
        let row = indexPath.item / gridSize
        let col = indexPath.item % gridSize
        let letter = gridLetters[row][col]
        cell.configure(with: letter)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let row = indexPath.item / gridSize
        let col = indexPath.item % gridSize
        let letter = gridLetters[row][col]
        
        if selectedAnswer.count < answer.count {
            selectedAnswer.append(letter)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width / 5 - 5, height: collectionView.frame.height / 5 - 5)
    }
}








 
