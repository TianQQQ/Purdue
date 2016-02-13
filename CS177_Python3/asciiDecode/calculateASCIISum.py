asciiEncoding = 0

def getEncodingForFirstChar():
    global asciiEncoding
    word = input('Please enter a word: ')
    for index in range(0, len(word)):
        Letter = word[index]
        asciiEncoding += ord(Letter)
    print(asciiEncoding)
getEncodingForFirstChar()

