from couchdb.mapping import Document, TextField, ListField


class Product(Document):
    spec =  TextField()
    brand = TextField()
    tags = ListField(TextField)
    images = ListField(TextField)
    instruction = TextField()