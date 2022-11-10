from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

db = 'temp_init_holder'

def db_init():
    global db
    connection_string = 'mysql://root:000000@127.0.0.1:3306/gaintracker'
    engine = create_engine(connection_string, echo=True)
    Session = sessionmaker(bind=engine)
    db = Session()

def get_db():
    return db

# db_init()