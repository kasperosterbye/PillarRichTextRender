"
I am a parser for github markdown.

I am based on the specification in https://github.github.com/gfm, in particular the parsing strategy in appendix A.
"
Class {
	#name : #GHMParser,
	#superclass : #Object,
	#instVars : [
		'current',
		'root'
	],
	#category : #GithubMarkdown
}

{ #category : #private }
GHMParser class >> allBlockNodeClasses [
	^ GHMAbstractBlock allSubclasses
		reject: [ :cl | cl category = self category ] 
]

{ #category : #'as yet unclassified' }
GHMParser >> handleErrorInLine: line [
	"This implementation is temporary.
	The right way to handle this is to insert an error node into the tree"
	
	self error: 'I was not able to handle this input'.
]

{ #category : #parsing }
GHMParser >> handleLine: line [
	| normalized |
	normalized := line copyReplaceAll: String tab with: String space.
	[(current canConsumeLine: normalized)
		ifTrue: [ ^ current := current addLine: normalized ]
		ifFalse: [ current closeMe ].
	current := current parent.
	self handleLine: normalized] on: Error do: [ self handleErrorInLine: line ]
]

{ #category : #parsing }
GHMParser >> parse: aStreamOrString [
	"returns the root node of aStreamOrText"

	| inStream line |
	current := root := GHMRootBlock new.
	inStream := aStreamOrString readStream.
	[ line := inStream nextLine.
	line isNil ] whileFalse: [ self handleLine: line ].
	[ current = root ] whileFalse: [ current closeMe. current := current parent ].
	^ root
]
