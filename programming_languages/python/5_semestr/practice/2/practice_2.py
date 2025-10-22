
def logger(func):
    """Декоратор для логирования вызовов функций и их результатов"""
    def wrapper(*args, **kwargs):
        
        print(f"Вызов функции {func.__name__} с аргументами {args} и {kwargs}")
        
        result = func(*args, **kwargs)
        
        print(f"Функция {func.__name__} вернула {result}")
        
        return result
    return wrapper



@logger
def add(number_1, number_2):
    return number_1 + number_2

@logger
def divide(number_1, number_2):
    if number_2 == 0:
        return "Ошибка: деление на ноль"
    return number_1 / number_2

@logger
def greet(name):
    return f"Привет, {name}!"


def require_role(allowed_roles):
    def decorator(func):
        def wrapper(user, *args, **kwargs):
            if user.get('role') in allowed_roles:
                return func(user, *args, **kwargs)
            else:
                print(f"Доступ запрещён пользователю {user['name']}")
                return None
        return wrapper
    return decorator



@require_role(["admin"])
def delete_database(user):
    print(f"База данных удалена пользователем {user['name']}")
    return "База данных успешно удалена"

@require_role(["admin", "manager"])
def edit_settings(user):
    print(f"Настройки изменены пользователем {user['name']}")
    return "Настройки успешно изменены"

@require_role(["admin", "manager", "user"])
def view_data(user):
    print(f"Данные просмотрены пользователем {user['name']}")
    return "Данные успешно загружены"

@require_role(["admin"])
def manage_users(user):
    print(f"Пользователи управляются администратором {user['name']}")
    return "Управление пользователями завершено"


users = [
    {"name": "Артём", "role": "admin"},
    {"name": "Мария", "role": "manager"},
    {"name": "Виталик", "role": "user"},
    {"name": "Вика", "role": "guest"},
    {"name": "Петр", "role": "admin"},
]


def test_access():
    print("=== ТЕСТИРОВАНИЕ ДОСТУПА ===")
    

    functions = [delete_database, edit_settings, view_data, manage_users]
    
    for func in functions:
        print(f"\n--- Тестируем функцию: {func.__name__} ---")
        for user in users:
            print(f"\nПользователь: {user['name']} (роль: {user['role']})")
            result = func(user)
            if result:
                print(f"Результат: {result}")


@require_role(["admin", "manager"])
def create_report(user, report_type, pages):
    print(f"Отчет типа '{report_type}' создан пользователем {user['name']}")
    return f"Отчет '{report_type}' на {pages} страниц создан"


def test_with_arguments():
    print("\n\n=== ТЕСТИРОВАНИЕ С ДОПОЛНИТЕЛЬНЫМИ АРГУМЕНТАМИ ===")
    
    admin_user = {"name": "Артём", "role": "admin"}
    regular_user = {"name": "Виталик", "role": "user"}
    
    print("\nАдминистратор создает отчет:")
    result1 = create_report(admin_user, "финансовый", 10)
    print(f"Результат: {result1}")
    
    print("\nОбычный пользователь пытается создать отчет:")
    result2 = create_report(regular_user, "технический", 5)
    print(f"Результат: {result2}")

if __name__ == "__main__":
    print("=== Тестирование функции add ===")
    result1 = add(5, 3)
    print(f"Результат: {result1}\n")
    
    print("=== Тестирование функции divide ===")
    result2 = divide(10, 2)
    print(f"Результат: {result2}\n")
    
    result3 = divide(10, 0)
    print(f"Результат: {result3}\n")
    
    print("=== Тестирование функции greet ===")
    result4 = greet("Анна")
    print(f"Результат: {result4}\n")
    
    test_access()
    test_with_arguments()