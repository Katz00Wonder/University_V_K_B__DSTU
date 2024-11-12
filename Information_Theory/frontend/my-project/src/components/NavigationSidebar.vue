<template>
  <div class="sidebar">
    <ul>
      <li v-for="lab in labs" :key="lab.id" @click="selectLab(lab.id)">
        {{ lab.title }}
      </li>
    </ul>
  </div>
</template>

<script>
import { labs } from '../app'

export default {
  data() {
    return {
      labs
    }
  },
  methods: {
    selectLab(labId) {
      this.$emit('lab-selected', labId)
    }
  }
}
</script>

  