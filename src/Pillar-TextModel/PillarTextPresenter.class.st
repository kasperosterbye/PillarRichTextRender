"
I am a simple """"Spec Presenter"""" which ''allow'' """"rendering of pillar source"""" in the image.See class side example of how to use.You toggle render/edit mode using the cmd-r key. Cools
"
Class {
	#name : #PillarTextPresenter,
	#superclass : #SpTextPresenter,
	#instVars : [
		'source',
		'isRendering'
	],
	#category : #'Pillar-TextModel'
}

{ #category : #examples }
PillarTextPresenter class >> example [
	<example>
	self onSource: self sampleSource.
]

{ #category : #'instance creation' }
PillarTextPresenter class >> onSource: aString [
	self new source: aString; openWithSpec
]

{ #category : #examples }
PillarTextPresenter class >> sampleSource [
	^ '!!!First section
You can toggle edit/render mode using ""command-e"" key.

Pillar supports lists:
# Line 1 More here More here More here More here More here More here More here More here More here More here
#- Even more is glorious. Even more is glorious. Even more is glorious. Even more is glorious. Even more is glorious. Even more is glorious. Even more is glorious. Even more is glorious. 
#- And one more --silly-- thingie
# Line 2
#-  Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
#-- Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
# Line 3
'
]

{ #category : #accessing }
PillarTextPresenter >> asRenderedText [
	^ PRRichTextComposer new
		start:
			(PRPillarParserMain
				initialize;
				parse: source)
]

{ #category : #initialization }
PillarTextPresenter >> initialize [
	super initialize.
	isRendering := true.
	self disable.
	self
		bindKeyCombination: $e command
		toAction: [ self toggleMode  ].
	self
		acceptBlock: [ :src | 
			self switchToRenderMode.
			false ]
]

{ #category : #accessing }
PillarTextPresenter >> source [
	^ source
]

{ #category : #accessing }
PillarTextPresenter >> source: aText [
	source := aText asString
]

{ #category : #'as yet unclassified' }
PillarTextPresenter >> switchToEditMode [
	self enable.
	isRendering := false.
	self text: source asString
]

{ #category : #'as yet unclassified' }
PillarTextPresenter >> switchToRenderMode [
	self source: self pendingText.
	self text: self asRenderedText.
	isRendering := true.
	self disable
]

{ #category : #accessing }
PillarTextPresenter >> text [
	isRendering 
		ifTrue: [ ^ self asRenderedText  ]
		ifFalse: [ ^ source ]
]

{ #category : #'as yet unclassified' }
PillarTextPresenter >> toggleMode [
	isRendering 
		ifTrue: [ self switchToEditMode  ]
		ifFalse: [ self switchToRenderMode  ]
]
