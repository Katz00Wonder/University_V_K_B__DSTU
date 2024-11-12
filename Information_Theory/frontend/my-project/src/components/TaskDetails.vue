<template>
  <div class="task-details">
    <h1>{{ task.title }}</h1>
    <p>{{ task.description }}</p>
    <!-- Отображение других данных о задании -->
  </div>
</template>

<script>
import { labs } from '../app'

export default {
  props: {
    taskId: {
      type: Number,
      required: true
    }
  },
  computed: {
    task() {
      let task = null
      labs.forEach(lab => {
        const foundTask = lab.tasks.find(task => task.id === this.taskId)
        if (foundTask) task = foundTask
      })
      return task
    }
  }
}
</script>
