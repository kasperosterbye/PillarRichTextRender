Class {
	#name : #DocumenterNode,
	#superclass : #SpTreeTablePresenter,
	#category : #'Documenter-DocumenterTool'
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
