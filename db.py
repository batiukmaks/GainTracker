from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

def db_init():
    connection_string = 'mysql://root:000000@127.0.0.1:3306/gaintracker'
    engine = create_engine(connection_string, echo=True)
    Session = sessionmaker(bind=engine)
    db = Session()
    return db

db = db_init()

def get_db():
    return db