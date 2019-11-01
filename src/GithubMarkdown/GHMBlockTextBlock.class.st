"
I represent block markup, indicated by '> ' at the beginning of a line. 
"
Class {
	#name : #GHMBlockTextBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'text'
	],
	#category : #GithubMarkdown
}

{ #category : #testing }
GHMBlockTextBlock >> addLine: line [
	"line is assumed to be of the form '> some text'
	the prefix spaces after $> are removed"

	| argText |
	argText := (line copyFrom: 2 to: line size) trim.
	text := text
		ifNil: [ argText ]
		ifNotNil: [ text , String cr , argText ]
]

{ #category : #converting }
GHMBlockTextBlock >> asPillar [
	^ PREnvironment new
		name: 'textBlock';
		setChildren:  (self splitString: text);
		yourself
]

{ #category : #testing }
GHMBlockTextBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^ line beginsWith: '>'
]

{ #category : #'as yet unclassified' }
GHMBlockTextBlock >> contents [ 
	^super contents , '[ ', self text, ' ]'
]

{ #category : #accessing }
GHMBlockTextBlock >> text [
	^ text
]
