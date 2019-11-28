Class {
	#name : #MessageLoggerVisitor,
	#superclass : #Object,
	#instVars : [
		'out',
		'logFilters',
		'presentationFilters',
		'lastSender'
	],
	#category : #'Documenter-SequenceDiagram'
}

{ #category : #adding }
MessageLoggerVisitor >> addLogFilter: aFilterBlock [
	logFilters addLast: aFilterBlock 
]

{ #category : #adding }
MessageLoggerVisitor >> addPresentationFilter: aPresentationFilter [
	presentationFilters addLast: aPresentationFilter 
]

{ #category : #adding }
MessageLoggerVisitor >> checkLogFilters: aLogEntry [
	^logFilters  allSatisfy: [ :pred | pred value: aLogEntry  ] 
]

{ #category : #adding }
MessageLoggerVisitor >> checkPresentationFilters: aLogEntry [
	^presentationFilters allSatisfy: [ :pred | pred value: aLogEntry  ] 
]

{ #category : #'as yet unclassified' }
MessageLoggerVisitor >> intialize [
	out := String new writeStream.
	logFilters := OrderedCollection new.
]

{ #category : #visiting }
MessageLoggerVisitor >> visit: anEntry [
	(self checkPresentationFilters: anEntry)
		ifTrue: [ self writeUmlCallFor: anEntry ]
		ifFalse: [ lastSender := anEntry sender ].
	(self checkLogFilters: anEntry)
		ifTrue: [ anEntry children do: [ :child | child accept: self ] ]
]

{ #category : #writing }
MessageLoggerVisitor >> writeUmlCallFor: anEntry [
	out 
		<< anEntry sender class name; 
		<< ' -> ';
		<< anEntry receiver class name; 
		<< ': ';
		<< anEntry selector.

]
