{
  "PhraseGroups" : [
    {
      "name" : null,
      "Phrases" : [
        {
          // influences probability of being chosen
          "weight" : 1.0,
          
          // weight is multiplied by the number of items in the given
          // PhraseGroups
          "weightFactors" : [ ],
          
          // can never be used again for this sentence
          "isUnique" : false,
          
          // allowed in text strings:
          //   $phraseGroup; A random phrase from the given PhraseGroup
          //   @util A special utility, processed after all phrase substitutions
          //     @a Automatically choose a or an to match the next word
          //     @^ Capitalize the next letter
          //     @-suffix; Attempt to add the given suffix to the next word
          //     @:prefix; Attempt to add the given prefix to the next word
          "text" : null
        }
      ]
    }
  ]
}

