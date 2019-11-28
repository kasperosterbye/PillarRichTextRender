"
I am a class which produce a plant uml source code based on the tally from a block.

See example on class side
"
Class {
	#name : #PlantUMLFromTally,
	#superclass : #Object,
	#instVars : [
		'packageFilter',
		'savedSenders',
		'skipSelectors'
	],
	#category : #'Documenter-Utillities'
}

{ #category : #examples }
PlantUMLFromTally class >> example1 [
	<example>
	self openForm: (self 
		seqDiagramFor: [ Float pi printString] 
		in: {'Kernel-Numbers'. 'Collection-Strings'} 
		skipSelectors: #(on:)).
]

{ #category : #examples }
PlantUMLFromTally class >> example2 [
	<example>
	self openForm: (self seqDiagramFor: [ 4 factorial ]).
]

{ #category : #'as yet unclassified' }
PlantUMLFromTally class >> openForm: form [
	| window scrollPane |
	window := SystemWindow labelled: 'Sequence Diagram'.
	scrollPane := ScrollPane new.
	scrollPane scroller addMorph: form asMorph.
	window addMorph: scrollPane frame: (0@0 corner: 1@1).
	window openInWorld.
]

{ #category : #'as yet unclassified' }
PlantUMLFromTally class >> seqDiagramFor: aBlock [ 
	^ self seqDiagramFor: aBlock in: { '' }.
]

{ #category : #'as yet unclassified' }
PlantUMLFromTally class >> seqDiagramFor: aBlock in: packageList [
	^ self seqDiagramFor: aBlock in: packageList  skipSelectors: #()
]

{ #category : #'as yet unclassified' }
PlantUMLFromTally class >> seqDiagramFor: aBlock in: packageList skipSelectors: selectors [
	|  ulmSource |
	ulmSource := self new umlForBlock: aBlock  in: packageList  skipSelectors: selectors .
	^ PRPlantUMLUrlFromSource loadUML: ulmSource.
]

{ #category : #'as yet unclassified' }
PlantUMLFromTally >> catchAllName [
	^'Something'
]

{ #category : #initialization }
PlantUMLFromTally >> initialize [
	savedSenders := OrderedCollection new.
	savedSenders addLast: self catchAllName.
	
]

{ #category : #'as yet unclassified' }
PlantUMLFromTally >> normalized: aClass [ 
	^(packageFilter  anySatisfy: [ :pn | pn isEmpty or: [aClass category beginsWith: pn]])
		ifTrue: [ aClass name asString copyReplaceAll: ' ' with: '_'] 
		ifFalse: [ ^ self catchAllName  ]
	
]

{ #category : #'instance creation' }
PlantUMLFromTally >> tallyFor: aBlock [
	^ (MessageTally 
			tallySendsTo: nil 
			inBlock: aBlock 
			showTree: false 
			closeAfter: false 
			openResultWindow: false
		) .
]

{ #category : #'instance creation' }
PlantUMLFromTally >> umlForBlock: aBlock in: packages [
	^ self umlForBlock: aBlock in:  packages skipSelectors: #()
	
	
	
	
]

{ #category : #'instance creation' }
PlantUMLFromTally >> umlForBlock: aBlock in: packages skipSelectors: selectors [
	|outStream tally|
	packageFilter := packages.
	skipSelectors := selectors, #(tallyFor:).
	tally := self tallyFor: aBlock.
	outStream := '' writeStream.
	outStream << '@startuml';cr.
	outStream << 'skinparam shadowing false
skinparam sequence {
ParticipantFontSize 12
}'; cr.
	outStream << '-> ' << (self normalized: tally theClass ) << ': ' << tally method selector;cr.
	outStream << (self visit: tally).
	outStream << '@enduml';cr.
	^outStream contents
	
	
	
	
]

{ #category : #accessing }
PlantUMLFromTally >> visit: aTally [
	| senderName receivers receiversText|
	senderName := (self normalized: aTally theClass).
	receivers := aTally receivers reject: [:tally | skipSelectors includes: tally method selector ].
	receiversText := (receivers  collect: [ :rec | self visit: aTally to: rec ]) joinUsing: ''.
	receiversText ifNotEmpty: [ 
		senderName = self catchAllName 
			ifFalse:  [
				^'Activate ' , senderName, String cr,
			 	receiversText,
				'return return', String cr]
			ifTrue: [ ^receiversText  ]
	].
	^''.
	
	
]

{ #category : #accessing }
PlantUMLFromTally >> visit: sender to: aTally [
	| senderName receiverName selector out arrow|
	senderName := self normalized: sender theClass.
	receiverName :=  self normalized: aTally theClass.
	selector := aTally method selector.
	
	arrow := (sender theClass inheritsFrom:  aTally method methodClass)
		ifFalse: [  ' -> ' ]
		ifTrue: [ ' -->> ' ].
	out := '' writeStream .
	(receiverName  = self catchAllName)
		ifFalse: [
			(senderName = self catchAllName)
				ifTrue: [ savedSenders ifNotEmpty: [senderName := savedSenders removeLast]. 
							selector := '...', selector ].
			out 
				<< senderName 
				<< arrow
				<< receiverName
				<< ': '
				<< selector
				<< String cr.]
		ifTrue: [
			(senderName = self catchAllName)
				ifFalse: [savedSenders addLast: senderName]].
	^ out contents, (self visit: aTally)
]
