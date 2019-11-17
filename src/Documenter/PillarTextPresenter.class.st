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
	#category : #Documenter
}

{ #category : #examples }
PillarTextPresenter class >> example [
	<example>
	(self onSource: self sampleSource) openWithSpec
]

{ #category : #'as yet unclassified' }
PillarTextPresenter class >> guestimateIsPillar: aSource [
	"Check to see if some of the more unusual sequences from pillar is inside aSource."
	"Take care of using '#' in the beginning of the line, as there are many comments which starts with a symbol, #foo is bla bla"
	^aSource matchesRegex: '.*(""|^!|^#.*$^#|\[\[\[).*'
]

{ #category : #'instance creation' }
PillarTextPresenter class >> onSource: aString [
	^self new source: aString
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

{ #category : #'api-events' }
PillarTextPresenter >> announceDisplayed [
	"I am not sure this is the right way to set the initial color of the presenter, but it works."
	self color: self renderColor 
]

{ #category : #accessing }
PillarTextPresenter >> asRenderedText [
	^ PRRichTextComposer new
		start:
			(PRPillarParserMain
				initialize;
				parse: source)
]

{ #category : #'as yet unclassified' }
PillarTextPresenter >> defaultColor [
	isRendering ifNil: [ ^ self renderColor  ].
	isRendering 
		ifTrue: [ ^self renderColor  ]
		ifFalse: [ ^ super defaultColor  ].
	
]

{ #category : #initialization }
PillarTextPresenter >> initialize [
	super initialize.
	isRendering := true.
	self color: self renderColor .
	self disable.
	self
		bindKeyCombination: $e command
		toAction: [ self toggleMode  ].
	self
		acceptBlock: [ :src | 
			self switchToRenderMode.
			false ]
]

{ #category : #showing }
PillarTextPresenter >> openWithSpec [
	super openWithSpec .
	"self color: self renderColor "
]

{ #category : #'as yet unclassified' }
PillarTextPresenter >> renderColor [
	super defaultColor lightness < 0.5
		ifTrue: [ ^super defaultColor lighter lighter ]
		ifFalse: [ ^super defaultColor darker ]
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
	self color: (super defaultColor ).
	self text: source asString
]

{ #category : #'as yet unclassified' }
PillarTextPresenter >> switchToRenderMode [
	self source: self pendingText.
	self text: self asRenderedText.
	isRendering := true.
	self color: (self renderColor ).
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
