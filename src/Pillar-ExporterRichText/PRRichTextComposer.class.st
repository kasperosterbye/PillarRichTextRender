"
I am a visitor that produce rich text (class Text) based on a pillar document model.
I am implemented using a canvas/brush pattern.
"
Class {
	#name : #PRRichTextComposer,
	#superclass : #PRVisitor,
	#instVars : [
		'canvas'
	],
	#category : #'Pillar-ExporterRichText'
}

{ #category : #converting }
PRRichTextComposer class >> asText: aStreamOrString [
	^ self new
		start:
			(PRPillarParserMain
				initialize;
				parse: aStreamOrString asString)
]

{ #category : #examples }
PRRichTextComposer class >> example1 [
	<example>
	(self asText:
					'!!!First section
and this is just ""first"" line 
# Line 1 More here More here More here More here More here More here More here More here More here More here
#- Kasper tries the strange thing Kasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thingKasper tries the strange thing
#- And one more --silly-- thingie
# Line 2
#-  Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
#-- Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla Bla
# Line 3') inspect
]

{ #category : #examples }
PRRichTextComposer class >> example2 [
	<example>
	(self asText:
					'!!!Description lists
this is just ""first"" line
# Here is frist enumaration
#;blue
#:color of the sky
#:and my true love''s eyes
#;red
#:color of the fire') inspect
]

{ #category : #examples }
PRRichTextComposer class >> example3 [
	<example>
	(self asText:
					'!!!Code sections
this is just ""first"" line
[[[foo=bar|jack
this is some code
and more here
]]]') inspect
]

{ #category : #examples }
PRRichTextComposer class >> example4 [
	<example>
	(self asText:
					'!!!Annotations
this is just ""first"" line
@@todo remember to do annotations
and this is the second line') inspect
]

{ #category : #examples }
PRRichTextComposer class >> example5 [
	<example>
	(self asText:
					'!!!Links
this is just ""first"" line

*Pharo>http://pharo.org/*

*String>browse://String*

*String»trim>browse://String/trim*

and this is the second line') inspect
]

{ #category : #examples }
PRRichTextComposer class >> example6 [
	<example>
	(self asText:
					'!!!Figures
this is just ""first"" line

+Pharologo>https://files.pharo.org/media/logo/logo.png+

and this is the second line') inspect
]

{ #category : #private }
PRRichTextComposer >> browse: urlString [
	"I am a url on the form: browse://Class or browse://Class/method"

	| parts class method |
	parts := urlString substrings: '/'.
	class := parts at: 2.
	method := parts size > 2
		ifTrue: [ (parts at: 3) asSymbol ]
		ifFalse: [ nil ].
	method
		ifNil: [ class asClass browse ]
		ifNotNil: [ (class asClass >> method) browse ]
]

{ #category : #private }
PRRichTextComposer >> bulletForLevel: level [
	| kind |
	kind := level % 2.
	kind = 0
		ifTrue: [ ^ $• asText ].
	kind = 1
		ifTrue: [ ^ $- asText ]
]

{ #category : #private }
PRRichTextComposer >> counterFor: counter atLevel: level [
	| kind |
	kind := level % 3.
	kind = 0
		ifTrue: [ ^ counter asString asText , '.' ].
	kind = 1
		ifTrue: [ ^ ($a asInteger + (counter - 1)) asCharacter asText , ')' ].
	kind = 2
		ifTrue: [ ^ ($A asInteger + (counter - 1)) asCharacter asText , ')' ]
]

{ #category : #private }
PRRichTextComposer >> headerLevelFont: level [
	"I return a font annotation to be used with Attributes"

	"StrikeFont actualFamilyNames an OrderedCollection(#'Bitmap DejaVu Sans' #'Bitmap Source Code Pro' #'Bitmap Source Sans Pro')"

	| fontSizes |
	fontSizes := #(24 20 18 16 14 14).
	^ TextFontReference
		toFont:
			(StrikeFont
				familyName: 'Bitmap Source Sans Pro'
				pointSize: (fontSizes at: level))
]

{ #category : #visiting }
PRRichTextComposer >> start: aDocument [
	canvas := PRRichTextCanvas new.
	self visit: aDocument.
	^ canvas contents
]

{ #category : #visiting }
PRRichTextComposer >> visit: anObject [
	anObject accept: self
]

{ #category : #visiting }
PRRichTextComposer >> visitAnchor: anObject [
	canvas << '>>> Anchors not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitAnnotatedParagraph: aDocument [
	canvas cr.
	canvas includeAttribute: (TextAlignment rightFlush) in: 
		[canvas includeAttribute: (TextColor blue) in:
			[self visitParagraph: aDocument]].
	canvas cr.
]

{ #category : #visiting }
PRRichTextComposer >> visitAnnotation: anAnnotation [
	canvas << '>>> Annotations not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitBeginEnvironmentAnnotation: aBeginEnvironmentAnnotation [

	canvas << '>>> Environments not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitBoldFormat: anObject [
	canvas includeAttribute: TextEmphasis bold in: [
	self visitFormat: anObject].
	
]

{ #category : #visiting }
PRRichTextComposer >> visitCitation: aCitation [
	canvas << '>>> Citations not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitCitationAnnotation: aCitation [
	canvas << '>>> Citations not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitCodeblock: aCodeBlock [
	canvas cr.
	canvas
		indentIn: [ canvas
				includeAttribute: TextEmphasis italic
				in: [ self visitText: aCodeBlock ] ]
]

{ #category : #visiting }
PRRichTextComposer >> visitColumn: aColumn [
	canvas << '>>> Columns not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitColumnAnnotation: aColumnAnnotation [
	canvas << '>>> Columns not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitColumns: aColumns [
	canvas << '>>> Columns not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitColumnsAnnotation: aColumnsAnnotation [
	canvas << '>>> Columns not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitDataItem: anItem [
	canvas cr.
	self visitDocumentGroup: anItem.
]

{ #category : #visiting }
PRRichTextComposer >> visitDefinitionList: anObject [
	canvas indentIn: [ self visitUnorderedList: anObject ]
]

{ #category : #visiting }
PRRichTextComposer >> visitDocListAnnotation: aPRDocListAnnotation [
	canvas << '>>> DocLists not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitEmptyParagraph: anObject [
	canvas cr
]

{ #category : #visiting }
PRRichTextComposer >> visitEndColumnsAnnotation: aEndColumnsAnnotation [
	canvas << '>>> Columns not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitEndEnvironmentAnnotation: aEndEnvironmentAnnotation [
	canvas << '>>> Environments not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitEnvironment: anObject [
	canvas << '>>> Environments not supported in RichText Pillar <<<' asText
]

{ #category : #visiting }
PRRichTextComposer >> visitExternalLink: aLink [
	| attribute target url |
	target := aLink reference.
	url := target asUrl.
	attribute := nil.
	url scheme = #http
		ifTrue: [ attribute := PRExternalLinkTextAction url: target ].
	url scheme = #browse
		ifTrue:
			[ attribute := TextAction new actOnClickBlock: [ self browse: target ] ].
	attribute
		ifNotNil:
			[ canvas includeAttribute: attribute in: [ self visitLink: aLink ] ]
		ifNil: [ self visitLink: aLink ]
]

{ #category : #visiting }
PRRichTextComposer >> visitFigure: aFigure [
	| serverUrl anchoredImage |
	serverUrl := aFigure reference.
	anchoredImage := (String value: 1) asText
		addAttribute: (TextAnchor new anchoredMorph: (ZnEasy getPng: serverUrl)).
	canvas << anchoredImage 
]

{ #category : #visiting }
PRRichTextComposer >> visitHeader: aHeader [
	canvas
		includeAttribute: (self headerLevelFont: aHeader level)
		in: [ self visitDocumentGroup: aHeader ].
	canvas cr
]

{ #category : #visiting }
PRRichTextComposer >> visitItalicFormat: anObject [
	canvas includeAttribute: TextEmphasis italic in: [ self visitFormat: anObject]
]

{ #category : #visiting }
PRRichTextComposer >> visitListItem: anItem [
	| bullet |
	"I stored the counter and bullet type in `visitOrderedList` and `visitUnorderedList`"
	bullet := (anItem propertyAt: #kind) = #ordered
		ifTrue: [ (anItem propertyAt: #counter) asString asText , Character tab ]
		ifFalse: [ (anItem propertyAt: #bullet) asText , Character tab ].
	bullet addAttribute: (TextIndent tabs: canvas nesting - 1).
	canvas cr.
	canvas << bullet.
	self visitDocumentGroup: anItem
]

{ #category : #visiting }
PRRichTextComposer >> visitMonospaceFormat: anObject [
	self
		flag:
			'Should find a way to change the font to monospaced. 
			Tricky as higher levels may change the size'.
	canvas includeAttribute: TextEmphasis narrow in: [self visitFormat: anObject].  
]

{ #category : #visiting }
PRRichTextComposer >> visitOrderedList: anObject [
	| counter |
	canvas indentIn: [counter := 1.
	anObject children
		do: [ :item | 
			item propertyAt: #kind put: #ordered.
			item
				propertyAt: #counter
				put: (self counterFor: counter atLevel: canvas nesting-1).
			counter := counter + 1 ].
	super visitOrderedList: anObject]
]

{ #category : #visiting }
PRRichTextComposer >> visitStrikethroughFormat: anObject [
	canvas includeAttribute: TextEmphasis struckOut in: [ self visitFormat: anObject ]
]

{ #category : #visiting }
PRRichTextComposer >> visitSubscriptFormat: anObject [
	canvas
		includeAttribute: TextColor red
		in: [ self visitFormat: anObject ]
]

{ #category : #visiting }
PRRichTextComposer >> visitSuperscriptFormat: anObject [
	canvas
		includeAttribute: TextColor blue
		in: [ self visitFormat: anObject ]
]

{ #category : #visiting }
PRRichTextComposer >> visitTermItem: anItem [
	canvas cr.
	canvas
		includeAttribute: (TextIndent tabs: canvas nesting - 1)
		in: [ canvas
				includeAttribute: TextEmphasis bold
				in: [ self visitDocumentGroup: anItem ] ]
]

{ #category : #visiting }
PRRichTextComposer >> visitText: anObject [
	canvas << anObject text asText
		" - should not be necessary addAttribute: (TextIndent tabs: canvas nesting)"
]

{ #category : #visiting }
PRRichTextComposer >> visitUnderlineFormat: anObject [
	canvas includeAttribute: TextEmphasis underlined in: [ self visitFormat: anObject ]
]

{ #category : #visiting }
PRRichTextComposer >> visitUnorderedList: anObject [
	canvas
		indentIn: [ anObject children
				do: [ :item | 
					item propertyAt: #kind put: #unordered.
					item
						propertyAt: #bullet
						put: (self bulletForLevel: canvas nesting - 1) ].
			super visitUnorderedList: anObject ]
]
