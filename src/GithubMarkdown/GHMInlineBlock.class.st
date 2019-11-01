"
I represent the tree node used to handle ""intra-line-markup"", emphasis, inline code, images and urls.


"
Class {
	#name : #GHMInlineBlock,
	#superclass : #Object,
	#instVars : [
		'string',
		'start',
		'end',
		'kind',
		'next',
		'children'
	],
	#category : #GithubMarkdown
}

{ #category : #'as yet unclassified' }
GHMInlineBlock class >> pillarNodeFromKind: kind [
	kind = #plain
		ifTrue: [ ^ PRText ].
	kind = #bold
		ifTrue: [ ^ PRBoldFormat ].
	kind = #italics
		ifTrue: [ ^ PRItalicFormat ].
	kind = #block
		ifTrue: [ ^ PRMonospaceFormat ].
	kind = #strike
		ifTrue: [ ^ PRStrikethroughFormat ].
	
	kind = #image ifTrue: [ ^PRFigure  ].
	kind = #link ifTrue: [ ^PRExternalLink   ].
]

{ #category : #converting }
GHMInlineBlock >> asPillar [
	self kind = #plain
		ifTrue: [ ^ PRText new text: self literal ].
	(#(#bold #italics #block #strike) includes: self kind)
		ifTrue: [ ^ (self class pillarNodeFromKind: self kind) new
				setChildren: {(PRText new text: self literal)};
				yourself ]
]

{ #category : #accessing }
GHMInlineBlock >> children [
	^ children
]

{ #category : #accessing }
GHMInlineBlock >> children: anObject [
	children := anObject
]

{ #category : #accessing }
GHMInlineBlock >> end [
	^ end
]

{ #category : #accessing }
GHMInlineBlock >> end: anObject [
	end := anObject
]

{ #category : #accessing }
GHMInlineBlock >> kind [
	^ kind
]

{ #category : #accessing }
GHMInlineBlock >> kind: anObject [
	kind := anObject
]

{ #category : #accessing }
GHMInlineBlock >> literal [
	^string copyFrom: start to: end. 
]

{ #category : #accessing }
GHMInlineBlock >> next [
	^ next
]

{ #category : #accessing }
GHMInlineBlock >> next: anObject [
	next := anObject
]

{ #category : #printing }
GHMInlineBlock >> printOn: aStream [
	children
		ifNotNil: [ |preSpace| preSpace := false. aStream nextPut: $[.
			children
				do: [ :each | 
					preSpace ifTrue:[aStream nextPut: Character space] ifFalse: [ preSpace := true ].
					each printOn: aStream.].
			aStream nextPut: $] ]
		ifNil:
			[ start to: end do: [ :index | aStream nextPut: (string at: index) ] ]
]

{ #category : #'as yet unclassified' }
GHMInlineBlock >> split [
	"if there is any internal structure to the block, decompose it and add children"

	| parts |
	parts := GHMIntraBlockSplitter  new splitString: self printString.
	parts size = 1 & (parts first kind = #Plain)
		ifTrue: [ ^ self ].
	self children: parts
]

{ #category : #accessing }
GHMInlineBlock >> start [
	^ start
]

{ #category : #accessing }
GHMInlineBlock >> start: anObject [
	start := anObject
]

{ #category : #accessing }
GHMInlineBlock >> string [
	^ string
]

{ #category : #accessing }
GHMInlineBlock >> string: anObject [
	string := anObject
]
