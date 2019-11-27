Class {
	#name : #MessageLogger,
	#superclass : #Object,
	#instVars : [
		'log'
	],
	#category : #'Documenter-SequenceDiagram'
}

{ #category : #'as yet unclassified' }
MessageLogger >> logBlock: aBlock [
	| prev logging|
	logging := false.
	prev := aBlock.
	thisContext sender
		runSimulated: aBlock
		contextAtEachStep:
			[:current |
				current == prev ifFalse: 
				["call or return"
				prev sender ifNotNil: 
					["call only"
						current closure = aBlock ifTrue:[logging := true].
						logging ifTrue: [ self halt ]
					].
				prev := current].
			]
]
