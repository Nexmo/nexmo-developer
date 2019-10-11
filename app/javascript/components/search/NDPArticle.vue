<template>
  <div class='Nxd-search__result'>
    <a class='Nxd-search__result__link' v-bind:href='url'>
      <div>
        <h6 class='Vlt-blue-dark'>
          {{ hit.title }}
          <small v-if="showHeading"> &gt; {{ hit.heading }}</small>
        </h6>

        <p class='Nxd-search__result__desc'>{{ description }}</p>
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
      return this.hit.product;
    },
    description: function() {
      return this.hit.description ? this.hit.description.substring(0, 150) : '';
    },
    showHeading: function() {
      return this.hit.heading && this.hit.heading == this.hit.title;
    },
    snippet: function() {
      return `...${this.hit._snippetResult.body.value}...`;
    },
    url: function() {
      return `${this.hit.path}#${this.hit.anchor}`;
    }
  },
}
</script>
