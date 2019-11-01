"
I am an intra-line github markdown parser.
I handle emphasis (bold, italics, strikethrough), inlined code, links and images.

My main method is the #splitBlock:. 

No other method is part of the api.
"
Class {
	#name : #GHMIntraBlockSplitter,
	#superclass : #Object,
	#category : #GithubMarkdown
}

{ #category : #private }
GHMIntraBlockSplitter >> match: size in: aString at: start [
	| end |
	end := aString
		findString: (aString copyFrom: start to: start + size - 1)
		startingAt: start + size.
	^ end + size
]

{ #category : #private }
GHMIntraBlockSplitter >> matchBlockIn: aString at: start [
	| next |
	next := self match: 1 in: aString at: start.
	^ self
		spanOn: aString
		from: start + 1
		to: next - 2
		next: next
		kind: #block
]

{ #category : #private }
GHMIntraBlockSplitter >> matchBoldIn: aString at: start [
	| next |
	next := self match: 2 in: aString at: start.
	^ self
		spanOn: aString
		from: start + 2
		to: next - 3
		next: next
		kind: #bold
]

{ #category : #'as yet unclassified' }
GHMIntraBlockSplitter >> matchImageIn: aString at: start [
	"image annotation ![AltText](url)"

	| regex text url next |
	regex := RxMatcher forString: '!\[(.*)\]\((.*)\)'.
	regex matches: (aString copyFrom: start to: aString size).
	text := regex subexpression: 2.
	url := regex subexpression: 3.
	next := start + (regex subexpression: 1) size.
	^ GHMInlineBlockWithUrl new
		string: aString;
		start: start + 2;
		end: start + 2 + text size - 1;
		url: url;
		next: next;
		kind: #image
]

{ #category : #private }
GHMIntraBlockSplitter >> matchItalicsIn: aString at: start [
	| next |
	next := self match: 1 in: aString at: start.
	^ self
		spanOn: aString
		from: start + 1
		to: next - 2
		next: next
		kind: #italics
]

{ #category : #private }
GHMIntraBlockSplitter >> matchMarkdownIn: aString at: start [
	| char |
	char := aString at: start.
	char = $* | (char = $_)
		ifTrue: [ (aString at: start + 1) = $*
				ifTrue: [ ^ self matchBoldIn: aString at: start ]
				ifFalse: [ ^ self matchItalicsIn: aString at: start ] ].
	char = $~
		ifTrue: [ ^ self matchStrikeOutIn: aString at: start ].
	char = $`
		ifTrue: [ ^ self matchBlockIn: aString at: start ].
	char = $!
		ifTrue: [ ^ self matchImageIn: aString at: start ].
	^ nil
]

{ #category : #private }
GHMIntraBlockSplitter >> matchStrikeOutIn: aString at: start [
	| next |
	next := self match: 1 in: aString at: start.
	^ self
		spanOn: aString
		from: start + 1
		to: next - 2
		next: next
		kind: #strike
]

{ #category : #private }
GHMIntraBlockSplitter >> spanAllOf: aString kind: kind [
	^ GHMInlineBlock new
		string: aString;
		start: 1;
		end: aString size;
		next: aString size;
		kind: kind;
		yourself
]

{ #category : #private }
GHMIntraBlockSplitter >> spanOn: aString from: start to: end next: next kind: kind [
	^ GHMInlineBlock new
		string: aString;
		start: start;
		end: end;
		next: next;
		kind: kind;
		yourself
]

{ #category : #public }
GHMIntraBlockSplitter >> splitString: aString [
	| start block rest |
	start := aString indexOfAnyOf: self startSet.
	start = 0
		ifTrue: [ ^ {(self spanAllOf: aString kind: #plain)} ].
	block := self matchMarkdownIn: aString at: start.
	block end = 0
		ifTrue: [ ^ {(self spanAllOf: aString kind: #plain)} ].
	rest := #().
	block next < aString size
		ifTrue: [ rest := self
				splitString: (aString copyFrom: block next to: aString size) ].
	^ {(self
		spanOn: aString
		from: 1
		to: start - 1
		next: start
		kind: #plain).
	block split} , rest
]

{ #category : #private }
GHMIntraBlockSplitter >> startSet [
	^'*_~¨`[!'.
]
