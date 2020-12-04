<template>
  <div>
    <p class="content">{{ step.content }}</p>
    <button v-show="!lastStep" class="Vlt-btn Vlt-btn--app Vlt-btn--tertiary Vlt-modal__cancel" v-on:click="reset">Cancel</button>
    <button v-show="lastStep" class="Vlt-btn Vlt-btn--app Vlt-btn--secondary Vlt-modal__cancel" v-on:click="reset">Close</button>
  </div>
</template>
<script>

import eventHub from '../eventHub';

export default {
  props: ['step', 'lastStep'],
  methods: {
    reset: function() {
      eventHub.$emit('reset-modal');
    }
  }
}
</script>
<style scoped>
.content {
  white-space: pre-line;
  max-width: 316px;
}
</style>
