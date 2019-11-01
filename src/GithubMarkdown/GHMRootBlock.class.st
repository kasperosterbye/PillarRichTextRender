"
I am the root of the github markup tree
"
Class {
	#name : #GHMRootBlock,
	#superclass : #GHMAbstractBlock,
	#category : #GithubMarkdown
}

{ #category : #testing }
GHMRootBlock >> addLine: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	| newBlock |
	newBlock := self newBlockFor: line parent: self.
	^ newBlock 
]

{ #category : #testing }
GHMRootBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ true
]

{ #category : #'as yet unclassified' }
GHMRootBlock >> contents [ 
	^super contents , '[ ', self text, ' ]'
]

{ #category : #accessing }
GHMRootBlock >> indent [
	^0
]
