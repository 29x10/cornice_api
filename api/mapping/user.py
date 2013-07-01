from couchdb.mapping import Document, TextField, ViewField, ListField
from cryptacular.bcrypt import BCRYPTPasswordManager


manager = BCRYPTPasswordManager()


def groupfinder(user_id, request):
    map_fun = User.by_user.map_fun
    db = request.db
    result = db.query(map_fun, key=user_id)
    groups = None
    if len(result):
        groups = result.rows[0].value.get('groups', None)
    return groups


class User(Document):
    db_type = TextField(default='user')
    username = TextField()
    password = TextField()
    groups = ListField(TextField())
    token = TextField()

    by_user = ViewField('user', '''
        function(doc) {
            if (doc.db_type == 'user') {
                emit(doc.username, doc);
            }
        }''')

    by_token = ViewField('user', '''
        function(doc) {
            if (doc.db_type == 'user') {
                emit(doc.token, doc);
            }
        }''')

    def __init__(self, username, password):
        Document.__init__(self)
        self.username = username
        self.password = manager.encode(password)
