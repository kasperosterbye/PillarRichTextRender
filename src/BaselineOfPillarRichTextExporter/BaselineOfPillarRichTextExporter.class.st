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
		do: [ spec blessing: #development.
			spec
				baseline: 'PillarCore'
					with: [ spec repository: 'github://pillar-markup/pillar:dev-7/src' ];
				package: 'Pillar-ExporterRichText' ]
]
