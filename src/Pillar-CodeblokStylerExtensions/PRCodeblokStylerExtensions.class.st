Class {
	#name : #PRCodeblokStylerExtensions,
	#superclass : #Object,
	#category : #'Pillar-CodeblokStylerExtensions'
}

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

{ #category : #'as yet unclassified' }
PRCodeblokStylerExtensions class >> latexMathStylerFor: aString [
	<codeblockStylerFor:'latexMath'>
	| anchoredImage serverUrl |
	serverUrl := 'https://latex.codecogs.com/png.latex?', aString urlEncoded.
	[anchoredImage := (String value: 1) asText
		addAttribute: (TextAnchor new anchoredMorph: (ZnEasy getPng: serverUrl)).
		^anchoredImage ] 
		on: Exception 
		do: [^ 'LatexError' asText addAttribute: (TextColor red)].
]
