Class {
	#name : #GHMParserTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMParserTest >> testEmpty [
	| source root |
	source := ''.
	root := GHMParser new parse: source.
	self assert: root children size equals: 0.
	source := '


'.
	root := GHMParser new parse: source.
	self assert: root children size equals: 0
]
