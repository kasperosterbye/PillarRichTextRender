"
An IntraBlockSplitterTest is a test class for testing the behavior of IntraBlockSplitter
"
Class {
	#name : #IntraBlockSplitterTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
IntraBlockSplitterTest >> testAsPillarPlain [
	| res |
	res := GHMIntraBlockSplitter new pillarFrom: 'abc'.
	self assert: res first text equals: 'abc'.
	self assert: res first class equals: PRText.
	res := GHMIntraBlockSplitter new pillarFrom: 'abc*xyz*cba'.
	self assert: res second children first text equals: 'xyz'.
	self assert: res second class equals: PRItalicFormat.
	res := GHMIntraBlockSplitter new pillarFrom: 'abc[alias](link)cba'.
	self assert: res second children first text equals: 'alias'.
	self assert: res second class equals: PRExternalLink.
	res := GHMIntraBlockSplitter new pillarFrom: 'abc![alias](link)cba'.
	self assert: res second children first text equals: 'alias'.
	self assert: res second reference equals: 'link'.
	self assert: res second class equals: PRFigure 
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlock [
	| res |
	res := GHMIntraBlockSplitter new splitString: 'abc'.
	self assert: res first printString equals: 'abc'.
	res := GHMIntraBlockSplitter new splitString: 'abc**bold**def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[bold]' . 'def'}.
	self assert: res second kind equals: #bold.
	res := GHMIntraBlockSplitter new splitString: 'abc*italics*def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[italics]' . 'def'}.
	self assert: res second kind equals: #italics.
	res := GHMIntraBlockSplitter new splitString: 'abc~strike~def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[strike]' . 'def'}.
	self assert: res second kind equals: #strike.
	res := GHMIntraBlockSplitter new splitString: 'abc`block`def'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[block]' . 'def'}.
	self assert: res second kind equals: #block
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlock2 [
	"Test with multiple annotations"

	| res |
	res := GHMIntraBlockSplitter new
		splitString: 'abc**abc**xyz`xyz`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[abc]' . 'xyz' . '[xyz]' . 'last'}
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockImage [
	"Test the image annotation ![AltText](url)"

	| res |
	res := GHMIntraBlockSplitter new
		splitString: 'abc![AltText](imageAddress)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[AltText]' . 'last'}.
	self assert: res second url equals: 'imageAddress'
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockLink [
	"Test the link annotation [LinkText](url)"

	| res |
	res := GHMIntraBlockSplitter new
		splitString: 'abc[LinkText](myURL)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[LinkText]' . 'last'}.
	self assert: res second url equals: 'myURL'
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockLinkIncomplete [
	"Test the annotation [LinkText] -> should return a link with url as linktext"

	| res |
	res := GHMIntraBlockSplitter new
		splitString: 'abc[LinkText]last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[LinkText]' . 'last'}.
	self assert: res second url equals: 'LinkText'
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockLinkInlineImage [
	"Test the link annotation [![alttext](imageurl)](url)"

	| res |
	res := GHMIntraBlockSplitter new
		splitString: 'abc[![alttext](imageurl)](url)last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[ [alttext]]' . 'last'}.
	self assert: res second children second url equals: 'imageurl'
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitBlockNested [
	"Test with multiple annotations"

	| res |
	res := GHMIntraBlockSplitter new
		splitString: 'abc`xxx**www**yyy`last'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'abc' . '[xxx [www] yyy]' . 'last'}.
	self assert: res second children second kind equals: #bold
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitEmpty [
	| res |
	res := GHMIntraBlockSplitter new splitString: ''.
	self assert: res first printString equals: ''.
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitExclamationMark [
	"Test that 'bla!bla' is ok, and not a failed image, same goes for '![goo]no parenthesis'"

	| res |
	res := GHMIntraBlockSplitter new splitString: 'bla!bla'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'bla!bla'}.
	res := GHMIntraBlockSplitter new splitString: '![goo]no parenthesis'.
	self
		assert: (res collect: [ :x | x printString ])
		equals: {'![goo]no parenthesis'}
]

{ #category : #tests }
IntraBlockSplitterTest >> testSplitNotClosed [
	| res |
	res := GHMIntraBlockSplitter new splitString: 'abc**xyz'.
	self assert: res second printString equals: '[xyz]'.
	res := GHMIntraBlockSplitter new splitString: 'abc**xyz*'.
	self assert: res second printString equals: '[xyz*]'.
]
