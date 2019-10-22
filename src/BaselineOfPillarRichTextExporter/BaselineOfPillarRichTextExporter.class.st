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
					with: [ spec repository: 'github://pillar-markup/pillar:504c7a499c7ff5a5788110eb87ec252e055ba07a' ];
				package: 'Pillar-ExporterRichText' ]
]
