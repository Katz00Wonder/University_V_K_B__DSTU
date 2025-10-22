import heapq
import os
from collections import Counter
import tkinter as tk
from tkinter import ttk, filedialog, messagebox, scrolledtext
import csv


def make_frequency_dict(text):
    """Создает словарь частот символов"""
    return Counter(text)

def build_huffman_tree(frequency):
    """Строит дерево Хаффмана"""
    heap = [[weight, [char, ""]] for char, weight in frequency.items()]
    heapq.heapify(heap)
    
    while len(heap) > 1:
        lo = heapq.heappop(heap)
        hi = heapq.heappop(heap)
        for pair in lo[1:]:
            pair[1] = '0' + pair[1]
        for pair in hi[1:]:
            pair[1] = '1' + pair[1]
        heapq.heappush(heap, [lo[0] + hi[0]] + lo[1:] + hi[1:])
    
    return heap[0]

def create_huffman_codes(huffman_tree):
    """Создает таблицу кодирования Хаффмана"""
    codes = {}
    for pair in huffman_tree[1:]:
        char, code = pair
        codes[char] = code
    return codes

def huffman_encode(text, codes):
    """Кодирует текст с помощью кодов Хаффмана"""
    encoded_text = ""
    for char in text:
        encoded_text += codes[char]
    return encoded_text

def huffman_decode(encoded_text, codes):
    """Декодирует текст, закодированный методом Хаффмана"""
    reverse_codes = {v: k for k, v in codes.items()}
    current_code = ""
    decoded_text = ""
    
    for bit in encoded_text:
        current_code += bit
        if current_code in reverse_codes:
            decoded_text += reverse_codes[current_code]
            current_code = ""
    
    return decoded_text


def lz78_encode(text):
    """Кодирует текст с помощью алгоритма LZ78"""
    dictionary = {}
    next_code = 1
    encoded = []
    i = 0
    n = len(text)
    
    while i < n:
        current_string = ""
        j = i
        dict_code = 0
        

        while j < n:
            test_string = current_string + text[j]
            found = False
            
            for code, string in dictionary.items():
                if string == test_string:
                    dict_code = code
                    current_string = test_string
                    found = True
                    break
            
            if not found:
                break
            j += 1
        

        if j < n:
            new_string = current_string + text[j]
            dictionary[next_code] = new_string
            next_code += 1
        

        if current_string == "":
            encoded.append((0, text[i]))
            i += 1
        else:
            next_char = text[j] if j < n else ''
            encoded.append((dict_code, next_char))
            i = j + 1
    
    return encoded, dictionary

def lz78_encoded_to_string(encoded):
    """Преобразует закодированные данные LZ78 в строку"""
    result = []
    for code, char in encoded:
        result.append(f"({code},'{char}')")
    return " ".join(result)



def lzw_initialize_dictionary(text):
    """Инициализирует словарь LZW уникальными символами из текста"""
    dictionary = {}
    next_code = 0
    
    unique_chars = sorted(set(text))
    for char in unique_chars:
        dictionary[char] = next_code
        next_code += 1
    
    return dictionary, next_code

def lzw_encode(text):
    """Кодирует текст с помощью алгоритма LZW"""
    if not text:
        return [], {}
    
    dictionary, next_code = lzw_initialize_dictionary(text)
    encoded = []
    s = text[0]
    
    # Сохраняем шаги для подробного вывода
    steps = []
    
    for i in range(1, len(text)):
        c = text[i]
        if s + c in dictionary:
            s = s + c
            steps.append(f"Найдено в словаре: '{s}' (код {dictionary[s]})")
        else:
            encoded.append(dictionary[s])
            dictionary[s + c] = next_code
            steps.append(f"Новая последовательность: '{s}' + '{c}' = '{s+c}' → код {next_code}")
            next_code += 1
            s = c
    
    if s:
        encoded.append(dictionary[s])
        steps.append(f"Финальный код: '{s}' → {dictionary[s]}")
    
    return encoded, dictionary, steps

def lzw_encoded_to_string(encoded, dictionary, text, steps):
    """Преобразует закодированные данные LZW в строку с подробным выводом"""
    result = "LZW КОДИРОВАНИЕ:\n"
    result += "-" * 50 + "\n"
    result += "Формат: код_из_словаря\n\n"
    result += f"Всего кодов: {len(encoded)}\n\n"
    
    # Показываем числовые коды
    result += "ЧИСЛОВЫЕ КОДЫ:\n"
    result += " ".join(map(str, encoded)) + "\n\n"
    
    # Добавляем пошаговое объяснение
    result += "ПОШАГОВОЕ ВЫПОЛНЕНИЕ:\n"
    result += "-" * 50 + "\n"
    
    for i, step in enumerate(steps[:10]):  # Показываем первые 10 шагов
        result += f"Шаг {i+1}: {step}\n"
    
    if len(steps) > 10:
        result += f"... (и еще {len(steps) - 10} шагов)\n"
    
    # Добавляем таблицу словаря
    result += "\nСЛОВАРЬ LZW:\n"
    result += "-" * 50 + "\n"
    result += "Код\tСтрока\n"
    
    # Сначала базовые символы
    base_chars = sorted(set(text))
    for i, char in enumerate(base_chars):
        display_char = char.replace('\n', '\\n').replace('\t', '\\t')
        result += f"{i}\t'{display_char}'\n"
    
    # Потом добавленные строки
    for string, code in dictionary.items():
        if code >= len(base_chars):
            display_string = string.replace('\n', '\\n').replace('\t', '\\t')
            result += f"{code}\t'{display_string}'\n"
    
    # Добавляем пояснения для первых кодов
    result += "\nПОЯСНЕНИЯ ПЕРВЫХ КОДОВ:\n"
    result += "-" * 50 + "\n"
    
    # Восстанавливаем процесс кодирования для пояснений
    dict_copy, next_code_copy = lzw_initialize_dictionary(text)
    s = text[0]
    
    for i, code in enumerate(encoded[:6]):  # Показываем первые 6 кодов
        # Находим строку по коду
        coded_string = None
        for string, cod in dict_copy.items():
            if cod == code:
                coded_string = string
                break
        
        if coded_string:
            result += f"Код {i+1}: {code} → '{coded_string}'\n"
            
            # Обновляем словарь для следующей итерации (упрощенно)
            if i < len(encoded) - 1 and i < len(text) - 1:
                next_char = text[i + 1] if i + 1 < len(text) else ''
                new_string = coded_string + next_char
                if new_string not in dict_copy:
                    dict_copy[new_string] = next_code_copy
                    next_code_copy += 1
    
    return result

def lzw_codes_to_binary(encoded):
    """Преобразует числовые коды LZW в бинарное представление"""
    if not encoded:
        return "", 0
    
    max_code = max(encoded)
    bits_needed = max(1, (max_code).bit_length())
    
    binary_result = []
    for code in encoded:
        binary_result.append(format(code, f'0{bits_needed}b'))
    
    return " ".join(binary_result), bits_needed

def save_lzw_table(filename, text, dictionary):
    """Сохраняет таблицу LZW в CSV файл с правильной кодировкой"""
    try:
        table_file = filename.replace('.txt', '_lzw_table.csv')
        
        with open(table_file, 'w', encoding='utf-8-sig', newline='') as f:
            writer = csv.writer(f, delimiter=';')
            writer.writerow(['Код', 'Символ/Строка'])
            
            # Базовые символы
            base_chars = sorted(set(text))
            for i, char in enumerate(base_chars):
                display_char = char.replace('\n', '\\n').replace('\t', '\\t')
                writer.writerow([i, display_char])
            
            # Добавленные строки
            for string, code in dictionary.items():
                if code >= len(base_chars):
                    display_string = string.replace('\n', '\\n').replace('\t', '\\t')
                    writer.writerow([code, display_string])
        
        return table_file
    except Exception as e:
        raise Exception(f"Ошибка сохранения таблицы LZW: {str(e)}")

def load_text_file(filename):
    """Загружает текст из файла"""
    try:
        with open(filename, 'r', encoding='utf-8') as file:
            return file.read()
    except Exception as e:
        raise Exception(f"Не удалось прочитать файл: {str(e)}")

def save_results(filename, content, suffix):
    """Сохраняет результаты в файл"""
    try:
        output_file = filename.replace('.txt', f'_{suffix}.txt')
        with open(output_file, 'w', encoding='utf-8') as f:
            f.write(content)
        return output_file
    except Exception as e:
        raise Exception(f"Ошибка сохранения файла: {str(e)}")



class CompressionApp:
    def __init__(self, root):
        self.root = root
        self.root.title("Compression Algorithms")
        self.root.geometry("900x700")
        
        self.current_file = None
        self.text_content = ""
        self.huffman_codes = {}
        
        self.setup_ui()
    
    def setup_ui(self):
        # Основной фрейм
        main_frame = ttk.Frame(self.root, padding="10")
        main_frame.grid(row=0, column=0, sticky=(tk.W, tk.E, tk.N, tk.S))
        
        # Конфигурация весов строк и столбцов
        self.root.columnconfigure(0, weight=1)
        self.root.rowconfigure(0, weight=1)
        main_frame.columnconfigure(1, weight=1)
        main_frame.rowconfigure(5, weight=1)
        
        # Выбор файла
        ttk.Label(main_frame, text="Файл:").grid(row=0, column=0, sticky=tk.W, pady=5)
        self.file_label = ttk.Label(main_frame, text="Не выбран")
        self.file_label.grid(row=0, column=1, sticky=(tk.W, tk.E), pady=5)
        ttk.Button(main_frame, text="Выбрать файл", command=self.load_file).grid(row=0, column=2, pady=5)
        
        # Поле для отображения текста
        ttk.Label(main_frame, text="Содержимое файла:").grid(row=1, column=0, sticky=tk.W, pady=5)
        self.text_display = scrolledtext.ScrolledText(main_frame, height=6, width=80)
        self.text_display.grid(row=2, column=0, columnspan=3, sticky=(tk.W, tk.E, tk.N, tk.S), pady=5)
        
        # Вкладки для алгоритмов
        notebook = ttk.Notebook(main_frame)
        notebook.grid(row=3, column=0, columnspan=3, sticky=(tk.W, tk.E, tk.N, tk.S), pady=10)
        
        # Вкладка Хаффмана
        huffman_frame = ttk.Frame(notebook, padding="10")
        notebook.add(huffman_frame, text="Хаффман")
        
        ttk.Button(huffman_frame, text="Закодировать Хаффманом", 
                  command=self.huffman_encode).pack(pady=5)
        ttk.Button(huffman_frame, text="Декодировать Хаффманом", 
                  command=self.huffman_decode).pack(pady=5)
        
        self.huffman_text = scrolledtext.ScrolledText(huffman_frame, height=12, width=80)
        self.huffman_text.pack(fill=tk.BOTH, expand=True, pady=5)
        
        # Вкладка LZ78
        lz78_frame = ttk.Frame(notebook, padding="10")
        notebook.add(lz78_frame, text="LZ78")
        
        ttk.Button(lz78_frame, text="Закодировать LZ78", 
                  command=self.lz78_encode).pack(pady=5)
        
        self.lz78_text = scrolledtext.ScrolledText(lz78_frame, height=12, width=80)
        self.lz78_text.pack(fill=tk.BOTH, expand=True, pady=5)
        
        # Вкладка LZW
        lzw_frame = ttk.Frame(notebook, padding="10")
        notebook.add(lzw_frame, text="LZW")
        
        ttk.Button(lzw_frame, text="Закодировать LZW", 
                  command=self.lzw_encode).pack(pady=5)
        
        self.lzw_text = scrolledtext.ScrolledText(lzw_frame, height=12, width=80)
        self.lzw_text.pack(fill=tk.BOTH, expand=True, pady=5)
    
    def load_file(self):
        """Загружает файл с текстом"""
        filename = filedialog.askopenfilename(
            title="Выберите файл с текстом",
            filetypes=[("Text files", "*.txt"), ("All files", "*.*")]
        )
        
        if filename:
            self.current_file = filename
            self.file_label.config(text=os.path.basename(filename))
            
            try:
                self.text_content = load_text_file(filename)
                self.text_display.delete(1.0, tk.END)
                self.text_display.insert(1.0, self.text_content)
                
                # Показываем информацию о тексте
                chars_count = len(self.text_content)
                unique_chars = len(set(self.text_content))
                self.text_display.insert(tk.END, f"\n\n--- Информация о тексте ---\n")
                self.text_display.insert(tk.END, f"Всего символов: {chars_count}\n")
                self.text_display.insert(tk.END, f"Уникальных символов: {unique_chars}\n")
                
            except Exception as e:
                messagebox.showerror("Ошибка", str(e))
    
    def huffman_encode(self):
        """Кодирование методом Хаффмана"""
        if not self.text_content:
            messagebox.showwarning("Предупреждение", "Сначала загрузите файл с текстом")
            return
        
        try:
            # Кодирование Хаффмана
            frequency = make_frequency_dict(self.text_content)
            huffman_tree = build_huffman_tree(frequency)
            self.huffman_codes = create_huffman_codes(huffman_tree)
            encoded_text = huffman_encode(self.text_content, self.huffman_codes)
            
            # Формируем результат
            result = "ТАБЛИЦА КОДИРОВАНИЯ ХАФФМАНА:\n"
            result += "-" * 50 + "\n"
            for char, code in sorted(self.huffman_codes.items(), key=lambda x: len(x[1])):
                if char == ' ':
                    result += f"ПРОБЕЛ: {code} (длина: {len(code)})\n"
                elif char == '\n':
                    result += f"ПЕРЕНОС: {code} (длина: {len(code)})\n"
                elif char == '\t':
                    result += f"ТАБУЛЯЦИЯ: {code} (длина: {len(code)})\n"
                else:
                    result += f"'{char}': {code} (длина: {len(code)})\n"
            
            result += f"\nИсходный размер: {len(self.text_content) * 8} бит\n"
            result += f"Закодированный размер: {len(encoded_text)} бит\n"
            result += f"Коэффициент сжатия: {len(encoded_text) / (len(self.text_content) * 8):.2%}\n"
            
            result += "\nЗАКОДИРОВАННЫЙ ТЕКСТ:\n"
            result += "-" * 50 + "\n"
            if len(encoded_text) > 500:
                result += encoded_text[:500] + "...\n"
                result += f"... (показано 500 из {len(encoded_text)} бит)"
            else:
                result += encoded_text
            
            self.huffman_text.delete(1.0, tk.END)
            self.huffman_text.insert(1.0, result)
            
            # Сохраняем в файл
            if self.current_file:
                output_file = save_results(self.current_file, result, "huffman_encoded")
                messagebox.showinfo("Успех", f"Результат сохранен в {output_file}")
            
        except Exception as e:
            messagebox.showerror("Ошибка", f"Ошибка при кодировании Хаффманом: {str(e)}")
    
    def huffman_decode(self):
        """Декодирование методом Хаффмана"""
        if not self.huffman_codes:
            messagebox.showwarning("Предупреждение", "Сначала выполните кодирование Хаффманом")
            return
        
        try:
            # Получаем закодированный текст из поля
            content = self.huffman_text.get(1.0, tk.END)
            lines = content.split('\n')
            
            # Ищем закодированный текст
            encoded_text = ""
            found_encoded = False
            for line in lines:
                if "ЗАКОДИРОВАННЫЙ ТЕКСТ:" in line:
                    found_encoded = True
                    continue
                if found_encoded and line.strip() and not line.startswith('-'):
                    clean_line = line.replace('...', '').strip()
                    encoded_text += clean_line
            
            if not encoded_text:
                messagebox.showwarning("Предупреждение", "Не найден закодированный текст")
                return
            
            # Декодирование
            decoded_text = huffman_decode(encoded_text, self.huffman_codes)
            
            result = "РАСШИФРОВАННЫЙ ТЕКСТ:\n"
            result += "-" * 40 + "\n"
            result += decoded_text
            
            self.huffman_text.delete(1.0, tk.END)
            self.huffman_text.insert(1.0, result)
            
        except Exception as e:
            messagebox.showerror("Ошибка", f"Ошибка при декодировании Хаффманом: {str(e)}")
    
    def lz78_encode(self):
        """Кодирование методом LZ78"""
        if not self.text_content:
            messagebox.showwarning("Предупреждение", "Сначала загрузите файл с текстом")
            return
        
        try:
            # Кодирование LZ78
            encoded, dictionary = lz78_encode(self.text_content)
            encoded_str = lz78_encoded_to_string(encoded)
            
            result = "LZ78 КОДИРОВАНИЕ:\n"
            result += "-" * 50 + "\n"
            result += "Формат: (код_из_словаря, следующий_символ)\n"
            result += "Код 0 означает, что строка новая\n\n"
            result += f"Всего пакетов: {len(encoded)}\n\n"
            result += "Закодированные последовательности:\n"
            result += encoded_str
            
            # Добавляем таблицу словаря
            result += "\n\nСЛОВАРЬ LZ78:\n"
            result += "-" * 50 + "\n"
            result += "Код\tСтрока\n"
            for code, string in sorted(dictionary.items()):
                display_string = string.replace('\n', '\\n').replace('\t', '\\t')
                result += f"{code}\t'{display_string}'\n"
            
            # Добавляем пояснения для первых пакетов
            result += "\nПОЯСНЕНИЯ ПЕРВЫХ ПАКЕТОВ:\n"
            result += "-" * 50 + "\n"
            
            for i, (code, char) in enumerate(encoded[:6]):
                result += f"Пакет {i+1}: ({code}, '{char}')\n"
                if code == 0:
                    result += f"  → Новая строка: добавлен символ '{char}' в словарь\n"
                else:
                    prev_string = dictionary.get(code, '')
                    new_string = prev_string + char
                    display_prev = prev_string.replace('\n', '\\n').replace('\t', '\\t')
                    display_new = new_string.replace('\n', '\\n').replace('\t', '\\t')
                    result += f"  → Найдено в словаре: код {code} = '{display_prev}' + '{char}' = '{display_new}'\n"
            
            self.lz78_text.delete(1.0, tk.END)
            self.lz78_text.insert(1.0, result)
            
            # Сохраняем в файл
            if self.current_file:
                output_file = save_results(self.current_file, result, "lz78_encoded")
                messagebox.showinfo("Успех", f"Результат сохранен в {output_file}")
            
        except Exception as e:
            messagebox.showerror("Ошибка", f"Ошибка при кодировании LZ78: {str(e)}")
    
    def lzw_encode(self):
        """Кодирование методом LZW"""
        if not self.text_content:
            messagebox.showwarning("Предупреждение", "Сначала загрузите файл с текстом")
            return
        
        try:
            # Кодирование LZW с получением шагов
            encoded, dictionary, steps = lzw_encode(self.text_content)
            result = lzw_encoded_to_string(encoded, dictionary, self.text_content, steps)
            
            # Добавляем информацию о сжатии
            binary_codes, bits_per_code = lzw_codes_to_binary(encoded)
            
            compression_info = f"\nИНФОРМАЦИЯ О СЖАТИИ:\n"
            compression_info += "-" * 50 + "\n"
            compression_info += f"Размер исходного текста: {len(self.text_content)} символов\n"
            compression_info += f"Исходный размер в битах: {len(self.text_content) * 8} бит\n"
            compression_info += f"Количество кодов LZW: {len(encoded)}\n"
            compression_info += f"Количество бит на код: {bits_per_code}\n"
            compression_info += f"Закодированный размер: {len(encoded) * bits_per_code} бит\n"
            compression_info += f"Коэффициент сжатия: {(len(encoded) * bits_per_code) / (len(self.text_content) * 8):.2%}\n\n"
            
            compression_info += "БИНАРНОЕ ПРЕДСТАВЛЕНИЕ:\n"
            compression_info += binary_codes
            
            result += compression_info
            
            self.lzw_text.delete(1.0, tk.END)
            self.lzw_text.insert(1.0, result)
            
            # Сохраняем таблицу и результаты
            if self.current_file:
                output_file = save_results(self.current_file, result, "lzw_encoded")
                table_file = save_lzw_table(self.current_file, self.text_content, dictionary)
                
                messagebox.showinfo("Успех", 
                                f"Результат сохранен в {output_file}\n"
                                f"Таблица кодов сохранена в {table_file}")
            
        except Exception as e:
            messagebox.showerror("Ошибка", f"Ошибка при кодировании LZW: {str(e)}")

def main():
    root = tk.Tk()
    app = CompressionApp(root)
    root.mainloop()

if __name__ == "__main__":
    main()