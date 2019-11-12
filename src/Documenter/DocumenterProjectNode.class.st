Class {
	#name : #DocumenterProjectNode,
	#superclass : #DocumenterNode,
	#instVars : [
		'prefix',
		'packages'
	],
	#category : #Documenter
}

{ #category : #'as yet unclassified' }
DocumenterProjectNode class >> allDocumentedProjects [
	"return a collection of ProjectNodes"
	|all|
	all := (PackageManifest allSubclasses select: [ :cl | cl comment notEmpty  ]) 
		groupedBy: [ :man | man package name asString copyUpTo: $- ].
	^ (all keys sorted collect: [ :prefix | self prefix: prefix manifests: (all at: prefix) ] ) 	
	
]

{ #category : #'as yet unclassified' }
DocumenterProjectNode class >> prefix: aString manifests: manifests [
	^self new
		prefix: aString;
		packages: (manifests collect: [:manifest| DocumenterPackageNode on: manifest package]);
		yourself
]

{ #category : #accessing }
DocumenterProjectNode >> children [
	^packages
]

{ #category : #'as yet unclassified' }
DocumenterProjectNode >> docString [
	^'There is currently no documentation in project nodes'
]

{ #category : #'as yet unclassified' }
DocumenterProjectNode >> docString: newString [
	"There is currently no documentation in project nodes - ignore"
]

{ #category : #accessing }
DocumenterProjectNode >> name [
	^prefix
]

{ #category : #accessing }
DocumenterProjectNode >> packages [
	^ packages
]

{ #category : #accessing }
DocumenterProjectNode >> packages: anObject [
	packages := anObject
]

{ #category : #accessing }
DocumenterProjectNode >> prefix [
	^ prefix
]

{ #category : #accessing }
DocumenterProjectNode >> prefix: anObject [
	prefix := anObject
]
