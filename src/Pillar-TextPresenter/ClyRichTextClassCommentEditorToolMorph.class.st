"
I am a replacement tool for """"class"""" comments. 
"
Class {
	#name : #ClyRichTextClassCommentEditorToolMorph,
	#superclass : #ClyClassCommentEditorToolMorph,
	#instVars : [
		'isRendering'
	],
	#category : #'Pillar-TextPresenter'
}

{ #category : #activation }
ClyRichTextClassCommentEditorToolMorph class >> classCommentTabActivation [ 
	"Do nothing - part of a hack for overriding the class comment tool in Calypso"
]

{ #category : #activation }
ClyRichTextClassCommentEditorToolMorph class >> classTabActivation [  
	"Do nothing - part of a hack for overriding the class comment tool in Calypso"
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> asRenderedText [
	^ PRRichTextComposer new
		start:
			(PRPillarParserMain
				initialize;
				parse: super editingText )
]

{ #category : #building }
ClyRichTextClassCommentEditorToolMorph >> buildTextMorph [
	super buildTextMorph.
	self setBackgroundColor: self renderColor.
	self bindKeyCombination: $r command toAction: [ self toggleMode ].
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> changesAccepted [
	| res |
	res := super changesAccepted.
	self switchToRenderMode.
	^res
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> disable [
	textMorph enabled: false
]

{ #category : #rendering }
ClyRichTextClassCommentEditorToolMorph >> editColor [
	^self theme backgroundColor 
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> editingText [
	isRendering 
		ifTrue: [ ^ self asRenderedText  ]
		ifFalse: [ ^ super editingText ]
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> enable [
	textMorph enabled: true
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> initialize [
	super initialize.
	isRendering := true.

]

{ #category : #rendering }
ClyRichTextClassCommentEditorToolMorph >> renderColor [
	self theme backgroundColor lightness < 0.5
		ifTrue: [ ^ self theme backgroundColor lighter ]
		ifFalse: [ ^self theme backgroundColor darker ]
]

{ #category : #initialization }
ClyRichTextClassCommentEditorToolMorph >> setBackgroundColor: aColor [
	"Convenience method to set my background color"
	textMorph color: aColor
	
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> switchToEditMode [
	isRendering := false.
	self enable.
	self setBackgroundColor: (self editColor ).
	self triggerUpdate
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> switchToRenderMode [
	self hasUnacceptedEdits
		ifTrue: [ ^ self ].
	isRendering := true.
	self setBackgroundColor: (self renderColor ).
	self disable.
	self triggerUpdate
]

{ #category : #'as yet unclassified' }
ClyRichTextClassCommentEditorToolMorph >> toggleMode [
	isRendering
		ifTrue: [ self switchToEditMode ]
		ifFalse: [ self switchToRenderMode ].
]
