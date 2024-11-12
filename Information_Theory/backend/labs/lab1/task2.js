const fs = require('fs')
const mammoth = require('mammoth')
const pdfjsLib = require('pdfjs-dist')

async function calculateTextEntropy(filePath) {
  let text

  // Определение типа файла и чтение текста
  if (filePath.endsWith('.txt')) {
    text = fs.readFileSync(filePath, 'utf-8')
  } else if (filePath.endsWith('.docx')) {
    const result = await mammoth.extractRawText({ path: filePath })
    text = result.value
  } else if (filePath.endsWith('.pdf')) {
    const data = new Uint8Array(fs.readFileSync(filePath))
    const pdf = await pdfjsLib.getDocument(data).promise
    let pdfText = ''
    for (let i = 1; i <= pdf.numPages; i++) {
      const page = await pdf.getPage(i)
      const content = await page.getTextContent()
      pdfText += content.items.map(item => item.str).join('')
    }
    text = pdfText
  } else {
    throw new Error('Unsupported file type')
  }

  // Вычисление энтропии текста
  const frequency = {}
  for (let i = 0; i < text.length; i++) {
    const char = text[i]
    if (frequency[char]) {
      frequency[char]++
    } else {
      frequency[char] = 1
    }
  }

  let entropy = 0
  const totalChars = text.length
  for (const char in frequency) {
    const probability = frequency[char] / totalChars
    entropy -= probability * Math.log2(probability)
  }

  // Возврат энтропии и имени каждого символа в тексте
  return { entropy, characters: Object.keys(frequency) }
}

module.exports = {
  calculateTextEntropy
}
