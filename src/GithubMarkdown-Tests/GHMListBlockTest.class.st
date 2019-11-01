"
A GHMListBlockTest is a test class for testing the behavior of GHMListBlock
"
Class {
	#name : #GHMListBlockTest,
	#superclass : #TestCase,
	#category : #'GithubMarkdown-Tests'
}

{ #category : #tests }
GHMListBlockTest >> testIndentFromLine [
	| root listBlock |
	root := GHMRootBlock new.
	listBlock := GHMListBlock new parent: root.
	self assert: [listBlock indentFromLine: '- joe';indent] value equals: 2.
	listBlock := GHMListBlock new parent: root.
	self assert: [listBlock indentFromLine: '*  joe';indent] value equals: 3.
	listBlock := GHMListBlock new parent: root.
	self assert: [listBlock indentFromLine: '10. joe';indent] value equals: 4.
]
