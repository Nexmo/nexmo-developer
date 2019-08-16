import difference from 'lodash/difference'

const GSM_STANDARD_CHARS = [
  '@', '0', '¡', 'P', '¿',
  'p', '£', '_', '!', '1',
  'A', 'Q', 'a', 'q', '$',
  '"', '2', 'B', 'R', 'b',
  'r', '¥', '?', '#', '3',
  'C', 'S', 'c', 's', 'è',
  '?', '4', 'D', 'T', 'd',
  't', 'é', '?', '%', '5',
  'E', 'U', 'e', 'u', 'ù',
  '6', 'F', 'V', 'f', 'v',
  'ì', '?', "'", '7', 'G',
  'W', 'g', 'w', 'ò', '(',
  '8', 'H', 'X', 'h', 'x',
  'Ç', ')', '9', 'I', 'Y',
  'i', 'y', '*', ':', 'J',
  'Z', 'j', 'z', 'Ø', '+',
  ';', 'K', 'Ä', 'k', 'ä',
  'Æ', ',', '<', 'L', 'l',
  'ö', 'æ', '-', '=', 'M',
  'Ñ', 'm', 'ñ', 'Å', 'ß',
  '.', '>', 'N', 'Ü', 'n',
  'ü', 'å', 'É', '/', 'O',
  '§', 'o', 'à', ' '
]

const GSM_EXTENDED_CHARS = [
  '|', '^', '€', '{', '}', '[', ']', '~', '\\'
]

const BYTE_SIZE = 8;
const CHARACTER_SIZE = 7;
const GSM_METADATA_LENGTH = 7;
const GSM_METADATA_SIZE = GSM_METADATA_LENGTH * CHARACTER_SIZE;
const GSM_MAX_SIZE = 140 * BYTE_SIZE;

class CharacterCounter {
  constructor(text) {
    this.text = text;
  }

  getInfo() {
    let messages = this.getMessages();
    return {
      messages: messages,
      unicodeRequired: this.isUnicodeRequired(),
      charactersCount: messages.reduce(function(sum, sms) { return sum + sms.length }, 0)
    }
  }

  isUnicodeRequired() {
    let remainder = difference([...this.text], [...GSM_STANDARD_CHARS, ...GSM_EXTENDED_CHARS]);
    return remainder.length !== 0;
  }

  getMessages() {
    return this.splitIntoSMS(GSM_MAX_SIZE);
  }

  splitIntoSMS(maxSize) {
    let index = 0;
    let messages = [];
    let text = this.text;
    while(index <= this.text.length) {
      let sms  = this.getSMS(text, maxSize);
      messages.push(sms);
      text = text.slice(sms.length);
      index += sms.length + 1;
    }
    return messages;
  }

  getSMS(text, maxSize) {
    let index = 0, currentSize = 0;
    const maxSizeWithMeta = maxSize - GSM_METADATA_SIZE;

    while (currentSize + this.getCharSize(text[index]) <= maxSizeWithMeta && index < text.length) {
      currentSize += this.getCharSize(text[index]);
      index += 1;
    }
    if (this.getTextSize(text.slice(index)) + currentSize <= maxSize && text.length - index <= GSM_METADATA_LENGTH) {
      index = text.length;
    }
    return text.slice(0, index);
  }

  getTextSize(text) {
    return [...text].map(this.getCharSize, this).reduce(function(sum, c) { return sum + c }, 0);
  }

  getSizeInBytes() {
    return Math.ceil(this.getTextSize(this.text) / BYTE_SIZE);
  }

  getCharSize(character) {
    if(!character) { return 0; }
    if (this.isUnicodeRequired() || GSM_EXTENDED_CHARS.includes(character)) {
      return character.length * BYTE_SIZE * 2;
    } else {
      return CHARACTER_SIZE;
    }
  }
}

export default CharacterCounter;
