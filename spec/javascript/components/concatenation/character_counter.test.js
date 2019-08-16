import CharacterCounter from 'components/concatenation/character_counter.js';

describe('#isUnicodeRequired', function() {
  test('when the text contains Arabic, Chinese, Korean, Japanese, or Cyrillic characters', function() {
    let counter = new CharacterCounter('こんにちは世界 this and £');
    expect(counter.isUnicodeRequired()).toBeTruthy();
  });

  test('when it only contains GSM standard and extended characters', function() {
    let counter = new CharacterCounter('This ^ That');
    expect(counter.isUnicodeRequired()).toBeFalsy();
  });
});

describe('#getSizeInBytes', function() {
  describe('only standard characters', function() {
    test('every character counts as 7-bit', function() {
      expect(new CharacterCounter('This and That').getSizeInBytes()).toEqual(12);
    });
  });

  describe('only extended characters', function() {
    test('every character counts as 2 bytes', function() {
      expect(new CharacterCounter('|^€{}[]~').getSizeInBytes()).toEqual(16);
    });
  });

  describe('mixing standard with extended characters', function() {
    test('counts each character accordingly', function() {
      expect(new CharacterCounter('This ^ That').getSizeInBytes()).toEqual(11);
    });
  });

  describe('only unicode characters', function() {
    test('every character counts as 2 bytes', function() {
      expect(new CharacterCounter('こんにちは世界').getSizeInBytes()).toEqual(14);
    });
  });

  describe('mix of everything', function() {
    test('every character count as 2 bytes because it contains unicode chars', function() {
      expect(new CharacterCounter('This and That | こん').getSizeInBytes()).toEqual(36);
    });
  });
});

describe('#getMessages', function() {
  describe('max length per SMS', function() {
    describe('just standard characters', function() {
      test('returns one Message with the text', function() {
        let text = 'a'.repeat(160);
        expect(new CharacterCounter(text).getMessages()).toEqual([text]);
      });
    });

    describe('just extended characters', function() {
      test('returns one Message with the text', function() {
        let text = '|'.repeat(70);
        expect(new CharacterCounter(text).getMessages()).toEqual([text]);
      });
    });

    describe('just unicode characters', function() {
      test('returns one Message with the text', function() {
        let text = 'こ'.repeat(70);
        expect(new CharacterCounter(text).getMessages()).toEqual([text]);
      });
    });

    describe('mix of standard and extended characters', function() {
      test('returns one Message with the text', function() {
        let text = '|'.repeat(60) + 'a'.repeat(20);
        expect(new CharacterCounter(text).getMessages()).toEqual([text]);
      });
    });

    describe('mix including unicode characters', function() {
      test('returns one Message with the text', function() {
        let text = 'こ'.repeat(60) + 'a'.repeat(10);
        expect(new CharacterCounter(text).getMessages()).toEqual([text]);
      });
    });
  });

  describe('two SMS', function() {
    describe('just standard characters', function() {
      test('splits the message in two', function() {
        let text = 'a'.repeat(161);
        expect(new CharacterCounter(text).getMessages()).toEqual(['a'.repeat(153), 'a'.repeat(8)]);
      });
    });

    describe('just extended characters', function() {
      test('splits the message in two', function() {
        let text = '|'.repeat(71);
        expect(new CharacterCounter(text).getMessages()).toEqual(['|'.repeat(66), '|'.repeat(5)]);
      });
    });

    describe('just unicode characters', function() {
      test('splits the message in two', function() {
        let text = 'こ'.repeat(71);
        expect(new CharacterCounter(text).getMessages()).toEqual(['こ'.repeat(66), 'こ'.repeat(5)]);
      });
    });

    describe('mix of standard and extended characters', function() {
      test('splits the message in two', function() {
        let text = '|'.repeat(70) + 'a';
        expect(new CharacterCounter(text).getMessages()).toEqual(['|'.repeat(66), '|'.repeat(4) + 'a']);
      });
    });

    describe('mix including unicode characters', function() {
      test('splits the message in two', function() {
        let text = 'A message with some unicode (こんにちは世界) ||||characters|||| mixed with standard and extended';
        expect(new CharacterCounter(text).getMessages()).toEqual(
          [
            'A message with some unicode (こんにちは世界) ||||characters|||| mixed wit',
            'h standard and extended',
          ]
        );
      });
    });
  });

  describe('more than 2 SMS', function() {
    test('splits the message in three', function() {
      let text = ']'.repeat(160);
      expect(new CharacterCounter(text).getMessages()).toEqual(
        [
          ']'.repeat(66),
          ']'.repeat(66),
          ']'.repeat(28)
        ]
      );
    });
  });
});

describe('#getInfo', function() {
  test('returns information about how the text is splitted into SMS', function() {
    let text = 'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
    let info = new CharacterCounter(text).getInfo();

    expect(info.unicodeRequired).toBeFalsy();
    expect(info.charactersCount).toEqual(611);
    expect(info.messages).toEqual([
      'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoc',
      'h of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything b',
      'efore us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way in short, the period was so far like the p',
      'resent period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
    ]);
  });
});
