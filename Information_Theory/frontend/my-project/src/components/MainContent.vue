<template>
  <div class="main-content">
    <h1>{{ lab.title }}</h1>
    <p>{{ lab.description }}</p>
    <ul>
      <li v-for="task in lab.tasks" :key="task.id" @click="selectTask(task.id)">
        {{ task.title }}
      </li>
    </ul>
  </div>
</template>

<script>
import { labs } from '../app'

export default {
  props: {
    labId: {
      type: Number,
      required: true
    }
  },
  computed: {
    lab() {
      return labs.find(lab => lab.id === this.labId)
    }
  },
  methods: {
    selectTask(taskId) {
      this.$emit('task-selected', taskId)
    }
  }
}
</script>
