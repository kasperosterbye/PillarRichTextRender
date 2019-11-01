"
I represent one item in a list (ordered or non-ordered)
"
Class {
	#name : #GHMListItemBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'text'
	],
	#category : #GithubMarkdown
}

{ #category : #testing }
GHMListItemBlock >> addLine: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	| normalized |
	text
		ifNil: [ text := line trim.
			^ self ].
	normalized := line copyFrom: parent indent + 1 to: line size.	"drop indent"
	({GHMOrderedListBlock.
	GHMUnorderedListBlock} includes: (self blockStarterFrom: normalized))
		ifTrue: [ ^ self newBlockFor: normalized parent: self ]
		ifFalse: [ text := text , String cr , normalized ]
]

{ #category : #converting }
GHMListItemBlock >> asPillar [
	^ PRListItem new
		setChildren: (self splitString: text), (self children collect: [:child| child asPillar]);
		yourself
]

{ #category : #testing }
GHMListItemBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ line beginsWith: (' ' repeat: parent indent)
]

{ #category : #'as yet unclassified' }
GHMListItemBlock >> contents [ 
	^super contents , '[ ', self text, ' ]'
]

{ #category : #accessing }
GHMListItemBlock >> text [
	^ text
]
