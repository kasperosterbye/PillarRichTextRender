"
A GHMRootBlockTest is a test class for testing the behavior of GHMRootBlock
"
Class {
	#name : #GHMRootBlockTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMRootBlockTest >> testRootAsPillar [
	| source root pillar |
	source := '####    Level four
## Level 2'.
	root := GHMParser new parse: source.
	pillar := root asPillar.
	self assert: pillar class equals: PRDocument.
	self assert: pillar children second class equals: PRHeader .
	self assert: pillar children first level equals: 4
]
