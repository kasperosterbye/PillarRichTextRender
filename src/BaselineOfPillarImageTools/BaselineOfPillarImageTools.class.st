"
I am a baseline for rendering (a subset of) pillar inside the image.
I also add preliminary support for class and package comments with pillar mark-down
"
Class {
	#name : #BaselineOfPillarImageTools,
	#superclass : #BaselineOf,
	#category : #BaselineOfPillarImageTools
}

{ #category : #baselines }
BaselineOfPillarImageTools >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec
				baseline: 'PillarCore'
					with: [ spec repository:
						'github://pillar-markup/pillar:dev-7' ];
				package: 'Pillar-ExporterRichText';
				package: 'Pillar-Calypso';
				package: 'GithubMarkdown' ]
]
