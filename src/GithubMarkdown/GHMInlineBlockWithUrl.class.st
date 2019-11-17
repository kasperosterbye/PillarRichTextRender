"
I am used to represent links and images which has a url.
"
Class {
	#name : #GHMInlineBlockWithUrl,
	#superclass : #GHMInlineBlock,
	#instVars : [
		'url'
	],
	#category : #GithubMarkdown
}

{ #category : #converting }
GHMInlineBlockWithUrl >> asPillar [
	^(self class pillarNodeFromKind: self kind) new
		setChildren: ( (GHMIntraBlockSplitter new splitString: self literal) collect: [:n | n asPillar]);
		reference: self url;
		yourself
]

{ #category : #accessing }
GHMInlineBlockWithUrl >> url [
	^ url
]

{ #category : #accessing }
GHMInlineBlockWithUrl >> url: anObject [
	url := anObject
]
