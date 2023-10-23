
import Foundation

var str1 = "a b c d e f g"
print(str1.components(separatedBy: " "))
print(str1.split(separator: " ").map { String($0)} )
print(str1.split(separator: " ", omittingEmptySubsequences: false).map { String($0)} )


var str2 = "aaa   bb cccc dddd    eee"
print(str2.components(separatedBy: " ") )
print(str2.split(separator: " ").map { String($0)} )
print(str2.split(separator: " ", omittingEmptySubsequences: false).map { String($0)} )


var str = """
              One of those refinements is to the String API, which has been made a lot easier to use (while also gaining power) in Swift 4. In past versions of Swift, the String API was often brought up as an example of how Swift sometimes goes too far in favoring correctness over ease of use, with its cumbersome way of handling characters and substrings. This week, let’s take a look at how it is to work with strings in Swift 4, and how we can take advantage of the new, improved API in various situations. Sometimes we have longer, static strings in our apps or scripts that span multiple lines. Before Swift 4, we had to do something like inline \n across the string, add an appendOnNewLine() method through an extension on String or - in the case of scripting - make multiple print() calls to add newlines to a long output. For example, here is how TestDrive’s printHelp() function (which is used to print usage instructions for the script) looks like in Swift 3  One of those refinements is to the String API, which has been made a lot easier to use (while also gaining power) in Swift 4. In past versions of Swift, the String API was often brought up as an example of how Swift sometimes goes too far in favoring correctness over ease of use, with its cumbersome way of handling characters and substrings. This week, let’s take a look at how it is to work with strings in Swift 4, and how we can take advantage of the new, improved API in various situations. Sometimes we have longer, static strings in our apps or scripts that span multiple lines. Before Swift 4, we had to do something like inline \n across the string, add an appendOnNewLine() method through an extension on String or - in the case of scripting - make multiple print() calls to add newlines to a long output. For example, here is how TestDrive’s printHelp() function (which is used to print usage instructions for the script) looks like in Swift 3
        """

var newString = String()

for _ in 1..<1000 {
    newString.append(str)
}

var methodStart = Date()

_  = newString.components(separatedBy: " ")
print("Execution time Separated By: \(Date().timeIntervalSince(methodStart))")

methodStart = Date()
_ = newString.split(separator: " ", omittingEmptySubsequences: false)
print("Execution time Split By: \(Date().timeIntervalSince(methodStart))")

// omittingEmptySubsequences: false
//Execution time Separated By: 0.4272289276123047
//Execution time Split By: 0.24683105945587158

// omittingEmptySubsequences: true
//Execution time Separated By: 0.2492220401763916
//Execution time Split By: 0.2456279993057251
