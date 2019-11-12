Class {
	#name : #DocumenterPackageNode,
	#superclass : #DocumenterNode,
	#instVars : [
		'package'
	],
	#category : #Documenter
}

{ #category : #'as yet unclassified' }
DocumenterPackageNode class >> metacelloPackageNodes [
	^self metacelloPackages collect: [ :p | self on: p ]
]

{ #category : #'as yet unclassified' }
DocumenterPackageNode class >> metacelloPackages [
	^ RPackageOrganizer default packages asOrderedCollection  select: [ :p | p name beginsWith: 'Metacello' ]
]

{ #category : #'instance creation' }
DocumenterPackageNode class >> on: package [
	^self new package: package; yourself
]

{ #category : #private }
DocumenterPackageNode >> children [
	^ package package classes asOrderedCollection collect: [ :cl | DocumenterClassNode on: cl ]
]

{ #category : #'as yet unclassified' }
DocumenterPackageNode >> docString [
	"logic is stolen from ClyPackageCommentEditorToolMorph>>editingText.
	At some point it should be moved into RPackage to avoid code duplication"
	^ package packageManifestOrNil 
		ifNil: [ 'Please comment package here' "ClyPackageCommentEditorToolMorph>>packageCommentBlank" ]
		ifNotNil: [ :manifest | 
			manifest hasComment 
				ifTrue: [ manifest comment ] 
				ifFalse: [ self packageCommentBlank ] ]
]

{ #category : #'as yet unclassified' }
DocumenterPackageNode >> docString: newString [
	package packageManifest comment: newString stamp: Author changeStamp.
]

{ #category : #accessing }
DocumenterPackageNode >> name [
	^package name
]

{ #category : #accessing }
DocumenterPackageNode >> package [
	^ package
]

{ #category : #accessing }
DocumenterPackageNode >> package: anObject [
	package := anObject
]
