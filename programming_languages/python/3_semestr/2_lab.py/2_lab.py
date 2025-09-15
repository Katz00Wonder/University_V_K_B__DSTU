import random
from collections import Counter

def whiles():
    match input("Введите задачу : "):
        case "1":
            for number_1 in range(1,11):
                for number_2 in range(1, 11):
                    print(f"{number_1} * {number_2} = {number_1 * number_2}")
                print("")
        case "2":
            summ = 0
            for number in range(0,101):
                if number % 2 != 0:
                    summ += number 

            print(summ)
        case "3":
            number = int(input("Введите число : "))
            for num in range(1, number + 1):
                if number % num == 0:
                    print(num)
        case "4":
            number = int(input("Введите число : "))
            factorial = 1
            if number == 0:
                    print(1)
            else:
                for index in range(1, number + 1):
                    factorial *= index
                    print(factorial)
        case "5":
            number = int(input("Введите число : "))
            sequence = []
            a, b = 0, 1
            for _ in range(number):
                sequence.append(a)
                a, b = b, a + b
            print(sequence)


def lists():
    match input("Введите задачу : "):
        case "1":
            numbers = [random.randint(-50, 50) for _ in range(10)]
            print(numbers)
            for symbol in numbers:
                if symbol % 2 == 0:
                    print(symbol)


        case "2":
            numbers = [random.randint(-50, 50) for _ in range(10)]
            print(numbers)
            print(max(numbers), min(numbers))

            
        case "3":
            numbers = [random.randint(-50, 50) for _ in range(10)]
            for _ in range(5):
                number = int(input("Введите числа : "))
                numbers.append(number)
            print(sorted(numbers))


        case "4":
            numbers = [random.randint(-50, 50) for _ in range(10)]
            pass


        case "5":
            numbers = [random.randint(-50, 50) for _ in range(10)]
            print(numbers)
            numbers[0], numbers[-1] = numbers[-1],numbers[0]
            print(numbers)


def dicts():
    match input("Введите задание : "):
        case "1":
            number_list = []
            dictionary = {
                "Ушенин Артём": 4,
                "Борисов Никита": 3,
                "Вертий Владимир": 5,
                "Гуртов Максим": 4.3,
                "Ковалев Данил": 5,
                "Богдан Ермолаев": 4.24,
                }
            for value,number in dictionary.items():
                number_list.append(number)
            print(sum(number_list) / len(number_list))
        case "2":
            word = input("Введите текст : ")
            letter_count = {}

            for char in word:
                if char.isalpha():
                    char_lower = char.lower()
                    letter_count[char_lower] = letter_count.get(char_lower, 0) + 1

            print("Количество каждой буквы:")
            print(letter_count)
        
        case "3":
            dictionary_pow = {}
            for number in range(1,11):
                dictionary_pow[number] = number**2
            print(dictionary_pow)
        

        case "4":
            list_keys = ["Ford", "BMW", "Mercedez-Benz"]
            list_values = ["4214", "42141", "42145"]
            dictionary_list = {}

            for index in range(len(list_keys)):
                dictionary_list[list_keys[index]] = list_values[index]
            print(dictionary_list)


def sets():
    match input("Введите задачу : "):
        case "1":
            set_1 = {"MOm","Dad","Son"}
            set_2 = {"Son", "4124","4241"}
            print(set_1 | set_2, set_1 & set_2)
        
        case "2":
            text = set(input("Введите текст : ").split())

            print(text)

        case "3":
            list_1 = ["MOm","Dad","Son"]
            list_2 = ["Son", "4124","4241"]
            print(set(list_1) & set(list_2))
        case "4":
            A = {1, 2, 3}
            B = {1, 2, 3, 4, 5}
            result = A.issubset(B)
            print(result)
        case "5":
            given_number = 5
            my_set = {1, 5, 3, 8, 2, 10, 7}
            result_set = {x for x in my_set if x >= given_number}
            print(result_set)


def combined_tasks():
    match input("Введите задачу : "):
        case "1":
            random_numbers = [random.randint(1, 50) for _ in range(20)]
            print("Случайные числа:", random_numbers)
            unique_numbers = list(set(random_numbers))
            print("Уникальные значения:", unique_numbers)
        case "2":
            my_list = [1, 2, 3, 2, 4, 1, 5, 2, 3, 1]

            count_dict = {}
            for item in my_list:
                if item in count_dict:
                    count_dict[item] += 1
                else:
                    count_dict[item] = 1

            print(count_dict)
        case "3":
            words = ["apple", "banana", "cat", "dog", "elephant", "fox", "grapefruit", "hi"]

            long_words = {word for word in words if len(word) > 5}
            print(long_words)
        case "4":

            sentence = input("Введите предложение: ")
            words = sentence.lower().split()  # Приводим к нижнему регистру и разбиваем на слова

            word_count = dict(Counter(words))

            print("Количество вхождений каждого слова:")
            for word, count in word_count.items():
                print(f"'{word}': {count}")
        case "5":
            # Создаем список с дубликатами
            numbers = [1, 2, 3, 2, 4, 5, 3, 6, 7, 1, 8, 9, 5, 10]

            # Преобразуем в множество (удаляются дубликаты)
            unique_set = set(numbers)

            # Преобразуем обратно в список
            unique_list = list(unique_set)

            print("Исходный список:", numbers)
            print("Множество:", unique_set)
            print("Список без дубликатов:", unique_list)
        case "6":
            products = {
                "яблоки": 100,
                "бананы": 150,
                "апельсины": 200,
                "манго": 350,
                "виноград": 250
            }

            most_expensive = None
            max_price = 0

            for product, price in products.items():
                if price > max_price:
                    max_price = price
                    most_expensive = product

            print(f"Самый дорогой товар: {most_expensive} - {max_price} руб.")
        case "7":
            names = ["Анна", "Иван", "Мария", "Петр", "Анна", "Иван", "Ольга", "Мария", "Иван"]

            # Подсчитываем количество вхождений каждого имени
            name_count = Counter(names)

            # Имена, которые встречаются более одного раза
            duplicate_names = [name for name, count in name_count.items() if count > 1]

            # Самое частое имя
            most_common_name, most_common_count = name_count.most_common(1)[0]

            print("Исходный список:", names)
            print("Имена, встречающиеся более 1 раза:", duplicate_names)
            print(f"Самое частое имя: '{most_common_name}' (встречается {most_common_count} раз(а))")
        case "8":
            text = input("Введите строку: ")

            first_occurrence = {}
            for index, char in enumerate(text):
                if char not in first_occurrence:
                    first_occurrence[char] = index

            print("Словарь первого вхождения символов:")
            for char, index in first_occurrence.items():
                print(f"'{char}': {index}")








             
                
            
                

while True:
    match input("Введите тему: "):
        case "1":
            whiles()
        case "2":
            lists()
        case "3":
            dicts()
        case "4":
            sets()
        case "5":
            combined_tasks()
        case "":
            break


