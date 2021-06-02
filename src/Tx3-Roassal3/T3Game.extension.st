Extension { #name : #T3Game }

{ #category : #'*Tx3-Roassal3' }
T3Game >> open [
	^ (T3Visual new
		game: self;
		openWithSpec) window

]
