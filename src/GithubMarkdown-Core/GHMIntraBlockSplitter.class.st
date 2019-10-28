Class {
	#name : #GHMIntraBlockSplitter,
	#superclass : #Object,
	#category : #'GithubMarkdown-Core'
}

{ #category : #'as yet unclassified' }
GHMIntraBlockSplitter >> match: size in: aString at: start [
	| end |
	end := aString
		findString: (aString copyFrom: start to: start + size -1)
		startingAt: start + size.
	^ end+size
]

{ #category : #'as yet unclassified' }
GHMIntraBlockSplitter >> matchBlockIn: aString at: start [
	^ self match: 1 in: aString at: start
]

{ #category : #'as yet unclassified' }
GHMIntraBlockSplitter >> matchBoldIn: aString at: start [
	| end |
	end:= self match: 2 in: aString at: start.
	^(self spanOn: aString from: start+2 to: end-2)->#bold
]

{ #category : #'as yet unclassified' }
GHMIntraBlockSplitter >> matchItalicsIn: aString at: start [
	^ self match: 1 in: aString at: start
]

{ #category : #'as yet unclassified' }
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
	^ 0.
]

{ #category : #'as yet unclassified' }
GHMIntraBlockSplitter >> matchStrikeOutIn: aString at: start [
	^ self match: 1 in: aString at: start
]

{ #category : #'private - utilities' }
GHMIntraBlockSplitter >> spanOn: aString from: start to: end [
	^GHMSpan new string: aString; start: start; end: end; yourself
]

{ #category : #'as yet unclassified' }
GHMIntraBlockSplitter >> splitBlock: aString [
	| start end size |
	start := aString indexOfAnyOf: self startSet.
	start = 0 ifTrue: [ ^{ aString } ].
	end := self matchMarkdownIn: aString at: start.
	end = 0 ifTrue: [ [ ^{ aString } ] ].
	^ {(aString copyFrom: 1 to: start - 1).
	(aString copyFrom: start  to: end - 1).
	self splitBlock: (aString copyFrom: end  to: aString size)} flattened
	
	
]

{ #category : #'as yet unclassified' }
GHMIntraBlockSplitter >> startSet [
	^'*_~¨`[!'.
]
