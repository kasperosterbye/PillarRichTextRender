"
I represent an unordered list of list items
"
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

{ #category : #converting }
GHMUnorderedListBlock >> asPillar [
	^ PRUnorderedList new
		setChildren: (self children collect:[:child| child asPillar]);
		yourself
]

{ #category : #testing }
GHMUnorderedListBlock >> canConsumeLine: line [
	"to consume this line there must be a UnorderdListItem start at the right indentation"
	^ (super canConsumeLine: line) and: [line trim matchesRegex: '(^\* |^- | ^\+).*']
]
