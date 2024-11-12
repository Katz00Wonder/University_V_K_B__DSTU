const express = require('express')
const bodyParser = require('body-parser')
const multer = require('multer')
const fs = require('fs')
const path = require('path')

const app = express()
app.use(bodyParser.json())

// Путь к директории с лабораторными работами
const labsDir = path.join(__dirname, 'labs')

// Массив для хранения данных о лабораторных работах и заданиях
const labs = []

// Чтение директории с лабораторными работами
fs.readdirSync(labsDir).forEach(labDir => {
  const labPath = path.join(labsDir, labDir)
  const labData = JSON.parse(fs.readFileSync(path.join(labPath, 'lab.json')))

  // Чтение директории с заданиями лабораторной работы
  fs.readdirSync(labPath).forEach(taskFile => {
    if (taskFile !== 'lab.json') {
      const taskData = JSON.parse(fs.readFileSync(path.join(labPath, taskFile)))
      labData.tasks.push(taskData)
    }
  })

  labs.push(labData)
})

// Теперь переменная `labs` содержит данные о лабораторных работах и заданиях
console.log(labs)

// Middleware для обработки загрузки файлов
const upload = multer({ dest: 'uploads/' })

// API endpoint для получения списка лабораторных работ
app.get('/api/labs', (req, res) => {
  res.json(labs)
})

// API endpoint для получения данных лабораторной работы по ее идентификатору
app.get('/api/labs/:id', (req, res) => {
  const lab = labs.find(lab => lab.id === parseInt(req.params.id))
  if (!lab) return res.status(404).send('Lab not found.')
  res.json(lab)
})

// API endpoint для получения данных задания по его идентификатору
app.get('/api/tasks/:id', (req, res) => {
  let task = null
  labs.forEach(lab => {
    const foundTask = lab.tasks.find(task => task.id === parseInt(req.params.id))
    if (foundTask) task = foundTask
  })
  if (!task) return res.status(404).send('Task not found.')
  res.json(task)
})

// API endpoint для отправки решения задания 1
app.post('/api/tasks/1/solutions', upload.single('file'), async (req, res) => {
  const filePath = req.file.path
  try {
    const entropy = await calculateEntropy(filePath)
    res.json({ entropy })
  } catch (err) {
    res.status(500).send(err.message)
  }
})

// API endpoint для отправки решения задания 2
app.post('/api/tasks/2/solutions', upload.single('file'), async (req, res) => {
  const filePath = req.file.path
  try {
    const { entropy, characters } = await calculateTextEntropy(filePath)
    res.json({ entropy, characters })
  } catch (err) {
    res.status(500).send(err.message)
  }
})

const port = process.env.PORT || 3000
app.listen(port, () => console.log(`Server is running on port ${port}`))
