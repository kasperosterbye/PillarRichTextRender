Class {
	#name : #Documenter,
	#superclass : #SpTreeTablePresenter,
	#category : #Documenter
}

{ #category : #examples }
Documenter class >> example [
<example>
	^ self new
		addColumn:
			(SpCompositeTableColumn new
				title: 'Documents';
				addColumn:
					(SpStringTableColumn new
						evaluated: #name;
						yourself);
				yourself);
		roots: DocumenterProjectNode allDocumentedProjects ;
		children: [ :elem | elem children ];
		openWithSpec
]

{ #category : #'as yet unclassified' }
Documenter class >> manifestCollections [
	"return a collection of package prefixes of manifests with a comment (package comment)"
	| commentedManifests |
	commentedManifests := PackageManifest allSubclasses select: [ :cl | cl comment notEmpty  ].
	^(commentedManifests collect: [ :cl | cl package name asString copyUpTo: $-] ) asSet asOrderedCollection sort
]

{ #category : #initialization }
Documenter >> initialize [
	super initialize.
	self whenSelectionChangedDo: [ :sel | Transcript nextPutAll: sel selectedPath printString; cr; endEntry ]
]
