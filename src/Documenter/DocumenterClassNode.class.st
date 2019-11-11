Class {
	#name : #DocumenterClassNode,
	#superclass : #DocumenterNode,
	#instVars : [
		'class'
	],
	#category : #Documenter
}

{ #category : #'instance creation' }
DocumenterClassNode class >> on: aClass [
	^self new forClass: aClass; yourself
]

{ #category : #private }
DocumenterClassNode >> children [
	^#()
]

{ #category : #'instance creation' }
DocumenterClassNode >> forClass: aClass [
	class := aClass 
]

{ #category : #accessing }
DocumenterClassNode >> name [
	^class name
]
