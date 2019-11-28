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
	| prev |
	prev := aBlock.
	thisContext sender
		runSimulated: aBlock
		contextAtEachStep: [ :current | 
			current willReturn
				ifTrue: [ self logReturn: current ]
				ifFalse: [ (current ~= prev and: [ prev sender notNil ])
						ifTrue: [ self logCall: current ] ].
			prev := current ]
]

{ #category : #'as yet unclassified' }
MessageLogger >> logCall: aContext [
	| entry |
	entry := MessageLoggerEntry new
		sender: aContext sender receiver;
		receiver: aContext receiver;
		selector: aContext methodSelector;
		arguments: ([aContext arguments] on: Exception do: [ #() ]);
		yourself.
	log ifNotNil: [log addChild: entry].
	log := entry.
]

{ #category : #'as yet unclassified' }
MessageLogger >> logReturn: aContext [
	log parent 
		ifNotNil: [ :p | log := p ]
]
