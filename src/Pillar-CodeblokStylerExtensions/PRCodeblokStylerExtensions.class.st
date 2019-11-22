Class {
	#name : #PRCodeblokStylerExtensions,
	#superclass : #Object,
	#classInstVars : [
		'imageCache'
	],
	#category : #'Pillar-CodeblokStylerExtensions'
}

{ #category : #accessing }
PRCodeblokStylerExtensions class >> imageCache [
	imageCache ifNil: [ imageCache := LRUCache new ].
	^imageCache
	
]

{ #category : #examples }
PRCodeblokStylerExtensions class >> latexExample [
	<example>
	(PRRichTextComposer  asText:
'!!!Latex mathematics 
It is possible to render latex math:
[[[language=latexMath
V_i = C_0 - C_3
\frac{C_1\cos(\theta_i+C_3)}{C_4+C_1\cos(\theta_i+C_2)}
]]]
Cool eh?
') inspect
]

{ #category : #styling }
PRCodeblokStylerExtensions class >> latexMathStylerFor: aString [
	<codeblockStylerFor:'latexMath'>
	| hash anchoredImage|
	hash := (SHA1 new hashStream: aString readStream) hex.
	anchoredImage := self imageCache 
		at: hash 
		ifAbsentPut: [ |  serverUrl |
			[serverUrl := 'https://latex.codecogs.com/png.latex?', aString urlEncoded.
			anchoredImage := (String value: 1) asText
				addAttribute: (TextAnchor new anchoredMorph: (ZnEasy getPng: serverUrl)).
				anchoredImage ] 
			on: Exception 
			do: ['LatexError' asText addAttribute: (TextColor red)]].
	^ anchoredImage 
]
