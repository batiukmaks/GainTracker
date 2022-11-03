from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker

session = 'temp_init_holder'

def session_init():
    global session
    connection_string = 'mysql://root:000000@127.0.0.1:3306/gaintracker'
    engine = create_engine(connection_string, echo=True)
    Session = sessionmaker(bind=engine)
    session = Session()

def get_session():
    return session

session_init()