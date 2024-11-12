import sys
import os
import importlib.util
import matplotlib.pyplot as plt
from PyQt5.QtGui import QIcon
from PyQt5.QtCore import Qt
from PyQt5.QtWidgets import QApplication, QMainWindow, QTreeWidget, QTreeWidgetItem, QPushButton, QTextEdit, QDockWidget, QWidget, QVBoxLayout, QInputDialog

class GUI(QMainWindow):
    def __init__(self, tasks):
        super().__init__()
        self.tasks = tasks
        self.initUI()

    def initUI(self):
        # Create widgets
        self.taskTree = QTreeWidget(self)
        self.taskTree.itemClicked.connect(self.runTask)
        self.resultText = QTextEdit(self)
        self.resultText.setReadOnly(True)
        self.inputButton = QPushButton('Input Text', self)
        self.inputButton.clicked.connect(self.inputText)

        # Set up layout
        self.setCentralWidget(self.taskTree)
        self.dockWidget = QDockWidget('Result', self)
        self.addDockWidget(Qt.RightDockWidgetArea, self.dockWidget)
        self.dockWidgetContents = QWidget()
        self.dockWidgetContents.setLayout(QVBoxLayout())
        self.dockWidgetContents.layout().addWidget(self.resultText)
        self.dockWidgetContents.layout().addWidget(self.inputButton)
        self.dockWidget.setWidget(self.dockWidgetContents)

        self.setWindowIcon(QIcon('icon.png'))

        # Populate task tree
        self.populateTaskTree()

    def populateTaskTree(self):
        self.taskTree.clear()
        for lab, tasks in self.tasks.items():
            labItem = QTreeWidgetItem(self.taskTree, [f'Laboratory Work {lab[4:]}'])
            for task in tasks:
                taskItem = QTreeWidgetItem(labItem, [f'Task {task[5:-3]}'])

    def runTask(self, item):
        if item.parent() is not None:
            lab = item.parent().text(0)
            task = item.text(0)
            taskPath = self.tasks[f'lab_{lab.split()[-1]}'][f'task_{task.split()[-1]}.py']
            spec = importlib.util.spec_from_file_location("module.name", taskPath)
            task_module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(task_module)
            try:
                text = task_module.get_text()
                entropy, hist = task_module.calculate_entropy_and_histogram(text)
                self.resultText.setText(f'Entropy: {entropy}'.replace('\t', ' '))
                self.plot_histogram(hist)
            except Exception as e:
                self.resultText.setText(f'Error: {str(e)}')

    def inputText(self):
        text, ok = QInputDialog.getMultiLineText(self, 'Input Text', 'Enter text:')
        if ok and text:
            taskPath = self.tasks[f'lab_{self.taskTree.currentItem().parent().text(0).split()[-1]}'][f'task_{self.taskTree.currentItem().text(0).split()[-1]}.py']
            spec = importlib.util.spec_from_file_location("module.name", taskPath)
            task_module = importlib.util.module_from_spec(spec)
            spec.loader.exec_module(task_module)
            try:
                entropy, hist = task_module.calculate_entropy_and_histogram(text)
                self.resultText.setText(f'Entropy: {entropy}')
                self.plot_histogram(hist)
            except Exception as e:
                self.resultText.setText(f'Error: {str(e)}')

    def plot_histogram(self, hist):
        sorted_hist = dict(sorted(hist.items()))
        plt.bar(sorted_hist.keys(), sorted_hist.values())
        plt.xlabel('Symbol')
        plt.ylabel('Frequency')
        plt.title('Symbol Frequency Histogram')
        plt.show()


def parse_tasks(directory):
    tasks = {}
    for lab in os.listdir(directory):
        labPath = os.path.join(directory, lab)
        if os.path.isdir(labPath) and lab.startswith('lab_'):
            tasks[lab] = {}
            for task in os.listdir(labPath):
                if task.startswith('task_') and task.endswith('.py'):
                    tasks[lab][task] = os.path.join(labPath, task)
    return tasks

def main():
    app = QApplication(sys.argv)
    tasks = parse_tasks('labs')
    gui = GUI(tasks)
    gui.show()
    sys.exit(app.exec_())

if __name__ == '__main__':
    main()
