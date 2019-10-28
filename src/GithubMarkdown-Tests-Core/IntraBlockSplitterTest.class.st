"
An IntraBlockSplitterTest is a test class for testing the behavior of IntraBlockSplitter
"
Class {
	#name : #IntraBlockSplitterTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests-Core'
}

{ #category : #tests }
IntraBlockSplitterTest >> testMatchBoldInAt [
	| res |
	res := GHMIntraBlockSplitter new matchBoldIn: 'abc**this is bold** and this is not' at: 4.
	self assert: res equals: #('abc' 'this is bold' ' and this is not').
	res := GHMIntraBlockSplitter new matchBoldIn: 'abc__this is bold__ and this is not' at: 4.
	self assert: res equals: #('abc' 'this is bold' ' and this is not')
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlock [
	| res |
	res := GHMIntraBlockSplitter new splitBlock: 'abc'.
	self assert: res equals: {'abc'}.
	res := GHMIntraBlockSplitter new splitBlock: 'abc**bold**def'.
	self assert: res equals: {'abc' . '**bold**' . 'def'}.
	res := GHMIntraBlockSplitter new splitBlock: 'abc*italics*def'.
	self assert: res equals: {'abc' . '*italics*' . 'def'}.
	res := GHMIntraBlockSplitter new splitBlock: 'abc~strike~def'.
	self assert: res equals: {'abc' . '~strike~' . 'def'}.
	res := GHMIntraBlockSplitter new splitBlock: 'abc`block`def'.
	self assert: res equals: {'abc' . '`block`' . 'def'}
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlock2 [
	"Test with multiple annotations"
	| res |
	res := GHMIntraBlockSplitter new splitBlock: 'abc**abc**xyz*xyz*last'.
	self assert: res equals: {'abc'. '**abc**'. 'xyz'. '*xyz*'. 'last'}.
]
