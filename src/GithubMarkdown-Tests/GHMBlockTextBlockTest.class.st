"
A GHMBlockTextBlockTest is a test class for testing the behavior of GHMBlockTextBlock
"
Class {
	#name : #GHMBlockTextBlockTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMBlockTextBlockTest >> testSingleBlockTextBlock [
	| source root text |
	source := '> text1
>    text2'.
	root := GHMParser new parse: source.
	self assert: root children size equals: 1.
	text := root children first.
	self
		assert: text text
		equals:
			'text1
text2'
]
