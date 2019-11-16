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
						'github://pillar-markup/pillar:0669ec63e1d2105136c3dddd1e499f6284f2fd51' ];
				package: 'Pillar-ExporterRichText';
				package: 'Pillar-TextPresenter' ]
]
