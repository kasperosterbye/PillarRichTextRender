Class {
	#name : #ClyRichTextClassCommentEditorToolMorph,
	#superclass : #ClyClassCommentEditorToolMorph,
	#instVars : [
		'isRendering'
	],
	#category : #'Pillar-TextModel'
}

{ #category : #'*Pillar-TextModel' }
ClyRichTextClassCommentEditorToolMorph >> asRenderedText [
	^ PRRichTextComposer new
		start:
			(PRPillarParserMain
				initialize;
				parse: editingClass comment)
]

{ #category : #'*Pillar-TextModel' }
ClyRichTextClassCommentEditorToolMorph >> changesAccepted [
	| res |
	res := super changesAccepted.
	self switchToRenderMode.
	^res
]

{ #category : #'*Pillar-TextModel' }
ClyRichTextClassCommentEditorToolMorph >> disable [
	textMorph enabled: false
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> editText [
	isRendering 
		ifTrue: [ ^ self asRenderedText  ]
		ifFalse: [ ^ super editText ]
]

{ #category : #'*Pillar-TextModel' }
ClyRichTextClassCommentEditorToolMorph >> enable [
	textMorph enabled: true
]

{ #category : #'*Pillar-TextModel' }
ClyRichTextClassCommentEditorToolMorph >> setUpModelFromContext [
	"I am being used as a kind of late initialization method"
	isRendering := true.
	self bindKeyCombination: $r command toAction: [ self toggleMode ].
	super setUpModelFromContext
]

{ #category : #'*Pillar-TextModel' }
ClyRichTextClassCommentEditorToolMorph >> switchToEditMode [
	isRendering := false.
	self enable.
	self triggerUpdate
]

{ #category : #'*Pillar-TextModel' }
ClyRichTextClassCommentEditorToolMorph >> switchToRenderMode [
	self hasUnacceptedEdits
		ifTrue: [ ^ self ].
	isRendering := true.
	self disable.
	self triggerUpdate
]

{ #category : #'*Pillar-TextModel' }
ClyRichTextClassCommentEditorToolMorph >> toggleMode [
	isRendering
		ifTrue: [ self switchToEditMode ]
		ifFalse: [ self switchToRenderMode ].
]
