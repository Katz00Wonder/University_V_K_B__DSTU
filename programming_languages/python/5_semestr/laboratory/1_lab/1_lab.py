import math


class Lab1():
    def question_1():
        match input("Введите задание: "):
            case "1":
                num = int(input())
                return ("Четное число") if num % 2 == 0 else print("Нечетное число")

            case "2":
                num = int(input())
                return("Делится") if num % 5 == 0 else print("Не делится")

            case "3":
                num = int(input())
                return("Делится") if num % 7 == 0 else print("Не делится")
            
            case "4":
                num = int(input())
                return("Оканчивается") if str(num[-1]) == "3" else print("не оканчивается")

    def question_2():
        match input("Введите число пункта: "):
            case "1":
                number_1, number_2 = int(input()), int(input())
                return(max(number_1, number_2))
            
            case "2":
                number_1, number_2 = int(input()), int(input())
                return(min(number_1, number_2))
            
            case "3":
                number_1, number_2 = int(input()), int(input())
                return(abs(number_1-number_2))
            
            case "4":
                number_1, number_2 = int(input()), int(input())
                return("Равны") if number_1 == number_2 else print("Не равны")

    def question_3():

        match input("Введите число пункта: "):
            case "1":
                for number in range(0,11):
                    return(f"2 * {number} = {2 * number}")
            
            case "2":
                for number in range(0,11):
                    return(f"5 * {number} = {5 * number}")
            
            case "3":
                number_0 = int(input("Введите число для таблицы умножения: "))
                for number in range(0,11):
                    return(f"{number_0} * {number} = {number_0 * number}")
            
            case "4":
                for number in range(0,11):
                    return(f"10 * {number} = {10 * number}")


    def question_4():
        match input("Введите число пункта: "):
            case "1":
                count = 0
                for number in range(1,11):
                    count += number
                    return(count)
            
            case "2":
                count = 0
                num = int(input("Введите число"))
                for number in range(1,num+1):
                    count+= number
                    return(count)
            
            case "3":
                count = 0
                num = int(input("Введите число"))
                for number in range(1,num+1):
                    if number % 2!= 0:
                        count+= number
                    else:
                        continue
                return(count)
            
            case "4":
                count = 0
                num = int(input("Введите число"))
                for number in range(1,num+1):
                    if number % 2 == 0:
                        count += number
                    else:
                        continue
                return(count)
                    

    def question_5():
        num = input("Введите число пункта: ")
        match num:
            case "1":
                number = int(input("Введите число"))
                return(math.pow(number,2))
            
            case "2":
                number = int(input("Введите число"))
                return(math.pow(number,3))
            
            case "3":
                number_1,number_2 = int(input("Введите число")), int(input("Введите число"))
                return(math.pow(number,number_2))
            
            case "4":
                number = int(input("Введите число"))
                return(math.pow(2, number))
                    

    def question_6():
        match input("Введите число пункта: "):
            case "1":
                age = int(input("Введите число"))
                if age>=18:
                    return("Взрослый")
                else:
                    return("Маленький ещё")

            
            case "2":
                age = int(input("Введите число"))
                if age>=65:
                    return("Пенсионер")
                else:
                    return("Не пенсионер")
            
            case "3":
                age = int(input("Введите число"))
                if age >= 7 and age <=18:
                    return("Школьник")
                else:
                    return("Не школьник")
            
            case "4":
                age = int(input("Введите число"))
                if age & 10 == 0:
                    return("Крупная десятка")
                else:
                    return("Не крупная десятка")

    def question_7():
        match input("Введите число пункта: "):
            case "1":

                return(f"Факториал числа 3 = {math.factorial(3)}")


            
            case "2":
                return(f"Факториал числа 5 = {math.factorial(5)}")
            
            case "3":
                number = int(input("Введите число"))
                return(math.factorial(number))
            case "4":
                while True:
                    number = int(input("Введите число"))
                    if number != 0:
                        print(math.factorial(number))
                    else:
                        return

    def question_8():
        match input("Введите число пункта: "):
            case "1":
                number = int(input("Введите число"))
                if 10 <= number <= 99:
                    return (number // 10) + (number % 10)
                else:
                    return None 

            
            case "2":
                number = int(input("Введите число"))
                if 10 <= number <= 99:
                    return (number // 10) * (number % 10)
                else:
                    return None 
            case "3":
                number = int(input("Введите число"))
                if 100 <= number <= 999:
                    return (number // 100) + (number % 10) + ((number // 10) % 10)
                else:
                    return None
            case "4":
                number = int(input("Введите число"))
                if 100 <= number <= 999:
                    return (number//100, number%10)
                else:
                    return None

    def question_9():
        match input("Введите число пункта: "):
            case "1":
                return(input("Введите символ, которой является цифрой").isdigit())
            case "2":
                return(input("Введите символ, который является буквой").isalpha())
            case "3":
                symbol = input("Введите символ: ")
                if "аеёиоуыэюя" in symbol or "АЕЁИОУЫЭЮЯ" in symbol:
                    return("YES")
                else:
                    return("NO")
            case "4":
                return(input().isupper())

    def question_10():
        match input("Введите число пункта: "):
            case "1":
                total = 0
                num = None
        
                while num != 0:
                    try:
                        num = int(input("Введите число (0 для завершения): "))
                        total += num
                    except ValueError:
                        print("Ошибка: введите число!")
        
                return total

            
            case "2":
                count = 0
                while True:
                    try:
                        num = int(input("Введите число (отрицательное для завершения): "))
                        if num < 0:
                            break
                        count += 1
                    except ValueError:
                        print("Ошибка: введите число!")
        
                return count
            case "3":
                total = 0
                while True:
                    try:
                        num = int(input("Введите число (чётное для завершения): "))
                        if num % 2 == 0:  # Если число чётное
                            break
                        total += num      # Суммируем только нечётные
                        print(f"Добавлено: {num} | Текущая сумма: {total}")
                    except ValueError:
                        print("Ошибка: введите целое число!")
        
                return total
            case "4":
                numbers = []
                total = 0
                count = 0
        
                while True:
                    try:
                        num = int(input("Введите число (число > 100 для завершения): "))
                        if num > 100:
                            print(f"Число {num} > 100, завершение...")
                            break
                        numbers.append(num)
                        total += num
                        count += 1
                        print(f"Добавлено: {num} | Всего чисел: {count} | Текущая сумма: {total}")
                    except ValueError:
                        print("Ошибка: введите число!")
        
                if count > 0:
                    average = total / count
                    print(f"Среднее арифметическое: {average}")
                else:
                    print("Числа не были введены")
                    average = 0
        
                return average


while True:
    match input("Введите задачу: "):
        case "1":
            print(Lab1.question_1())
        case "2":
            print(Lab1.question_2())
        case "3":
            print(Lab1.question_3())
        case "4":
            print(Lab1.question_4())
        case "5":
            print(Lab1.question_5())
        case "6":
            print(Lab1.question_6())
        case "7":
            print(Lab1.question_7())
        case "8":
            print(Lab1.question_8())
        case "9":
            print(Lab1.question_9())
        case "10":
            print(Lab1.question_10())
        case "exit":
            break
        case _:
            print("Неверный выбор. Введите число от 1 до 10.")
            
            


