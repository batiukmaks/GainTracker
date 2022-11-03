from db import *
from models import *

session_init()
session = get_session()

maks = User(username='batiukmaks', email='email@gmail.com', password='qwerty123',
    first_name='Maks', last_name='Batiuk', sex='Male', birthday='2004-03-01')

alex = User(username='alex3000', email='emailalex@gmail.com', password='qwerty321',
    first_name='Alex', last_name='Alexovich', sex='Male', birthday='2004-02-09')

session.add_all([maks, alex])
session.commit()

for user in session.query(User).all():
    print(user.first_name, user.last_name, user.birthday)
