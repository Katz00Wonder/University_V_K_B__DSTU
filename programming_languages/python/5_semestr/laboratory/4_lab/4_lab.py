class Transport:
    def __init__(self, brand, speed):
        self.brand = brand
        self.speed = speed
    
    def move(self):
        print(f"Transport is moving at {self.speed} km/h")
    
    def __str__(self):
        return f"Transport: {self.brand}, Speed: {self.speed}"


class Car(Transport):
    def __init__(self, brand, speed, seats):
        super().__init__(brand, speed)
        self.seats = seats
    
    def honk(self):
        print("Beep beep!")
    
    def move(self):
        print(f"Car {self.brand} is driving at {self.speed} km/h")
    
    def __str__(self):
        return f"Transport: {self.brand}, Speed: {self.speed}, Seats: {self.seats}"
    
    def __len__(self):
        return self.seats
    
    def __eq__(self, other):
        if isinstance(other, Car):
            return self.speed == other.speed
        return False
    
    def __add__(self, other):
        if isinstance(other, Car):
            return self.speed + other.speed
        return NotImplemented


class Bike(Transport):
    def __init__(self, brand, speed, bike_type):
        super().__init__(brand, speed)
        self.type = bike_type
    
    def move(self):
        print(f"Bike {self.brand} is cycling at {self.speed} km/h")
    
    def __str__(self):
        return f"Transport: {self.brand}, Speed: {self.speed}, Type: {self.type}"


print("=== СОЗДАНИЕ ОБЪЕКТОВ ===")
transport1 = Transport("Generic Transport", 80)
car1 = Car("Toyota Camry", 120, 5)
car2 = Car("Honda Civic", 140, 4)
car3 = Car("BMW X5", 120, 5)
bike1 = Bike("Giant", 25, "mountain")
bike2 = Bike("Specialized", 30, "road")

print(f"Транспорт: {transport1}\n Машина 1: {car1}\n Машина 2: {car2}\n Машина 3: {car3}\n Велосипед 1: {bike1}\n Велосипед 2: {bike2}\n")

list_objects = [Transport("Generic Transport", 80), Car("Toyota Camry", 120, 5), Bike("Giant", 25, "mountain")]

for object in list_objects:
    print(object.move())