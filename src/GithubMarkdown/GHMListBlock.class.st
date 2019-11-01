Class {
	#name : #GHMListBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'indent'
	],
	#category : #GithubMarkdown
}

{ #category : #testing }
GHMListBlock >> addLine: inLine [
	"Create a new item, and insert it into me.
	line is on the format '1. item text'"
	|  line |
	line := inLine trim.
	self indentFromLine: line.
	^ GHMListItemBlock new
		parent: self;
		addLine: (line copyFrom: indent - parent indent to: line size)
]

{ #category : #testing }
GHMListBlock >> canConsumeLine: line [
	"to consume this line there must be a ListItem starting at the right indentation"
	line ifEmpty: [ ^ false ].
	(parent indent = 0
		or: [ line beginsWith: (' ' repeat: parent indent) ])
		ifFalse: [ ^ false ].
	^true
]

{ #category : #accessing }
GHMListBlock >> indent [
	^ indent
]

{ #category : #'as yet unclassified' }
GHMListBlock >> indentFromLine: aLine [
	"The line is expected to have the form: '<bullet> space+ [text]', where bullet is one of *,+,- or 1. or 1). more than one space is allowed. 
	The indentation returned is *the number of characters*, that is, tab counts for but one char."

	| regEx |
	indent ifNotNil: [ ^self ].
	regEx := '(\S+)(\s*)' asRegex.
	regEx matchesPrefix: aLine.
	indent := parent indent + (regEx subexpression: 1) size
]
