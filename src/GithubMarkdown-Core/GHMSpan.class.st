Class {
	#name : #GHMSpan,
	#superclass : #Object,
	#instVars : [
		'string',
		'start',
		'end'
	],
	#category : #'GithubMarkdown-Core'
}

{ #category : #accessing }
GHMSpan >> end [
	^ end
]

{ #category : #accessing }
GHMSpan >> end: anObject [
	end := anObject
]

{ #category : #printing }
GHMSpan >> printOn: aStream [
	start to: end do: [ :index | aStream nextPut: (string at: index) ]
]

{ #category : #accessing }
GHMSpan >> start [
	^ start
]

{ #category : #accessing }
GHMSpan >> start: anObject [
	start := anObject
]

{ #category : #accessing }
GHMSpan >> string [
	^ string
]

{ #category : #accessing }
GHMSpan >> string: anObject [
	string := anObject
]
