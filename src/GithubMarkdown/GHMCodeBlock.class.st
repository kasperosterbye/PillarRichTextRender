"
I am a code block. I look like this, starting and ending with three $`

```annotations
line 1
line 2
line 3
``` 

"
Class {
	#name : #GHMCodeBlock,
	#superclass : #GHMAbstractBlock,
	#instVars : [
		'code',
		'arguments',
		'done'
	],
	#category : #GithubMarkdown
}

{ #category : #'as yet unclassified' }
GHMCodeBlock class >> opensBy: aLine [
	^ aLine beginsWith: '> '
]

{ #category : #testing }
GHMCodeBlock >> addLine: line [
	"add line to this node. 
	Notice, the action is allowed to create new nodes in the block tree.
	Returns the node to handle next line - typically self."

	done
		ifTrue: [ ^ self ].
	arguments
		ifNil: [ arguments := line copyFrom: 4 to: line size ]
		ifNotNil: [ code := (code ifNil: [ line ] ifNotNil: [ code , String cr , line ])  ]
]

{ #category : #accessing }
GHMCodeBlock >> arguments [
	^ arguments
]

{ #category : #accessing }
GHMCodeBlock >> arguments: anObject [
	^ arguments := anObject
]

{ #category : #testing }
GHMCodeBlock >> canCloseWith: line [
	^ line beginsWith: '```'
]

{ #category : #testing }
GHMCodeBlock >> canConsumeLine: line [
	"return if this block can consume line"

	done
		ifTrue: [ ^ false ].
	done := line beginsWith: '```'.
	^ true
]

{ #category : #accessing }
GHMCodeBlock >> code [
	^ code
]

{ #category : #accessing }
GHMCodeBlock >> code: anObject [
	^ code := anObject
]

{ #category : #'as yet unclassified' }
GHMCodeBlock >> contents [ 
	^super contents , '[ ', self code, ' ]'
]

{ #category : #initialization }
GHMCodeBlock >> initialize [
	arguments := nil.
	done := false
]
