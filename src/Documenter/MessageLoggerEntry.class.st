Class {
	#name : #MessageLoggerEntry,
	#superclass : #Object,
	#instVars : [
		'sender',
		'receiver',
		'selector',
		'arguments',
		'children',
		'parent'
	],
	#category : #'Documenter-SequenceDiagram'
}

{ #category : #adding }
MessageLoggerEntry >> addChild: childEntry [
	children add: childEntry.
	childEntry parent: self.
]

{ #category : #accessing }
MessageLoggerEntry >> arguments [
	^ arguments
]

{ #category : #accessing }
MessageLoggerEntry >> arguments: anObject [
	arguments := anObject
]

{ #category : #accessing }
MessageLoggerEntry >> children [
	^ children
]

{ #category : #initialization }
MessageLoggerEntry >> initialize [ 
	children := OrderedCollection new.
]

{ #category : #accessing }
MessageLoggerEntry >> parent [
	^ parent
]

{ #category : #accessing }
MessageLoggerEntry >> parent: anObject [
	parent := anObject
]

{ #category : #printing }
MessageLoggerEntry >> printOn: aStream [
	aStream 
		<< sender class name; 
		<< ' «';
		<< sender printString;
		<< '» -> ';
		<< selector;
		<< '( '. 
	arguments printOn: aStream delimiter: ', '.
	aStream
		<< ' ) -> ';
		<< receiver class name;
		<< ' «';
		<< receiver printString;
		<< '»'
]

{ #category : #accessing }
MessageLoggerEntry >> receiver [
	^ receiver
]

{ #category : #accessing }
MessageLoggerEntry >> receiver: anObject [
	receiver := anObject
]

{ #category : #accessing }
MessageLoggerEntry >> selector [
	^ selector
]

{ #category : #accessing }
MessageLoggerEntry >> selector: anObject [
	selector := anObject
]

{ #category : #accessing }
MessageLoggerEntry >> sender [
	^ sender
]

{ #category : #accessing }
MessageLoggerEntry >> sender: anObject [
	sender := anObject
]
