"
I am a Brush that paints the `TextIndent` on a `Text`. The actual value of the indent is picked up from the canvas. 
"
Class {
	#name : #PRRichTextIndentBrush,
	#superclass : #PRRichTextBrush,
	#category : #'Pillar-ExporterRichText'
}

{ #category : #paint }
PRRichTextIndentBrush >> paint: aText [	
	aText addAttribute: (TextIndent tabs: canvas nesting).
]
