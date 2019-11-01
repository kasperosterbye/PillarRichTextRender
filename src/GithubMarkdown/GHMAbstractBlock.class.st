"
I am the abstract node for parsing full/multi-line aspects of github mark down.

I have a set of children, and a up link to my parent.

The root of the parsetree is an instance of GHMRootBlock.

See the comment in GHMParser for an overview of the algorithm used in parsing github mark down.
"
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

{ #category : #public }
GHMAbstractBlock >> addLine: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	self subclassResponsibility 
]

{ #category : #public }
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

{ #category : #public }
GHMAbstractBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ self subclassResponsibility 
]

{ #category : #adding }
GHMAbstractBlock >> children [
	^children 
]

{ #category : #public }
GHMAbstractBlock >> closeMe [
	Transcript << 'Closing ' << self class name; cr; endEntry
]

{ #category : #public }
GHMAbstractBlock >> contents [
	^''
]

{ #category : #public }
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

{ #category : #public }
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
