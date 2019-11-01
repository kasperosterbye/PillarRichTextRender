Class {
	#name : #GHMOrderedListBlock,
	#superclass : #GHMListBlock,
	#instVars : [
		'startIndex'
	],
	#category : #GithubMarkdown
}

{ #category : #testing }
GHMOrderedListBlock >> addLine: line [
	"Create a new item, and insert it into me."
	"line is on the format '1. item text'"

	self startIndexFrom: line.
	^ super addLine: line
]

{ #category : #testing }
GHMOrderedListBlock >> canConsumeLine: line [
	"to consume this line there must be a UnorderdListItem start at the right indentation"

	^ (super canConsumeLine: line) and: [line trim  prefixMatchesRegex: '\d+(\.|\))']
]

{ #category : #accessing }
GHMOrderedListBlock >> startIndex [
	^ startIndex
]

{ #category : #'as yet unclassified' }
GHMOrderedListBlock >> startIndexFrom: line [
	startIndex ifNotNil: [ ^self ].
	startIndex := line asInteger
]
