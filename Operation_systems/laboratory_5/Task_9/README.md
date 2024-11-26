Используя справочную систему, ознакомиться с ключами утилиты ls -R, -1 (единица), -m, --color, ключи, определяющие порядок вывода.
Ключи утилиты ls
Основные ключи

-R (рекурсивный вывод)

    Описание: Рекурсивно выводит содержимое каталогов.
    Пример:

    ls -R /path/to/directory

-1 (единица)

    Описание: Выводит файлы в одну колонку.
    Пример:

    ls -1 /path/to/directory

-m (запятая)

    Описание: Выводит файлы, разделенные запятыми.
    Пример:

    ls -m /path/to/directory

--color

    Описание: Выводит файлы с цветовой разметкой (например, каталоги могут быть синими, исполняемые файлы — зелеными и т.д.).


Ключи, определяющие порядок вывода

-a (все файлы)

    Описание: Выводит все файлы, включая скрытые (начинающиеся с точки).
    Пример:

    ls -a /path/to/directory

-t (по времени)

    Описание: Сортирует файлы по времени последнего изменения (самые новые первыми).
    Пример:

    ls -t /path/to/directory

-S (по размеру)

    Описание: Сортирует файлы по размеру (самые большие первыми).
    Пример:

    ls -S /path/to/directory

-r (обратный порядок)

    Описание: Выводит файлы в обратном порядке.
    Пример:
ls -r /path/to/directory

-X (по расширению)

    Описание: Сортирует файлы по расширению.
    Пример:

    ls -X /path/to/directory

Примеры комбинированного использования ключей
Рекурсивный вывод с цветовой разметкой:

ls -R --color /path/to/directory

Информацию про ls можете узнать, использовав команды или man ls, или ls --help