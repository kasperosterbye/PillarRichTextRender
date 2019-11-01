Class {
	#name : #GHMHeaderBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'level',
		'header'
	],
	#category : #GithubMarkdown
}

{ #category : #testing }
GHMHeaderBlock >> addLine: line [
	"Line is on the form '#### my heading at forth level'"
	level := ('(#+)' asRegex
		matchesPrefix: line;
		subexpression: 1) size.
	header := (line copyFrom: level + 1 to: line size) trim.
	^ self
]

{ #category : #testing }
GHMHeaderBlock >> canConsumeLine: line [
	"return if this block can consume line"

	^false "Headers are always one line"
]

{ #category : #'as yet unclassified' }
GHMHeaderBlock >> contents [ 
	^super contents , '[ ', self level printString, '/', self header, ' ]'
]

{ #category : #'as yet unclassified' }
GHMHeaderBlock >> formattedCode [ 
	^super formattedCode , '[ ', self level printString, '/', self header, ' ]'
]

{ #category : #accessing }
GHMHeaderBlock >> header [
	^ header
]

{ #category : #accessing }
GHMHeaderBlock >> level [
	^ level
]
