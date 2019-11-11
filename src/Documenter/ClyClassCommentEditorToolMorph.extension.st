Extension { #name : #ClyClassCommentEditorToolMorph }

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> asRenderedText [
	^ PRRichTextComposer new
		start:
			(PRPillarParserMain
				initialize;
				parse: editingClass comment)
]

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> changesAccepted [
	| res |
	res := super changesAccepted.
	self switchToRenderMode.
	^res
]

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> disable [
	textMorph enabled: false
]

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> editingText [
	^ editingClass comment
]

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> enable [
	textMorph enabled: true
]

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> setUpModelFromContext [
	"I am being used as a kind of late initialization method"
	isRendering := true.
	self bindKeyCombination: $r command toAction: [ self toggleMode ].
	super setUpModelFromContext
]

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> switchToEditMode [
	isRendering := false.
	self enable.
	self triggerUpdate
]

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> switchToRenderMode [
	self hasUnacceptedEdits
		ifTrue: [ ^ self ].
	isRendering := true.
	self disable.
	self triggerUpdate
]

{ #category : #'*Documenter' }
ClyClassCommentEditorToolMorph >> toggleMode [
	isRendering
		ifTrue: [ self switchToEditMode ]
		ifFalse: [ self switchToRenderMode ].
]
