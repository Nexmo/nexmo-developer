<template>
  <div class='Nxd-search__result'>
    <a class='Nxd-search__result__link' v-bind:href='url' target='_blank'>
      <div>
        <h6 class='Vlt-blue-dark'>{{ title }}</h6>
        <p class='Nxd-search__result__highlight' v-html='snippet'></p>
        <span class='Vlt-badge Vlt-badge--grey Nxd-search__badge'>{{ badge }}</span>
      </div>
    </a>
  </div>
</template>
<script>
export default {
  props: ['hit'],
  computed: {
    badge: function() {
      return this.hit.section.full_path;
    },
    snippet: function() {
      return `...${this.hit._snippetResult.body_safe.value}...`;
    },
    title: function() {
      return this.hit.title;
    },
    url: function() {
      return `https://help.nexmo.com/hc/en-us/articles/${this.hit.id}`;
    },
  }
}
</script>
