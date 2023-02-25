print("wordle-cli by Rick Umali")

/// TODO: Make this interact with dictionary
func getCorrectWord() -> String {
    return "aroma"
}

/// This variable holds the guess from the user
var guess: String
/// This variable tracks whether input is 5 letters or not
var goodInput: Bool
// This is two slahes BOO
var correctWord: String = getCorrectWord()
var guessRow: GuessRow
for guessCounter in 1...6 {
    goodInput = false
    // TODO: Make this repeat/while a function
    repeat {
        // TODO: Make this announce the count
        print("?", terminator: " ")
        guess = readLine()!
        print("You entered: \(guess)")
        if guess.count == 5 {
            goodInput = true
        } else {
            print("You need a five letter word!")
        }
    } while !goodInput
    guessRow = GuessRow(guess: guess.uppercased())
    // TODO: Check guess in dictionary
    guessRow.updateRow(correctWord: correctWord.uppercased())
    // TODO: Store previous GuessRows in array for redisplay?
    print(guessRow.row())
    if guessRow.matchesCorrectWord() {
        // TODO: Make this a function. Cool message per value
        print("You got it in \(guessCounter) guesses")
        break
    }
    if guessCounter == 6 {
        break
    }
}
