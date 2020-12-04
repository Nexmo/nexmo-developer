<template>
  <div class="step" v-bind:class="{ image: hasImage }">
    <img v-if="hasImage" img :src="step.image" :alt="step.image">
    <div class="step-content">
      <span v-if="!hasImage">Feedback</span>
      <h4 class="step-title">{{step.title}}</h4>

      <plain v-if="step.type == 'plain'" v-bind:step="step" v-bind:last-step="lastStep"/>
      <text-area v-else-if="step.type == 'textarea'" v-bind:step="step" v-bind:last-step="lastStep"/>
      <radio-group v-else-if="step.type == 'radiogroup'" v-bind:step="step" v-bind:last-step="lastStep"/>
      <field-set v-else-if="step.type == 'fieldset'" v-bind:step="step" v-bind:last-step="lastStep"/>
      <div v-else></div>
    </div>
  </div>
</template>
<script>

import TextArea from './TextArea.vue';
import RadioGroup from './RadioGroup.vue';
import Plain from './Plain.vue';
import FieldSet from './FieldSet.vue';

export default {
  props: ['step', 'lastStep'],
  components: { TextArea, RadioGroup, Plain, FieldSet },
  computed: {
    hasImage: function() {
      return this.step.image !== undefined;
    }
  }
}
</script>
<style scoped>
.step {
  display: flex;
}
.image {
  padding: 0px;
}
.step-title {
  white-space: pre-line;
}
.step-content {
  flex-direction: column;
  padding: 32px;
  max-width: 580px;
}
img {
  @media only screen and (max-width: 576px) {
    display: none;
  };
}
</style>
