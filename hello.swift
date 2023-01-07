import Foundation


func welcome() {
	print("Welcome to CryptoApp!")
    mainMenu()
}

func mainMenu(){
    currentMenu = "main"
    print("\nMENU: choose one by entering number!\n1-Cryptocurrencies\n2-Profile\n3-Help\n4-Exit")
    let input = readLine()
    if input == "1"{
        cryptoMenu()
    }
    if input == "2"{
        profileMenu()
    }
    if input == "3"{
        helpMenu()
    }
    if input == "4" || input == "0" {
        exitProgram()
    }
    else{
        print("\nWrong input! try agian.\n")
        mainMenu()
    }
}

func profileMenu(){
    currentMenu = "profile"
    print("\nProfile menu: choose one by entering number!")
    print("Your username is: " + username)
    print("1-Change username")
    print("2-Exit")
    let input = readLine()
    if input == "1"{
        print("\nEnter your new username.")
        if let newUsername = readLine(){
            if newUsername == ""{
                print("it can't be empty! try again.")
                profileMenu()
            }else{
                username = newUsername
                print("your username succesfully changed to " + username)
                profileMenu()
            }
        }
       
    }
    if input == "2"{
        mainMenu()
    }
    if input == "0"{
        exitProgram()
    }
    else{
        print("\nwrong input! try agian.\n")
        profileMenu()
    }
}

func cryptoMenu(){
    currentMenu = "crypto"
    print("\nCrypto menu:")
    print("List of your cryptocurrencies are as below: (You can see them in more detail by entering their name)")

    
    for (i, coin) in cryptoList.enumerated(){
        print("\(i+1).\(coin)")
    }
    
    print("______________________\n1-Add more coins\n2-Remove a coin\n3-Exit ")
    
    let input = readLine()
    for (i, coin) in cryptoList.enumerated(){
        if input == cryptoList[i]{
            coinMenu(coin : coin)
        }
    }
    
    if input == "1"{
        addMenu()
    }
    if input == "2" {
        removeMenu()
    }
    
    if input == "3"{
        mainMenu()
    }
    if input == "0"{
        exitProgram()
    }
    else{
        print("\nwrong input! try again.\n")
        cryptoMenu()
    }
}

func coinMenu(coin : String){
    print("\nYou have selected \(coin).\nEnter start and end date to see prices, input format should be (yyyy-MM-dd)")
    print("Enter start date:")
    let startDate = readLine()!
    print("Enter end date:")
    let endDate = readLine()!
    
    let dateFormatterGet = DateFormatter()
    dateFormatterGet.dateFormat = "yyyy-MM-dd"    
    
    if dateFormatterGet.date(from: startDate) != nil && dateFormatterGet.date(from: endDate) != nil && endDate >= startDate {
        var start = dateFormatterGet.date(from: startDate)!
        let end = dateFormatterGet.date(from: endDate)!

        let diff = Calendar.current.dateComponents([.day], from: start, to: end).day! + 1
        print("\nList of prices:")
        for _ in 1...diff{
            
            print("date: "+dateFormatterGet.string(from: start) + "        Price: \(cryptoPrice[coin]![dateFormatterGet.string(from: start)]!)")
            start = Calendar.current.date(byAdding: .day, value: 1, to: start)!
        }
  
    } else if endDate < startDate {
        print("\nError:start date should be before end date!")
    } else {
        print("\nError:invalid dates!")
    }   
    
    print("_____________________\n1-back to crypto menu\n2-back to main menu")
    let input = readLine()
    if input == "1"{
        cryptoMenu()
    }
    if input == "2"{
        mainMenu()
    }
    if input == "0"{
        exitProgram()
    }
    
}

func addMenu() {
    print("\nAdd menu: You can add following cryptocurrencies to your list by entering their name.")
   
    var count = 0
    for coin in allCryptoes {
        if !cryptoList.contains(coin){
            count += 1
            print("\(count).\(coin)")
        }
    }
    
    let input = readLine()!
    if allCryptoes.contains(input){
        cryptoList.append(input)
        print("\(input) added to your list.")
        addMenu()
    }
    
    print("______________________")
    print("1-back to crypto menu")

    if input == "1"{
        cryptoMenu()
    }
    if input == "0"{
        exitProgram()
    } 
    else{
        print("\nwrong input! try again.\n")
        addMenu()
    }

}

func removeMenu(){
    print("\nRemove menu: You can remove cryptocurrencies from your list by entering their name.")
    for (i, coin) in cryptoList.enumerated(){
        print("\(i+1).\(coin)")
    }
    let input = readLine()!
    
    for (i, coin) in cryptoList.enumerated(){
        if input == cryptoList[i]{
            if let index = cryptoList.firstIndex(of: input) {
                cryptoList.remove(at: index)
            }
            print("\(input) removed from your list.")
            removeMenu()
        }
    }
    
    print("______________________")
    print("1-back to crypto menu")
    
    if input == "1"{
        mainMenu()
    }
    if input == "0"{
        exitProgram()
    }
    else{
        print("\nwrong input! try again.\n")
        cryptoMenu()
    }
    
}



func helpMenu(){
    currentMenu = "help"
    print("\n__Help__")
    print("You can navigate through program by entering numbers.\nTo exit program entirely enter 0")
    print("now you can enter 1 to exit help menu\n1-Exit")
    let input = readLine()
    if input == "1"{
        mainMenu()
    }
    if input == "0"{
        exitProgram()
    }
    else{
        print("\nwrong input! try agian.\n")
        helpMenu()
    }
}

func exitProgram(){
    print("\nbye!")
    exit(0)
}




var cryptoList = ["BTC", "ETH"]
var allCryptoes = ["BTC","ETH","USDC","USDC","BNB"]
var cryptoPrice = ["test" : [String : Int]()]
let dateFormatterGet = DateFormatter()
dateFormatterGet.dateFormat = "yyyy-MM-dd"  

for c in allCryptoes {
    let strDate = "2022-12-1"
    var date = dateFormatterGet.date(from: strDate)!
    var datePrice = [String : Int]()
    
    for _ in 1...30 {
        datePrice[dateFormatterGet.string(from: date)] = Int.random(in: 100..<10000)
        date = Calendar.current.date(byAdding: .day, value: 1, to: date)!
    }
    
    cryptoPrice[c] = datePrice
}

var currentMenu = "main"
var username = "cryptoUser"
welcome()