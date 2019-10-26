Extension { #name : #ClyClassCommentEditorToolMorph }

{ #category : #'*Pillar-TextModel' }
ClyClassCommentEditorToolMorph >> asRenderedText [
	^ PRRichTextComposer new
		start:
			(PRPillarParserMain
				initialize;
				parse: editingClass comment)
]

{ #category : #'*Pillar-TextModel' }
ClyClassCommentEditorToolMorph >> changesAccepted [
	| res |
	res := super changesAccepted.
	self switchToRenderMode.
	^res
]

{ #category : #'*Pillar-TextModel' }
ClyClassCommentEditorToolMorph >> disable [
	textMorph enabled: false
]

{ #category : #'*Pillar-TextModel' }
ClyClassCommentEditorToolMorph >> enable [
	textMorph enabled: true
]

{ #category : #'*Pillar-TextModel' }
ClyClassCommentEditorToolMorph >> setUpModelFromContext [
	"I am being used as a kind of late initialization method"
	isRendering := true.
	self bindKeyCombination: $r command toAction: [ self toggleMode ].
	super setUpModelFromContext
]

{ #category : #'*Pillar-TextModel' }
ClyClassCommentEditorToolMorph >> switchToEditMode [
	isRendering := false.
	self enable.
	self triggerUpdate
]

{ #category : #'*Pillar-TextModel' }
ClyClassCommentEditorToolMorph >> switchToRenderMode [
	self hasUnacceptedEdits
		ifTrue: [ ^ self ].
	isRendering := true.
	self disable.
	self triggerUpdate
]

{ #category : #'*Pillar-TextModel' }
ClyClassCommentEditorToolMorph >> toggleMode [
	isRendering
		ifTrue: [ self switchToEditMode ]
		ifFalse: [ self switchToRenderMode ].
]
