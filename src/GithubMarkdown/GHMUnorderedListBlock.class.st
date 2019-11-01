Class {
	#name : #GHMUnorderedListBlock,
	#superclass : #GHMListBlock,
	#category : #GithubMarkdown
}

{ #category : #testing }
GHMUnorderedListBlock >> addLine: line [
	"Create a new item, and insert it into me."
	"line is on the format '- item text'"
	^ super addLine: line
]

{ #category : #testing }
GHMUnorderedListBlock >> canConsumeLine: line [
	"to consume this line there must be a UnorderdListItem start at the right indentation"
	^ (super canConsumeLine: line) and: ['+-*' includes: (line trim at: 1)]
]
