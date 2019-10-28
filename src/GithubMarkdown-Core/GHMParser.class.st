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
	#category : #'GithubMarkdown-Core'
}

{ #category : #private }
GHMParser class >> allBlockNodeClasses [
	^ GHMAbstractBlock allSubclasses
		reject: [ :cl | cl category = self category ] 
]

{ #category : #parsing }
GHMParser >> handleLine: line [
	| normalized |
	normalized := line copyReplaceAll: String tab with: String space.
	(current canConsumeLine: normalized)
		ifTrue: [ ^ current := current addLine: normalized ]
		ifFalse: [ current closeMe ].
	current := current parent.
	self handleLine: normalized
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
