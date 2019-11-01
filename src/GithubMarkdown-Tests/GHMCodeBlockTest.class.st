"
A GHMCodeBlockTest is a test class for testing the behavior of GHMCodeBlock
"
Class {
	#name : #GHMCodeBlockTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMCodeBlockTest >> testSingleCodeBlock [
	| source root code |
	source := '```Argument
my fancy code
````'.
	root := GHMParser new parse: source.
	self assert: root children size equals: 1.
	code := root children first.
	self assert: code code equals: 'my fancy code'.
	self assert: code arguments equals: 'Argument'
]

{ #category : #tests }
GHMCodeBlockTest >> testSingleCodeBlockTwoLines [
	| source root code |
	source := '```ArgumentGoesHere
my fancy code
is really cool
````'.
	root := GHMParser new parse: source.
	self assert: root children size equals: 1.
	code := root children first.
	self
		assert: code code
		equals:
			'my fancy code
is really cool'.
	self assert: code arguments equals: 'ArgumentGoesHere'
]
