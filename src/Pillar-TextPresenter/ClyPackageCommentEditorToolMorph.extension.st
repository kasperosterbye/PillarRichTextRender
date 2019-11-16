Extension { #name : #ClyPackageCommentEditorToolMorph }

{ #category : #'*Pillar-TextPresenter' }
ClyPackageCommentEditorToolMorph class >> new [
	"A hack to swap in the RichText versions of the tools. "
	^ ClyPackageRichTextCommentEditorToolMorph  basicNew initialize
]
