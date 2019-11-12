Class {
	#name : #DocumenterNode,
	#superclass : #SpTreeTablePresenter,
	#category : #Documenter
}

{ #category : #private }
DocumenterNode >> children [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
DocumenterNode >> docString [
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
DocumenterNode >> docString: newString [
	self subclassResponsibility 
]
