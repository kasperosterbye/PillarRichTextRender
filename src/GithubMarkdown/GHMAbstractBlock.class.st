Class {
	#name : #GHMAbstractBlock,
	#superclass : #Object,
	#instVars : [
		'parent',
		'children'
	],
	#category : #GithubMarkdown
}

{ #category : #adding }
GHMAbstractBlock >> addChild: childBlock [
	children add: childBlock
]

{ #category : #testing }
GHMAbstractBlock >> addLine: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	self subclassResponsibility 
]

{ #category : #testing }
GHMAbstractBlock >> blockStarterFrom: line [
	"return the class of a block which can start with line, or nil if none"

	(line beginsWith: '#')
		ifTrue: [ ^ GHMHeaderBlock ].
	(line beginsWith: '```')
		ifTrue: [ ^ GHMCodeBlock ].
	(line beginsWith: '-') | (line beginsWith: '*')
		| (line beginsWith: '+')
		ifTrue: [ ^ GHMUnorderedListBlock ].
	(line prefixMatchesRegex: '\d+(\.|\))')
		ifTrue: [ ^ GHMOrderedListBlock ].	"number followed by . or )"
	(line beginsWith: '>')
		ifTrue: [ ^ GHMBlockTextBlock ].
	line ifNotEmpty: [ ^ GHMParagraphBlock ].
	^ nil
]

{ #category : #testing }
GHMAbstractBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ self subclassResponsibility 
]

{ #category : #adding }
GHMAbstractBlock >> children [
	^children 
]

{ #category : #'as yet unclassified' }
GHMAbstractBlock >> closeMe [
	Transcript << 'Closing ' << self class name; cr; endEntry
]

{ #category : #'as yet unclassified' }
GHMAbstractBlock >> contents [
	^''
]

{ #category : #'as yet unclassified' }
GHMAbstractBlock >> contents: indent [
	| ind |
	ind := String tab repeat: indent.
	^ind, self class name, String cr, ((children collect: [:c | c contents: indent+1]) joinUsing: String cr).
]

{ #category : #accessing }
GHMAbstractBlock >> indent [
	^ parent indent
]

{ #category : #initialization }
GHMAbstractBlock >> initialize [ 
	parent := nil.
	children := OrderedCollection new.
]

{ #category : #'as yet unclassified' }
GHMAbstractBlock >> newBlockFor: line parent: parentBlock [
	| newBlockClass |
	newBlockClass := self blockStarterFrom: line.
	newBlockClass ifNil: [ ^parentBlock ].
	^ newBlockClass new
		parent: parentBlock;
		addLine: line
]

{ #category : #accessing }
GHMAbstractBlock >> parent [
	^ parent
]

{ #category : #accessing }
GHMAbstractBlock >> parent: aBlock [
	parent := aBlock.
	aBlock addChild: self
]
