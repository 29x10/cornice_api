from couchdb.design import ViewDefinition
from couchdb.mapping import Document, TextField, ViewField, ListField
from cryptacular.bcrypt import BCRYPTPasswordManager


manager = BCRYPTPasswordManager()


def groupfinder(user_id, request):
    db = request.db
    result = db.view('_design/user/_view/by_user', key=user_id)
    groups = None
    if len(result):
        groups = result.rows[0].value.get('groups', None)
        if not groups:
            groups = None
    return groups


class User(Document):
    db_type = TextField(default='user')
    username = TextField()
    password = TextField()
    groups = ListField(TextField())
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
