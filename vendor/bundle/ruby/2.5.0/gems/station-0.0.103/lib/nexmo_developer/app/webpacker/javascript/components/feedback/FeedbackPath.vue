<template>
  <div>
    <step v-show="index === currentStepIndex"
      v-for="(step, index) in feedback_path.steps"
      v-bind:step="step"
      v-bind:last-step="lastStep" />
  </div>
</template>
<script>

import Step from './step/base.vue';
import eventHub from './eventHub';
import store from './store';

export default {
  props: ['feedback_path'],
  components: { Step },
  data: function() {
    return {
      currentStepIndex: 0
    };
  },
  computed: {
    currentStep: function() {
      return this.feedback_path.steps[this.currentStepIndex];
    },
    lastStep: function() {
      return this.currentStepIndex === (this.feedback_path.steps.length - 1);
    }
  },
  methods: {
    nextStep: function(answer) {
      this.currentStepIndex += 1;
      store.addStep(answer);
      return false;
    },
    reset: function() {
      this.currentStepIndex = 0;
      return false;
    }
  },
  mounted: function() {
    eventHub.$on('reset-modal', this.reset);
    eventHub.$on('next-step', this.nextStep);
  },
  beforeDestroy: function() {
    eventHub.$off('next-step');
  }
}
</script>
<style scoped>
.feedback-path {
  display: flex;
  flex-direction: column;
}
</style>
