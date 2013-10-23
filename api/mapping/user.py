from couchdb.design import ViewDefinition
from couchdb.mapping import Document, TextField, ListField
from cryptacular.bcrypt import BCRYPTPasswordManager
import requests


manager = BCRYPTPasswordManager()


def groupfinder(user_id, request):
    url = 'http://localhost:5001/users/' + user_id
    r = requests.get(url)
    groups = r.json()['groups']
    if groups:
        return groups
    return None


class User(Document):
    db_type = TextField(default='user')
    username = TextField()
    password = TextField()
    groups = ListField(TextField(), default=["client"])
    token = TextField()


    by_user = ViewDefinition('user', 'by_user', '''
        function(doc) {
            if (doc.db_type == 'user') {
                emit(doc.username, doc);
            }
        }''')


    def __init__(self, username, password):
        super(User, self).__init__()
        self.username = username
        self.password = manager.encode(password)
