import sys
from PyQt5.QtWidgets import QApplication, QWidget, QPushButton, QMessageBox

class MyApp(QWidget):
    def __init__(self):
        super().__init__()
        self.initUI()

    def initUI(self):
        self.setWindowTitle('Пример PyQt5')
        self.setGeometry(100, 100, 300, 200)

        btn = QPushButton('Нажми меня', self)
        btn.clicked.connect(self.show_message)
        btn.resize(btn.sizeHint())
        btn.move(100, 70)

    def show_message(self):
        QMessageBox.information(self, 'Сообщение', 'Кнопка была нажата!')

if __name__ == '__main__':
    app = QApplication(sys.argv)
    ex = MyApp()
    ex.show()
    sys.exit(app.exec_())