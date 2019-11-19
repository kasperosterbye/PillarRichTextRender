"
I am the gui for the documenter.

The instance variable editingNode holds the node currently being edited in the editor. This is to allow an accept also in case of confusion of the tool.
"
Class {
	#name : #DocumenterUI,
	#superclass : #SpPresenter,
	#instVars : [
		'nodeTree',
		'editingNode',
		'editor'
	],
	#category : #Documenter
}

{ #category : #specs }
DocumenterUI class >> defaultSpec [
	^ SpBoxLayout newHorizontal 
		add: #nodeTree;
		add: #editor;
		yourself
]

{ #category : #'instance creation' }
DocumenterUI class >> open [
	<script>
	self new openWithSpec
]

{ #category : #initialization }
DocumenterUI >> initializeEditor [
	editor := PillarTextPresenter onSource: ''.
]

{ #category : #initialization }
DocumenterUI >> initializeNodeTree [
	nodeTree := Documenter new
		addColumn:
			(SpCompositeTableColumn new
				title: 'Documents';
				addColumn:
					(SpStringTableColumn new
						evaluated: #name;
						yourself);
				yourself);
		roots: DocumenterProjectNode allDocumentedProjects ;
		children: [ :elem | elem children ]
]

{ #category : #initialization }
DocumenterUI >> initializePresenter [
	"Set up call backs"
	
"Set up such that selecting a new documenternode updates the text in editor. Give warning if editor is dirty."
"Set up such that accepting a text in editor writes back to the node of the text of the editor"
	nodeTree whenSelectionChangedDo: [ :sel | self setSelectedNode: sel].
]

{ #category : #initialization }
DocumenterUI >> initializeWidgets [
	self initializeNodeTree.
	self initializeEditor.
]

{ #category : #initialization }
DocumenterUI >> setSelectedNode: sel [
	editingNode := nodeTree selectedItem.
	editor newSource: editingNode docString.
]
