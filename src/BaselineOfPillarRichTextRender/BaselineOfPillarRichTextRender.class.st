"
I am a baseline for rendering (a subset of) pillar inside the image.
I also add preliminary support for class and package comments with pillar mark-down
"
Class {
	#name : #BaselineOfPillarRichTextRender,
	#superclass : #BaselineOf,
	#category : #BaselineOfPillarRichTextRender
}

{ #category : #baselines }
BaselineOfPillarRichTextRender >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec
				baseline: 'PillarCore' with: [ 
					spec repository: 'github://pillar-markup/pillar:dev-7' ];
				package: 'Pillar-ExporterRichText';
				package: 'GithubMarkdown';
				package: 'Pillar-Calypso' with: [ spec requires: #('Pillar-ExporterRichText' 'GithubMarkdown') ].
				
			spec
				group: 'Exporter' with: #('Pillar-ExporterRichText').
		]
]
