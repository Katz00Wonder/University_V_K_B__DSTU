import os
import math
from collections import Counter
from PyQt5.QtWidgets import QFileDialog
import string

def get_text():
    options = QFileDialog.Options()
    options |= QFileDialog.ReadOnly
    file_path, _ = QFileDialog.getOpenFileName(None, 'Select Text File', '', 'Text Files (*.txt);;All Files (*)', options=options)
    with open(file_path, 'r') as f:
        return f.read()

def calculate_entropy_and_histogram(text):
    freq = Counter(text)
    total = len(text)
    entropy = 0
    allowed_chars = set(string.ascii_letters + string.whitespace + 'АБВГДЕЁЖЗИЙКЛМНОПРСТУФХЦЧШЩЪЫЬЭЮЯабвгдеёжзийклмнопрстуфхцчшщъыьэюя')
    for char, count in freq.items():
        if char in allowed_chars:
            p = count / total
            entropy -= p * math.log2(p)
    hist = {char: count for char, count in freq.items() if char in allowed_chars}
    return entropy, hist


def run():
    text = get_text()
    entropy, hist = calculate_entropy_and_histogram(text)
    return entropy, hist
