"
I represent an ordered list of list items
"
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

{ #category : #converting }
GHMOrderedListBlock >> asPillar [
	^ PROrderedList new
		setChildren: (self children collect: [ :child | child asPillar ]);
		counter: self startIndex;
		yourself
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
