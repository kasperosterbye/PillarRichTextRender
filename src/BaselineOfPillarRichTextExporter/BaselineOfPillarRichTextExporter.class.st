Class {
	#name : #BaselineOfPillarRichTextExporter,
	#superclass : #BaselineOf,
	#category : #BaselineOfPillarRichTextExporter
}

{ #category : #baselines }
BaselineOfPillarRichTextExporter >> baseline: spec [
	<baseline>
	spec
		for: #common
		do: [ spec blessing: #baseline.
			spec
				baseline: 'PillarCore'
					with: [ spec repository:
						'github://pillar-markup/pillar:0669ec63e1d2105136c3dddd1e499f6284f2fd51' ];
				package: 'Pillar-ExporterRichText' ]
]
