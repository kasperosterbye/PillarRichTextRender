Class {
	#name : #DocumenterClassNode,
	#superclass : #DocumenterNode,
	#instVars : [
		'class'
	],
	#category : #'Documenter-DocumenterTool'
}

{ #category : #'instance creation' }
DocumenterClassNode class >> on: aClass [
	^self new forClass: aClass; yourself
]

{ #category : #private }
DocumenterClassNode >> children [
	^#()
]

{ #category : #'as yet unclassified' }
DocumenterClassNode >> docString [
	^ class comment
]

{ #category : #'as yet unclassified' }
DocumenterClassNode >> docString: newString [
	class comment: newString
]

{ #category : #'instance creation' }
DocumenterClassNode >> forClass: aClass [
	class := aClass 
]

{ #category : #accessing }
DocumenterClassNode >> name [
	^class name
]
