from decimal import Decimal
from fractions import Fraction
from datetime import datetime, date, time



while True:
    match input("Введите задание: "):
        case "1":
            print([number**2 for number in range(1,11)])
        case "2":
            print([number for number in range(1, 20) if number % 2 == 0])
        case "3":
            words = ["python", "Java", "c++", "Rust", "go"]
            print([word.upper() for word in words if len(word) > 3])
        case "4":
            class Countdown():
                """Это класс-итератор"""
                def __init__(self, number):
                    self.number = number

                def __iter__(self):
                    self.current = self.number
                    return self
                
                def __next__(self):
                    if self.current == 0:
                        raise StopIteration
                    value = self.current
                    self.current -= 1
                    return value
                
            for number in Countdown(5):
                print(number)
                                
        case "5":
            
            def fibonacci(number: int):
                number_1, number_2 = 0, 1
                for _ in range(number):
                    yield number_1
                    number_1, number_2 = number_2, number_1 + number_2
            
            for num in fibonacci(int(input("Введите число: "))):
                print(num)
            
        case "6":
            start_sum = Decimal(input("Введите начальную сумму вклада : "))
            percent_years = Decimal(input("Введите процентную ставку годовых : "))
            deposit_term = Decimal(input("Введите срок вклада (в годах): "))

            months = deposit_term * Decimal('12')
            final_amount = start_sum * (Decimal("1") + percent_years / (Decimal('12') * Decimal('100'))) ** months

            profit = final_amount - start_sum

            print(f"Итоговая сумма: {final_amount:.2f} руб.")
            print(f"Общая прибыль: {profit:.2f} руб.")

        case "7":
            float_1 = Fraction(0.75)
            float_2 = Fraction(5, 6)
            print(f"Сложение {float_1 + float_2}, Вычитание {float_1 - float_2}, Умножение {float_1 * float_2}, Деление {float_1 / float_2}" )
        case "8":
            current_datetime = datetime.now()
            print(f"Текущее дата и время {current_datetime}, Текущее дата {current_datetime.date()}, Текущее время {current_datetime.time()}")
        case "9":
            birthday = date(2004, 9, 29)


            today = date.today()


            days_passed = (today - birthday).days
            print(f"С момента рождения прошло дней: {days_passed}")

            next_birthday = date(today.year, birthday.month, birthday.day)

            if next_birthday < today:
                next_birthday = date(today.year + 1, birthday.month, birthday.day)

            days_to_birthday = (next_birthday - today).days
            print(f"До следующего дня рождения осталось дней: {days_to_birthday}")
        case "10":
            now_date = datetime.now()
            def format_datetime(date):

                months = {
                    1: "января", 2: "февраля", 3: "марта", 4: "апреля",
                    5: "мая", 6: "июня", 7: "июля", 8: "августа",
                    9: "сентября", 10: "октября", 11: "ноября", 12: "декабря"
                }
                
                # Форматируем дату и время
                day = date.day
                month = months[date.month]
                year = date.year
                time = date.strftime("%H:%M")
                
                return f"Сегодня {day} {month} {year} года, время: {time}"
            now_date = datetime.now()
            print(format_datetime(now_date))
        
        case "":
            break

