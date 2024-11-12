const fs = require('fs')

function calculateEntropy(filePath) {
  return new Promise((resolve, reject) => {
    fs.readFile(filePath, (err, data) => {
      if (err) {
        reject(err)
        return
      }

      const frequency = {}
      for (let i = 0; i < data.length; i++) {
        const char = data[i]
        if (frequency[char]) {
          frequency[char]++
        } else {
          frequency[char] = 1
        }
      }

      let entropy = 0
      const totalChars = data.length
      for (const char in frequency) {
        const probability = frequency[char] / totalChars
        entropy -= probability * Math.log2(probability)
      }

      resolve(entropy)
    })
  })
}

module.exports = {
  calculateEntropy
}
