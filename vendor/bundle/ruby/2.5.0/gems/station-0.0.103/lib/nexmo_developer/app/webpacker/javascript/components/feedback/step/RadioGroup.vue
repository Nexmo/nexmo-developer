<template>
  <div>
    <div class="Vlt-form__element" v-bind:class="{ 'Vlt-form__element--error': hasError }">
      <div v-for="(question, index) in step.questions" class="radio-button Vlt-radio">
        <label>
          <span class="Vlt-radio__button">
            <input required="required" type="radio" :value=index v-model="answer">
            <span class="Vlt-radio__icon"></span>
          </span>
          {{question}}
        </label>
      </div>

      <small v-if="hasError"class="Vlt-form__element__error">This field is required</small>
      <button v-show="!lastStep" class="Vlt-btn Vlt-btn--app Vlt-btn--tertiary Vlt-modal__cancel" v-on:click="reset">Cancel</button>
      <button v-show="lastStep" class="Vlt-btn Vlt-btn--app Vlt-btn--secondary Vlt-modal__cancel" v-on:click="reset">Close</button>
      <button v-show="!lastStep" class="Vlt-btn Vlt-btn--app Vlt-btn--secondary" v-on:click="validate">Continue</button>
    </div>
  </div>
</template>
<script>

import eventHub from '../eventHub';

export default {
  props: ['step', 'lastStep'],
  data: function() {
    return {
      answer: '',
      hasError: false
    };
  },
  methods: {
    resetFields: function() {
      this.answer = '';
      this.hasError = false;
    },
    reset: function() {
      eventHub.$emit('reset-modal');
    },
    validate: function() {
      if (this.$el.querySelector('input[type="radio"]:checked') !== null) {
        this.hasError = false;
        eventHub.$emit('next-step', this.answer);
        return false;
      } else {
        this.hasError = true;
      }
    }
  },
  mounted: function() {
    eventHub.$on('reset-modal', this.resetFields);
  }
}
</script>
<style scoped>
.radio-button {
  margin-bottom: 11px;
}
.Vlt-form__element {
  @media only screen and (min-width: 576px) {
    width: 450px;
  };
}
</style>
