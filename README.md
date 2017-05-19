# spaCy API Docker

Flask based REST API for spaCy, the great and fast NLP framework.
Supports the English and German language models and returns the analysis structured by sentences and by token.

Please note that currently the dependency trees and word vectors are not being returned.

## New in version 0.3
- Updated to spaCy 1.8.0
- Default english language

## Usage

```
curl http://localhost:5000/api --header 'content-type: application/json' --data '{"text": "This is a text that I want to be analyzed."}' -X POST
```

You'll receive a JSON in return:

```
{
  'sentences': [[TOKEN, TOKEN, ...], [TOKEN, TOKEN, ...], ...],
  'performance': CALCULATION_TIME_IN_SEC,
  'version': SPACY_VERSION,
  'numOfSentences': NUM_OF_SENTENCES,
  'numOfTokens': NUM_OF_TOKENS
}
```

```
TOKEN: {
  'token': TOKEN,
  'lemma': LEMMA,
  'tag': TAG,
  'ner': NER,
  'offsets': {
    'begin': BEGIN,
    'end': END
  },
  'oov': OUT_OF_VOCAB,
  'stop': IS_STOPWORD,
  'url': IS_URL,
  'email': IS_MAIL,
  'num': IS_NUM,
  'pos': POS
}
```

### API fields

Field | Explanation
------|------------
text  | One text to be analyzed
texts | List of texts to be analyzed
fields| Optional. A list of token data fields that should be analyzed. Example: ['pos', 'token']

Either 'text' or 'texts' is required.

## Installation
### Docker build
```
sudo docker build -t spacy-en .
```

## Docker Run
### Docker
```
sudo docker run --name spacy-en -d --net=host spacy-en
```

## Example
### Simple
#### Request
```
curl http://localhost:5000/api --header 'content-type: application/json' --data '{"text": "Angela Merkel loves spending holiday in Italy."}' -X POST
```

#### Response
```
{  
   "sentences":[  
      [  
         {  
            "offsets":{  
               "end":6,
               "begin":0
            },
            "token":"Angela",
            "stop":false,
            "email":false,
            "oov":false,
            "url":false,
            "tag":"NNP",
            "pos":"PROPN",
            "ner":"PERSON",
            "lemma":"angela",
            "num":false
         },
         {  
            "offsets":{  
               "end":13,
               "begin":7
            },
            "token":"Merkel",
            "stop":false,
            "email":false,
            "oov":false,
            "url":false,
            "tag":"NNP",
            "pos":"PROPN",
            "ner":"PERSON",
            "lemma":"merkel",
            "num":false
         },
         {  
            "offsets":{  
               "end":19,
               "begin":14
            },
            "token":"loves",
            "stop":false,
            "email":false,
            "oov":false,
            "url":false,
            "tag":"VBZ",
            "pos":"VERB",
            "ner":"",
            "lemma":"love",
            "num":false
         },
         {  
            "offsets":{  
               "end":28,
               "begin":20
            },
            "token":"spending",
            "stop":false,
            "email":false,
            "oov":false,
            "url":false,
            "tag":"VBG",
            "pos":"VERB",
            "ner":"",
            "lemma":"spend",
            "num":false
         },
         {  
            "offsets":{  
               "end":36,
               "begin":29
            },
            "token":"holiday",
            "stop":false,
            "email":false,
            "oov":false,
            "url":false,
            "tag":"NN",
            "pos":"NOUN",
            "ner":"",
            "lemma":"holiday",
            "num":false
         },
         {  
            "offsets":{  
               "end":39,
               "begin":37
            },
            "token":"in",
            "stop":true,
            "email":false,
            "oov":false,
            "url":false,
            "tag":"IN",
            "pos":"ADP",
            "ner":"",
            "lemma":"in",
            "num":false
         },
         {  
            "offsets":{  
               "end":45,
               "begin":40
            },
            "token":"Italy",
            "stop":false,
            "email":false,
            "oov":false,
            "url":false,
            "tag":"NNP",
            "pos":"PROPN",
            "ner":"GPE",
            "lemma":"italy",
            "num":false
         },
         {  
            "offsets":{  
               "end":46,
               "begin":45
            },
            "token":".",
            "stop":false,
            "email":false,
            "oov":false,
            "url":false,
            "tag":".",
            "pos":"PUNCT",
            "ner":"",
            "lemma":".",
            "num":false
         }
      ]
   ],
   "performance":[
      0.002523183822631836
   ],
   "numOfTokens":8,
   "numOfSentences":1,
   "lang":"en",
   "error":false,
   "version":"1.2.0"
}
```

### Multiple texts & selected fields
#### Request
```
curl --request POST \
  --url http://localhost:5000/api \
  --header 'content-type: application/json' \
  --data '{
	"texts": ["Here comes Peter.", "And so does Mary."],
	"fields": ["pos", "token", "lemma"]
}'
```
#### Response
```
{
	"numberOfTexts": 2,
	"performance": [
		0.003515958786010742
	],
	"version": "1.2.0",
	"texts": [
		{
			"numOfSentences": 1,
			"sentences": [
				[
					{
						"token": "Here",
						"pos": "ADV",
						"lemma": "here"
					},
					{
						"token": "comes",
						"pos": "VERB",
						"lemma": "come"
					},
					{
						"token": "Peter",
						"pos": "PROPN",
						"lemma": "peter"
					},
					{
						"token": ".",
						"pos": "PUNCT",
						"lemma": "."
					}
				]
			],
			"numOfTokens": 4
		},
		{
			"numOfSentences": 1,
			"sentences": [
				[
					{
						"token": "And",
						"pos": "CONJ",
						"lemma": "and"
					},
					{
						"token": "so",
						"pos": "ADV",
						"lemma": "so"
					},
					{
						"token": "does",
						"pos": "VERB",
						"lemma": "do"
					},
					{
						"token": "Mary",
						"pos": "PROPN",
						"lemma": "mary"
					},
					{
						"token": ".",
						"pos": "PUNCT",
						"lemma": "."
					}
				]
			],
			"numOfTokens": 5
		}
	],
	"lang": "en",
	"error": false
}
```
