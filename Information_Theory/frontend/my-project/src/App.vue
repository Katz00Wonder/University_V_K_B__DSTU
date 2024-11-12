<template>
  <div id="app">
    <Sidebar @lab-selected="selectLab" />
    <MainContent :lab-id="selectedLabId" @task-selected="selectTask" />
    <TaskDetails :task-id="selectedTaskId" />
  </div>
</template>

<script>
import Sidebar from './components/Sidebar.vue'
import MainContent from './components/MainContent.vue'
import TaskDetails from './components/TaskDetails.vue'
import { labs } from './app'

export default {
  components: {
    Sidebar,
    MainContent,
    TaskDetails
  },
  data() {
    return {
      selectedLabId: null,
      selectedTaskId: null
    }
  },
  methods: {
    selectLab(labId) {
      this.selectedLabId = labId
      this.selectedTaskId = null
    },
    selectTask(taskId) {
      this.selectedTaskId = taskId
    }
  }
}
</script>

