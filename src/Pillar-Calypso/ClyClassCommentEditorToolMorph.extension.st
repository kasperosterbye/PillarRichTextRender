Extension { #name : #ClyClassCommentEditorToolMorph }

{ #category : #'*Pillar-Calypso' }
ClyClassCommentEditorToolMorph class >> new [
	"A hack to swap in the RichText versions of the tools. "
	^ ClyRichTextClassCommentEditorToolMorph basicNew initialize
]
