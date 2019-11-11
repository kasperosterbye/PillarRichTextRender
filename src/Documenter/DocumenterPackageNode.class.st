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
