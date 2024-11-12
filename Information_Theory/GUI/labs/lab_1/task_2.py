import math
from collections import Counter

def calculate_entropy_and_histogram(text):
    # Преобразование текста в битовую последовательность
    bit_sequence = ''.join(format(ord(char), '08b') for char in text)

    # Подсчет частоты битов
    frequency = Counter(bit_sequence)
    total_bits = len(bit_sequence)

    # Вычисление энтропии текста
    entropy = 0
    for bit, freq in frequency.items():
        probability = freq / total_bits
        entropy += -probability * math.log2(probability)

    return entropy, frequency

def calculate_file_entropy(file_path):
    # Чтение содержимого файла в битовую последовательность
    with open(file_path, 'rb') as file:
        bit_sequence = ''.join(format(byte, '08b') for byte in file.read())

    # Подсчет частоты битов
    frequency = Counter(bit_sequence)
    total_bits = len(bit_sequence)

    # Вычисление энтропии файла
    entropy = 0
    for bit, freq in frequency.items():
        probability = freq / total_bits
        entropy += -probability * math.log2(probability)

    return entropy
