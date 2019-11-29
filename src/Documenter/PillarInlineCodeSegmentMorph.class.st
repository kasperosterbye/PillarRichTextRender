"
I am a segment morph intended to span inline code segments (as known from github markdown `this thing`)
"
Class {
	#name : #PillarInlineCodeSegmentMorph,
	#superclass : #RubTextSegmentMorph,
	#category : #'Documenter-Utillities'
}

{ #category : #initialization }
PillarInlineCodeSegmentMorph >> defaultBorderColor [
	^ Color blue 

]

{ #category : #initialization }
PillarInlineCodeSegmentMorph >> defaultColor [
	^ Color pink alpha: 0.5.

]
