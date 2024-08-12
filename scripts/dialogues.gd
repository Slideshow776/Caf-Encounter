class_name Dialogues
extends Node

var dialogue_items: Array[Dictionary] = [
	{ # 0
		"expressionA": "rage",
		"expressionB": "serious",
		"text": "You're sick in the head, what's wrong with [shake]you[/shake]?!",
		"choices": {
			"I understand you're upset.
				I'm scared, may you please
				leave me alone?": 0,
			"I feel like you shouldn't
				talk like that, to anyone!": -1,
			"Whatever, weirdo": -2,
		},
	},
	{ # 1
		"expressionA": "fear",
		"expressionB": "serious",
		"text": "You'll never be a woman you freak. Your just a [shake]biological[/shake] man in a dress!",
		"choices": {
			"You’re worried about safety,
				And questioning my identity?
				Is that right?": 0,
			"Why are you being so mean?": -1,
			"What the fuck is wrong with you?": -2,
			
		},
	},
	{ # 2
		"expressionA": "very angry",
		"expressionB": "tired",
		"text": "Women and girls need to be safe in the bathroom from [shake]freaks[/shake] like you!",
		"choices": {
			"So, you’re concerned about
				the safety of women and girls?": 0,
			"Leave me alone, weirdo": -1,
			"You're insufferable!": -2,			
		},
	},
	{ # 3
		"expressionA": "rage",
		"expressionB": "eyes closed",
		"text": "You're [shake]not[/shake] a woman! You can't go in there!",
		"choices": {
			"I’m feeling hurt.
				I need to be seen as I am.
				May you please leave me alone?": 0,
			"Oh, are we doing one of these?": -1,
			"What's wrong with you?": -2,
			
		},
	},
	{ # 4
		"expressionA": "driven",
		"expressionB": "annoyed",
		"text": "That's the [shake]women's[/shake] bathroom!",
		"choices": {
			"I'm feeling scared right now.
				I just needed to use the bathroom": 0,
			"Yes, and I'm a woman?": -1,
			"Fuck off transphobe": -2,
			
		},
	},
	{ # 5
		"expressionA": "very angry",
		"expressionB": "serious",
		"text": "Hey, What are you doing?",
		"choices": {
			"I'm feeling a bit confused.
				Would you please
				tell me what's up?": 0,
			"I... went to the bathroom?": -1,
			"Get lost, weirdo!": -2,
			
		},
	},
	{ # 6
		"expressionA": "explaining",
		"expressionB": "smile",
		"text": "Do you think that's okay? Transgender men like you shouldn't use the women's bathroom!",
		"choices": {
			"So, you're worried about men
				using the women's bathroom?": 0,
			"The women's bathroom
				are for all women": -1,
			"What?
				Clearly, you're an idiot...": -2,
		},
	},
	{ # 7
		"expressionA": "very angry",
		"expressionB": "serious",
		"text": "You need to be respectful of women who are traumatized by penises!",
		"choices": {
			"So, you're wanting respect
				for women, especially those
				who are traumatized?": 0,
			"You need to be respectful,
				in general": -1,
			"The fuck are you on about?": -2,
		},
	},
	{ # 8
		"expressionA": "very angry",
		"expressionB": "smile",
		"text": "I just want everyone to be safe. And I feel you should want that too.",
		"choices": {
			"I also want everyone to be
				safe. And right now I'm
				feeling kinda scared": 0,
			"How about leaving
				me alone then?": -1,
			"Cool story, bro": -2,
		},
	},
	{ # 9
		"expressionA": "very angry",
		"expressionB": "contempt",
		"text": "Well, I still don't feel you should use the women's bathroom. It's very rude of you.",
		"choices": {
			"I hear you think it's rude.
				I need to go now. Goodbye": 0,
			"Well, no one asked you...": -1,
			"Get lost...": -2,
		},
	},
]
