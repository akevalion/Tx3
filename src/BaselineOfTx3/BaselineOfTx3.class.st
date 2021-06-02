Class {
	#name : #BaselineOfTx3,
	#superclass : #BaselineOf,
	#category : #BaselineOfTx3
}

{ #category : #baselines }
BaselineOfTx3 >> baseline: spec [
	<baseline>
	spec for: #common do: [ 
		spec
			baseline: 'Roassal3'
			with: [ spec repository: 'github://ObjectProfile/Roassal3/src' ].
		spec
			package: 'Tx3';
			package: 'Tx3-Events';
			package: 'Tx3-Tests';
			package: 'Tx3-Roassal3' with: [spec requires: 'Roassal3'].
		spec 
			group: 'Core' with: #('Tx3' 'Tx3-Events' 'Tx3-Tests');
			group: 'default' with: #('Core' 'Tx3Roassal3')
	]
]
