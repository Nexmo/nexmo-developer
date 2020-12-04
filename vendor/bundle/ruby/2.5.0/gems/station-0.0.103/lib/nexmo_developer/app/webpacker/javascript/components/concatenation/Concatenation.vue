<template>
  <div class="Vlt-box">
    <h2>Try it out</h2>

    <h4>Message</h4>
    <div class="Vlt-textarea">
      <textarea v-model="body" />
    </div>

    <div class="Vlt-margin--top2" />

    <h4>Data</h4>
    <div class="Vlt-box Vlt-box--white Vlt-box--lesspadding">
      <div class="Vlt-grid">
        <div class="Vlt-col Vlt-col--1of3">
          <b>Unicode is Required?</b>
          <i v-if="unicodeRequired" class="icon icon--large icon-check-circle color--success"></i>
          <i v-else class="icon icon--large icon-times-circle color--error"></i>
        </div>
        <div class="Vlt-col Vlt-col--2of3">
        </div>
        <hr class="hr--shorter"/>
        <div class="Vlt-col Vlt-col--1of3">
          <b>Length</b>
        </div>
        <div class="Vlt-col Vlt-col--2of3" v-html="smsComposition" id="sms-composition"></div>
      </div>
    </div>

    <h4>Parts</h4>
    <div class="Vlt-box Vlt-box--white Vlt-box--lesspadding" id="parts">
      <div v-for= "(message, index) in messages" class="Vlt-grid">
        <div class="Vlt-col Vlt-col--1of3"><b>Part {{index + 1}}</b></div>
        <div class="Vlt-col Vlt-col--2of3">
          <code>
            <span v-if="messages.length > 1">
              <span class="Vlt-badge Vlt-badge--blue">User Defined Header</span>
              <span>&nbsp;</span>
            </span>
            {{message}}
          </code>
        </div>
        <hr v-if="index + 1 !== messages.length" class="hr--shorter"/>
      </div>
    </div>
  </div>
</template>

<script>
import CharacterCounter from './character_counter';

export default {
  data: function () {
    return {
      body: 'It was the best of times, it was the worst of times, it was the age of wisdom, it was the age of foolishness, it was the epoch of belief, it was the epoch of incredulity, it was the season of Light, it was the season of Darkness, it was the spring of hope, it was the winter of despair, we had everything before us, we had nothing before us, we were all going direct to Heaven, we were all going direct the other way in short, the period was so far like the present period, that some of its noisiest authorities insisted on its being received, for good or for evil, in the superlative degree of comparison only.'
    };
  },
  computed: {
    smsInfo: function() {
      return new CharacterCounter(this.body).getInfo();
    },
    messages: function() {
      return this.smsInfo.messages;
    },
    unicodeRequired: function() {
      return this.smsInfo.unicodeRequired;
    },
    smsComposition: function() {
      let count = this.smsInfo.charactersCount;
      let characters = this.pluralize('character', count);
      let messagesLength = this.messages.length;
      let parts = this.pluralize('part', messagesLength);

      return `${count} ${characters} sent in ${messagesLength} message ${parts}`;
    }
  },
  methods: {
    pluralize: function(singular, count) {
      if (count === 1) { return singular; }
      return `${singular}s`;
    }
  }
}
</script>

<style scoped>
  textarea {
    width: 100%;
    height: 150px;
    resize: vertical;
  }
  code {
    whiteSpace: normal;
    wordBreak: break-all;
 }
</style>
